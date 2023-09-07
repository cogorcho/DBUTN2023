using System;
using System.IO;
using System.Collections;
using Microsoft.Data.SqlClient;
using System.Data.SqlClient;
using System.Data;

namespace DBUtn {
	class Program {
		public static void Main(string[] args) {
			SqlConnectionStringBuilder builder = new SqlConnectionStringBuilder();

			builder.DataSource = "localhost";
			builder.UserID = "sa";
			builder.Password = "Soler225";
			builder.Password = "Soler225";
			builder.TrustServerCertificate=true;
			builder.InitialCatalog = "dbutn";

			string dirtablas = "/home/juan/dev/dbutn/sqlserver/tablas";
			Console.WriteLine(dirtablas);
			List<string> tablas = new List<string>();

			foreach(string s in Directory.GetFiles(dirtablas,"00*.sql")) {
				tablas.Add(s);
			}
			tablas.Sort();

			try {
				SqlConnection conn = new SqlConnection(builder.ConnectionString);
				SqlCommand cmd = new SqlCommand("Select getdate()", conn);
				conn.Open();

				Console.WriteLine("Connected to {0}", conn.Database);

				cmd.CommandText = "DROP DATABASE UTN001";
				cmd.ExecuteNonQuery();
				Console.WriteLine("DROP DATABASE UTN001 OK");

				cmd.CommandText = "CREATE DATABASE UTN001";
				cmd.ExecuteNonQuery();
				Console.WriteLine("CREATE DATABASE UTN001 OK");

				conn.ChangeDatabase("UTN001");	
				Console.WriteLine("Connected to {0}", conn.Database);

				Console.WriteLine("Creando tablas");
				foreach(string s in tablas) {
					Console.Write(".");
					string sql = File.ReadAllText(s);
					cmd.CommandText = sql.Replace("auto_increment","IDENTITY(1,1)");
					cmd.ExecuteNonQuery();
				}
				Console.WriteLine();

				string xsql = "select table_name from information_schema.tables";
				cmd.CommandText = xsql;
				SqlDataReader reader = cmd.ExecuteReader();
				while (reader.Read())
            			{
                			Console.WriteLine(String.Format("\t{0}", reader[0]));
            			}

				conn.Close();
				Console.WriteLine("Disconnected");
			}
			catch(Exception e) {
				Console.WriteLine(e.Message);
			}
		}
	}
}
