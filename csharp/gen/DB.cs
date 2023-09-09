using System;
using System.IO;
using System.Text.RegularExpressions;
using System.Collections;
using Microsoft.Data.SqlClient;
using System.Data.SqlClient;
using System.Data;
using System.Text;
using System.Text.Json;
using System.Text.Json.Serialization;


namespace DBUtn {
	class DB {
		SqlConnectionStringBuilder builder = new SqlConnectionStringBuilder();
		string dirtablas;
		string dirprocs;
		string dbname;
		List<string> tablas = new List<string>();
		List<string> tablascreadas = new List<string>();
		List<string> procedures = new List<string>();
		List<Parametro> parametros = new List<Parametro>();
		DatosConexion dataconn;
		SqlConnection dbConn; 
		SqlCommand cmd;
		string[] BaseProcs= {"GenDelete", "GenUpdate", "GenInsert", "GetErrorInfo"};
		Boolean debug = false;

		private void log(string mensaje) {
			if (debug)
				Console.WriteLine(mensaje);
			else
				Console.Write(".");
		}
		private void logerr(string mensaje) {
			Console.WriteLine(mensaje);
		}
		public DB(string dirsql, string dbname, DatosConexion dataconn) {
			this.dirtablas = dirsql + "tablas";
			this.dirprocs = dirsql + "sprocs";
			this.dbname = dbname;
			this.dataconn = dataconn;
			if (!connect())
				return;
		}

		private Boolean connect() {
			try {
				builder.DataSource = dataconn.DataSource;
				builder.UserID = dataconn.UserID;
				builder.Password = dataconn.Password;
				builder.TrustServerCertificate = dataconn.TrustServerCertificate;
				builder.InitialCatalog = dataconn.InitialCatalog;
				dbConn = new SqlConnection(builder.ConnectionString);

				cmd = new SqlCommand("Select getdate()", dbConn);
				dbConn.Open();
				log($"Conectado a {dbConn.Database}.");
			}
			catch(Exception e) {
				logerr($"Error de conexion a la Base de datos {dataconn.InitialCatalog}");
				logerr(e.Message);
				return false;
			}
			return true;
		}

		private Boolean cargarTablas() {
			try {
				foreach(string s in Directory.GetFiles(dirtablas,"00*.sql")) {
					tablas.Add(s);
				}
				tablas.Sort();
			}
			catch(Exception e) {
				logerr($"Error cargando tablas desde {dirtablas}");
				logerr(e.Message);
				return false;
			}
			return true;
		}

		private Boolean dropDB() {
			try {
				cmd.CommandText = $"DROP DATABASE {dbname}";
				cmd.ExecuteNonQuery();
				log($"DROP DATABASE {dbname} OK");
				return true;
			}
			catch(SqlException e) {
				logerr($"Error ejecutando {cmd.CommandText}.");
				logerr($"{e.Message} ({e.Number})");
				if (e.Number == 3701) {
					logerr("Continuamos");
					return true;
				}
				return false;
			}
		}

		private Boolean createDB() {
			try {
				cmd.CommandText = $"CREATE DATABASE {dbname}";
				cmd.ExecuteNonQuery();
				log($"CREATE DATABASE {dbname} OK");
				dbConn.ChangeDatabase(dbname);
				return true;
			}
			catch(Exception e) {
				logerr($"Error ejecutando {cmd.CommandText}.");
				logerr(e.Message);
				return false;
			}
		}

		private Boolean crearTablas() {
			Boolean Ok = true;
			foreach(string s in tablas) {
				string vt = Regex.Replace(s.Split('/').Last().Replace(".sql",""),"00._","");
				log($"Creando la tabla {vt}");
				try {
					string sql = File.ReadAllText(s);
					cmd.CommandText = sql.Replace("auto_increment","IDENTITY(1,1)");
					cmd.ExecuteNonQuery();
					log($"Tabla {vt} creada Ok");
				}
				catch(Exception e) {
					logerr($"Error creando tabla {vt}.");
					logerr(e.Message);
					Ok = false;
					break;
				}
			}
			return Ok;
		}

		private Boolean listarTablas() {
			try {
				log($"\nLista de Tablas Creadas:");
				string xsql = "select table_name from information_schema.tables";
				cmd.CommandText = xsql;
				SqlDataReader reader = cmd.ExecuteReader();
				while (reader.Read())
	            {
					tablascreadas.Add(String.Format("{0}",reader[0]));
	            	log(String.Format("\t{0}", reader[0]));
	            }
				reader.Close();
	        }
			catch(Exception e) {
				logerr($"Error listando tablas.");
				logerr(e.Message);
				return false;
			}
			return true;
		}

		private Boolean genBaseProcs() {
			foreach (string s in BaseProcs) {
				string sp = $"{dirprocs}/{s}.sql";
				string vs = Regex.Replace(s.Split('/').Last().Replace(".sql",""),"00._","");
				log($"Creando la Stored Procedure {vs}");
				try {
					string sql = File.ReadAllText(sp);
					cmd.CommandText = sql;
					cmd.ExecuteNonQuery();
					log($"Stored Procedure {vs} creada Ok");
				}
				catch(Exception e) {
					logerr($"Error creando Stored Procedure {vs}.");
					logerr(e.Message);
					return false;
				}
			}
			return true;
		}

		private Boolean genAPIProcs() {
			StringBuilder sb = new StringBuilder();
			foreach(String t in tablascreadas) {
				foreach (string s in BaseProcs) {
					if (s.StartsWith("Gen")) {
						try {
							cmd.CommandText = $"{s} @tab={t}";
							log($"Ejecutando {s} para {t}");
							SqlDataReader reader = cmd.ExecuteReader();
							while (reader.Read())
	            			{
								sb.Append(String.Format("{0}{1}",reader[0], Environment.NewLine));
							}
							reader.Close();
							cmd.CommandText = sb.ToString();
							cmd.ExecuteNonQuery();
							log($"Stored Procedure creada Ok");
							sb.Clear();
						}
						catch(Exception e) {
							logerr($"Error ejecutando Stored Procedure {s} para la tabla {t}.");
							logerr(e.Message);
							logerr(sb.ToString());
							return false;
						}
					}
					else {
						continue;
					}
				}
			}
			return true;
		}

		private Boolean cargarSprocs() {
			
			string sql = @"select SPECIFIC_NAME from information_schema.routines 
					where SUBSTRING(SPECIFIC_NAME,1,1) in ('I','U','D') ";
			try {
				cmd.CommandText = sql;
				SqlDataReader reader = cmd.ExecuteReader();
				while (reader.Read())
				{
					procedures.Add(reader[0].ToString());
				}
				reader.Close();
			} catch(Exception e) {
				logerr($"Error cargando parametros.");
				logerr(e.Message);
				return false;				
			}
			return true;
		}

		private Boolean cargarParametros() {
			string sql = @$"select SPECIFIC_NAME , ORDINAL_POSITION, PARAMETER_NAME , 
							PARAMETER_MODE , DATA_TYPE , ISNULL(CHARACTER_MAXIMUM_LENGTH,0)
							from information_schema.parameters
							where SUBSTRING(SPECIFIC_NAME,1,1) IN ('I','D','U')
							and SPECIFIC_CATALOG  = '{this.dbname}'
							and SPECIFIC_SCHEMA  = 'dbo'
							order by SPECIFIC_NAME , ORDINAL_POSITION ";
			try {
				cmd.CommandText = sql;
				SqlDataReader reader = cmd.ExecuteReader();
				while (reader.Read())
				{
					parametros.Add(new Parametro(
						reader[0].ToString(), reader.GetInt32(1), reader[2].ToString(),
						reader[3].ToString(), reader[4].ToString(), reader.GetInt32(5))
					);
				}
				reader.Close();

			} catch(Exception e) {
				logerr($"Error cargando parametros.");
				logerr(e.Message);
				return false;				
			}
			return true;
		}

		private void parametrosPorProcedure() {
			foreach(string s in procedures) {
				List<Parametro> p  = parametros.FindAll(i => i.Procedure == s);
				Console.WriteLine($@"Procedure: {s} {p.Count}");
				foreach(Parametro x in p)
					Console.WriteLine(JsonSerializer.Serialize(x));
			}
		}
		public void hacerTodo() {
			if (cargarTablas() && dropDB() && createDB() && crearTablas() 
				&& listarTablas() && genBaseProcs() && genAPIProcs() 
				&& cargarSprocs() && cargarParametros()) 
			{
				parametrosPorProcedure();
				Console.WriteLine("Todo OK");
			}
			else {
				Console.WriteLine("Todo mal...");
			}
			if (dbConn.State == ConnectionState.Open)
				dbConn.Close();
		}

		public void procesar() {
			if (!cargarTablas())
				return;
			if (!dropDB())
				return;
			if (!createDB())
				return;
			if (!crearTablas())
				return;
			if (!listarTablas())
				return;
			if (!genBaseProcs())
				return;
			if (!genAPIProcs())
				return;
			dbConn.Close();
		}	
	}
}
