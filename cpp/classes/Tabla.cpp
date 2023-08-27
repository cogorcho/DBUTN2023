#include <Tabla.h>
#include <sstream>
#include <fstream>

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
    stringstream ss;
    ss << "class " << initcap(nombre) << " {" << endl;
    ss << "\tprivate:" << endl;
    for (Columna col : cols) {
        ss << "\t\t";
        if (col.tipo ==  "int")
            ss << "int " << col.nombre << ";";
        else if (col.tipo ==  "varchar")
            ss << "string " << col.nombre << ";";
        else if (col.tipo ==  "char")
            ss << "string " << col.nombre << ";";
        else if (col.tipo ==  "date")
            ss << "string " << col.nombre << ";";
        else if (col.tipo ==  "enum")
            ss << "int " << col.nombre << ";";
        else 
            ss << col.tipo << " " << col.nombre << ";";
        ss << endl;
    }
    ss << "\tpublic:" << endl;
    int cnt = 0;
    
    ss << "\t\t" << initcap(nombre) << "(";
    for (Columna col : cols) {
        if (col.tipo ==  "int")
            ss << (cnt == 0 ? "": ", ") << "int";
        else if (col.tipo ==  "varchar")
            ss << (cnt == 0 ? "": ", ") << "string";
        else if (col.tipo ==  "char")
            ss << (cnt == 0 ? "": ", ") << "string";
        else if (col.tipo ==  "date")
            ss << (cnt == 0 ? "": ", ") << "string";
        else if (col.tipo ==  "enum")
            ss << (cnt == 0 ? "": ", ") << "int";
        else 
            ss << (cnt == 0 ? "": ", ") << col.tipo;
        cnt = 1;
    }
    ss << ");" << endl;
    for (Columna col : cols) {
        if (col.tipo ==  "int")
            ss << "\t\t" << col.tipo << " get" << initcap(col.nombre) << " { return " << col.nombre << "; }" << endl;
        else if (col.tipo ==  "varchar")
            ss << "\t\tstring get" << initcap(col.nombre) << " { return " << col.nombre << "; }" << endl;
        else if (col.tipo ==  "char")
            ss << "\t\tstring get" << initcap(col.nombre) << " { return " << col.nombre << "; }" << endl;
        else if (col.tipo ==  "date")
            ss << "\t\tstring get" << initcap(col.nombre) << " { return " << col.nombre << "; }" << endl;
        else if (col.tipo ==  "enum")
            ss << "\t\tint get" << initcap(col.nombre) << " { return " << col.nombre << "; }" << endl;
        else 
            ss << "\t\t" << col.tipo << " get" << initcap(col.nombre) << " { return " << col.nombre << "; }" << endl;
    }    
    ss << "};" << endl;
    ofstream fw("classes/" + initcap(nombre) + ".cpp", std::ofstream::out);
    if (fw.is_open())
    {
        fw << ss.str();
        fw.close();
    }
    else {
        cout << "fw not open: D_" << nombre << endl;
    }
}

void Tabla::genDelete() {
    stringstream ss;
    ss << "DELIMITER //" << endl;
    ss << "DROP PROCEDURE IF EXISTS D_" << nombre << ";" << endl;
    ss << "CREATE PROCEDURE D_" << nombre << "(IN INT P_ID)" << endl;
    ss << "BEGIN" << endl;
    ss << "\tDELETE FROM " << nombre << " WHERE ID = P_ID;" << endl;
    ss << "END//" << endl;
    ss << "DELIMITER ;" << endl;
    cout << ss.str();
    ofstream fw("storedprocedures/D_" + nombre + ".sql", std::ofstream::out);
    if (fw.is_open())
    {
        fw << ss.str();
        fw.close();
    }
    else {
        cout << "fw not open: D_" << nombre << endl;
    }
}

void Tabla::genUpdate() {
    stringstream ss;
    ss << "DELIMITER //" << endl;
    ss << "DROP PROCEDURE IF EXISTS U_" << nombre << ";" << endl;
    ss << "CREATE PROCEDURE U_" << nombre << "(" << endl;
    int cnt = 0;
    for (Columna col : cols) {
        if (cnt == 0) {
            ss << "\t p_" << col.nombre << " " << col.texto <<  endl;
            cnt = 1;
        }
        else {
            ss << "\t,p_" << col.nombre << " " << col.texto << endl;
        }
    }    

    ss << ")" << endl << "BEGIN" << endl;
    ss << "\t" << "UPDATE " << nombre << " SET" << endl;
    cnt = 0;
    for (Columna col : cols) {
        if (col.isPk == 1)
            continue;
        if (cnt == 0) {
            ss << "\t  " << col.nombre << " = p_" << col.nombre << endl;
            cnt = 1;
        }
        else {
            ss << "\t ," << col.nombre << " = p_" << col.nombre << endl;
        }
    }
    ss << "\tWHERE ";
    cnt = 0;
    for (Columna col : cols) {
        if (col.isPk == 0)
            continue;
        if (cnt == 0) {
            ss << col.nombre << " = p_" << col.nombre << endl;
            cnt = 1;
        }
        else {
            ss << "\t  AND " << col.nombre << " = p_" << col.nombre << endl;
        }
    }

    ss << "END//" << endl;
    ss << "DELIMITER ;" << endl;
    cout << ss.str();
    ofstream fw("storedprocedures/U_" + nombre + ".sql", std::ofstream::out);
    if (fw.is_open())
    {
        fw << ss.str();
        fw.close();
    }
    else {
        cout << "fw not open: U_" << nombre << endl;
    }
}

void Tabla::genInsert() {
    stringstream ss;
    ss << "DELIMITER //" << endl;
    ss << "DROP PROCEDURE IF EXISTS I_" << nombre << ";" << endl;
    ss << "CREATE PROCEDURE I_" << nombre << "(" << endl;
    int cnt = 0;
    string coma = "";
    for (Columna col : cols) {
        if (cnt == 0) {
            if (col.isPk == 1) {
                ss << "\t" << coma << "p_" << col.nombre << " " << col.texto << " OUT" << endl;
            }
            else {
                ss << "\t" << coma << "p_" << col.nombre << " " << col.texto << " OUT" << endl;
            }
            coma = ",";
            cnt = 1;
        }
        else {
            ss << "\t" << coma << "p_" << col.nombre << " " << col.texto << endl;
        }
    }

    ss << "BEGIN" << endl;
    ss << "\tINSERT INTO " << nombre << "(";
    cnt = 0;    
    for (Columna col : cols) {
        if ( col.isPk )
            continue;
        if (cnt == 0) {
            ss << col.nombre;
            cnt = 1;
        }
        else {
            ss << ", " << col.nombre;
        }
    }
    ss << ")" << endl;
    ss << "\tVALUES (";
    cnt = 0;    
    for (Columna col : cols) {
        if ( col.isPk )
            continue;
        if (cnt == 0) {
            ss << "p_" << col.nombre;
            cnt = 1;
        }
        else {
            ss << ", _" << col.nombre;
        }
    }
    ss << ")" << endl;

    ss << "END//" << endl;
    ss << "DELIMITER ;" << endl;
    cout << ss.str();
    ofstream fw("storedprocedures/I_" + nombre + ".sql", std::ofstream::out);
    if (fw.is_open())
    {
        fw << ss.str();
        fw.close();
    }
    else {
        cout << "fw not open: I_" << nombre << endl;
    }

}