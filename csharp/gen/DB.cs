using System;
using System.IO;
using System.Text.RegularExpressions;
using System.Collections;
using Microsoft.Data.SqlClient;
using System.Data.SqlClient;
using System.Data;
using System.Text;


namespace DBUtn {
	class DB {
		SqlConnectionStringBuilder builder = new SqlConnectionStringBuilder();
		string dirtablas;
		string dirprocs;
		string dbname;
		List<string> tablas = new List<string>();
		List<string> tablascreadas = new List<string>();
		DatosConexion dataconn;
		SqlConnection dbConn; 
		SqlCommand cmd;
		string[] BaseProcs= {"GenDelete", "GenUpdate", "GenInsert", "GetErrorInfo"};

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
				Console.WriteLine("Conectado a {0}.", dbConn.Database);
			}
			catch(Exception e) {
				Console.WriteLine($"Error de conexion a la Base de datos {dataconn.InitialCatalog}");
				Console.WriteLine(e.Message);
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
				Console.WriteLine($"Error cargando tablas desde {dirtablas}");
				Console.WriteLine(e.Message);
				return false;
			}
			return true;
		}

		private Boolean dropDB() {
			try {
				cmd.CommandText = $"DROP DATABASE {dbname}";
				cmd.ExecuteNonQuery();
				Console.WriteLine($"DROP DATABASE {dbname} OK");
				return true;
			}
			catch(SqlException e) {
				Console.WriteLine($"Error ejecutando {cmd.CommandText}.");
				Console.WriteLine($"{e.Message} ({e.Number})");
				if (e.Number == 3701) {
					Console.WriteLine("Continuamos");
					return true;
				}
				return false;
			}
		}

		private Boolean createDB() {
			try {
				cmd.CommandText = $"CREATE DATABASE {dbname}";
				cmd.ExecuteNonQuery();
				Console.WriteLine($"CREATE DATABASE {dbname} OK");
				dbConn.ChangeDatabase(dbname);
				return true;
			}
			catch(Exception e) {
				Console.WriteLine($"Error ejecutando {cmd.CommandText}.");
				Console.WriteLine(e.Message);
				return false;
			}
		}

		private Boolean crearTablas() {
			Boolean Ok = true;
			foreach(string s in tablas) {
				string vt = Regex.Replace(s.Split('/').Last().Replace(".sql",""),"00._","");
				Console.WriteLine($"Creando la tabla {vt}");
				try {
					string sql = File.ReadAllText(s);
					cmd.CommandText = sql.Replace("auto_increment","IDENTITY(1,1)");
					cmd.ExecuteNonQuery();
					Console.WriteLine($"Tabla {vt} creada Ok");
				}
				catch(Exception e) {
					Console.WriteLine($"Error creando tabla {vt}.");
					Console.WriteLine(e.Message);
					Ok = false;
					break;
				}
			}
			return Ok;
		}

		private Boolean listarTablas() {
			try {
				Console.WriteLine($"\nLista de Tablas Creadas:");
				string xsql = "select table_name from information_schema.tables";
				cmd.CommandText = xsql;
				SqlDataReader reader = cmd.ExecuteReader();
				while (reader.Read())
	            {
					tablascreadas.Add(String.Format("{0}",reader[0]));
	            	Console.WriteLine(String.Format("\t{0}", reader[0]));
	            }
				reader.Close();
	        }
			catch(Exception e) {
				Console.WriteLine($"Error listando tablas.");
				Console.WriteLine(e.Message);
				return false;
			}
			return true;
		}

		private Boolean genBaseProcs() {
			foreach (string s in BaseProcs) {
				string sp = $"{dirprocs}/{s}.sql";
				string vs = Regex.Replace(s.Split('/').Last().Replace(".sql",""),"00._","");
				Console.WriteLine($"Creando la Stored Procedure {vs}");
				try {
					string sql = File.ReadAllText(sp);
					cmd.CommandText = sql;
					cmd.ExecuteNonQuery();
					Console.WriteLine($"Stored Procedure {vs} creada Ok");
				}
				catch(Exception e) {
					Console.WriteLine($"Error creando Stored Procedure {vs}.");
					Console.WriteLine(e.Message);
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
							Console.WriteLine($"Ejecutando {s} para {t}");
							SqlDataReader reader = cmd.ExecuteReader();
							while (reader.Read())
	            			{
								sb.Append(String.Format("{0}{1}",reader[0], Environment.NewLine));
							}
							reader.Close();
							cmd.CommandText = sb.ToString();
							cmd.ExecuteNonQuery();
							Console.WriteLine($"Stored Procedure creada Ok");
							sb.Clear();
						}
						catch(Exception e) {
							Console.WriteLine($"Error ejecutando Stored Procedure {s} para la tabla {t}.");
							Console.WriteLine(e.Message);
							Console.WriteLine(sb.ToString());
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

		public void hacerTodo() {
			if (cargarTablas() && dropDB() && createDB() && crearTablas() 
				&& listarTablas() && genBaseProcs() && genAPIProcs()) 
			{
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
