using System;

namespace DBUtn {
	class DatosConexion {
		public string DataSource;
		public string UserID;
		public string Password;
		public Boolean TrustServerCertificate;
		public string InitialCatalog;

		public DatosConexion() {}

		public DatosConexion(string ds, string user, string pass, Boolean trcert, string cata) {
			this.DataSource = ds;
			this.UserID = user;
			this.Password = pass;
			this.TrustServerCertificate = trcert;
			this.InitialCatalog = cata;
		}

	}
}
