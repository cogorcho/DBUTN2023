#include <Tabla.h>
//#include <boost/algorithm/string.hpp>

string Tabla::initcap(string text) {
	for (int x = 0; x < (int)text.length(); x++)
	{
		if (x == 0)
		{
			text[x] = toupper(text[x]);
		}
		else if (text[x - 1] == ' ')
		{
			text[x] = toupper(text[x]);
		}
	}
	return text;
}


void Tabla::print() {
    cout << "#---------------------------------------------" << endl;
    cout << "#---- Tabla: " << initcap(nombre) << endl;
    cout << "#---------------------------------------------" << endl;
    for (auto col : cols) 
        col.print();

}

void Tabla::cargar_columnas(sql::ResultSet *rs) {
    while (rs->next()) {
        cols.push_back(Columna(rs));
    }
}

Tabla::Tabla(sql::Connection *con, string tabla) {
    SQL = "Select ordinal_position, column_name, data_type, concat('',ifnull(character_maximum_length,0)), ifnull(column_key,'NO') from information_schema.columns where table_schema = 'employees' and table_name = 'TNAME' order by ordinal_position";
    REPLACE = "TNAME";
    nombre = tabla;
    sql::Statement * stmt = con->createStatement();
    SQL.replace(SQL.find(REPLACE),REPLACE.length(),nombre);
    cargar_columnas(stmt->executeQuery(SQL.c_str()));
}

void Tabla::genClass() {
    cout << "class " << initcap(nombre) << " {" << endl;
    cout << "\tprivate:" << endl;
    for (Columna col : cols) {
        cout << "\t\t";
        if (col.tipo ==  "int")
            cout << "int " << col.nombre << ";";
        else if (col.tipo ==  "varchar")
            cout << "string " << col.nombre << ";";
        else if (col.tipo ==  "char")
            cout << "string " << col.nombre << ";";
        else if (col.tipo ==  "date")
            cout << "string " << col.nombre << ";";
        else if (col.tipo ==  "enum")
            cout << "int " << col.nombre << ";";
        else 
            cout << col.tipo << " " << col.nombre << ";";
        cout << endl;
    }
    cout << "\tpublic:" << endl;
    int cnt = 0;
    
    cout << "\t\t" << initcap(nombre) << "(";
    for (Columna col : cols) {
        if (col.tipo ==  "int")
            cout << (cnt == 0 ? "": ", ") << "int";
        else if (col.tipo ==  "varchar")
            cout << (cnt == 0 ? "": ", ") << "string";
        else if (col.tipo ==  "char")
            cout << (cnt == 0 ? "": ", ") << "string";
        else if (col.tipo ==  "date")
            cout << (cnt == 0 ? "": ", ") << "string";
        else if (col.tipo ==  "enum")
            cout << (cnt == 0 ? "": ", ") << "int";
        else 
            cout << (cnt == 0 ? "": ", ") << col.tipo;
        cnt = 1;
    }
    cout << ");" << endl;
    for (Columna col : cols) {
        if (col.tipo ==  "int")
            cout << "\t\t" << col.tipo << " get" << initcap(col.nombre) << " { return " << col.nombre << "; }" << endl;
        else if (col.tipo ==  "varchar")
            cout << "\t\tstring get" << initcap(col.nombre) << " { return " << col.nombre << "; }" << endl;
        else if (col.tipo ==  "char")
            cout << "\t\tstring get" << initcap(col.nombre) << " { return " << col.nombre << "; }" << endl;
        else if (col.tipo ==  "date")
            cout << "\t\tstring get" << initcap(col.nombre) << " { return " << col.nombre << "; }" << endl;
        else if (col.tipo ==  "enum")
            cout << "\t\tint get" << initcap(col.nombre) << " { return " << col.nombre << "; }" << endl;
        else 
            cout << "\t\t" << col.tipo << " get" << initcap(col.nombre) << " { return " << col.nombre << "; }" << endl;
    }    
    cout << "};" << endl;
}

void Tabla::genDelete() {
    cout << "DELIMITER //" << endl;
    cout << "DROP PROCEDURE IF EXISTS D_" << nombre << ";" << endl;
    cout << "CREATE PROCEDURE D_" << nombre << "(IN INT P_ID)" << endl;
    cout << "BEGIN" << endl;
    cout << "\tDELETE FROM " << nombre << " WHERE ID = P_ID;" << endl;
    cout << "END//" << endl;
    cout << "DELIMITER ;" << endl;
}