using System;

namespace DBUtn {
	class Parametro {
        public string Procedure  { get; set; }
		public int Posicion  { get; set; }
		public string Nombre  { get; set; }
		public string Modo  { get; set; }
		public string Tipo  { get; set; }
		public int Largo  { get; set; }

		public Parametro() {}

		public Parametro(string procedure, int posicion, string nombre, string modo, string tipo, int largo) {
			this.Procedure = procedure;
            this.Posicion = posicion;
			this.Nombre = nombre;
			this.Modo = modo;
			this.Tipo = tipo;
			this.Largo = largo;
            //Console.WriteLine($"Parametro {nombre} de {procedure} cargado");
		}

        //public override string ToString() {
        //    return @$"{this.posicion}) {this.nombre} {this.modo} {this.tipo} ({this.largo})";
        //}

	}
}
