using System;
using System.IO;
using System.Collections;
using Microsoft.Data.SqlClient;
using System.Data.SqlClient;
using System.Data;

namespace DBUtn {
	class Program {
		public static void Main(string[] args) {
			string dirsql = "/home/juan/dev/DBUTN2023/sqlserver/";
			DatosConexion dconn = new DatosConexion("localhost", "sa", "Soler225", true, "master");
			DB db = new DB(dirsql, "Boquita", dconn);
			db.hacerTodo();
		}
	}
}
