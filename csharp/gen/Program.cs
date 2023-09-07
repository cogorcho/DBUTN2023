using System;
using System.IO;
using System.Collections;
using Microsoft.Data.SqlClient;
using System.Data.SqlClient;
using System.Data;

namespace DBUtn {
	class Program {
		public static void Main(string[] args) {
			string dirsql = "/home/juan/dev/dbutn/sqlserver/";
			DatosConexion dconn = new DatosConexion("localhost", "sa", "Soler225", true, "dbutn");
			DB db = new DB(dirsql, "Boquita", dconn);
			db.hacerTodo();
		}
	}
}
