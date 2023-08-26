#include <Columna.h>

Columna::Columna(sql::ResultSet * rs) {
    orden = rs->getInt(1);
    nombre = rs->getString(2);
    tipo = rs->getString(3);
    tamanio = rs->getInt(4);
    texto = (rs->getString(4) != "0" ?  (rs->getString(3)  + "(" + rs->getString(4) +  ")" ): rs->getString(3) );  
    isPk = (rs->getString(5) == "PRI" ? 1 : 0);
}

void Columna::print() {
    cout << orden << ") " << nombre << ", " << tipo << "(" << tamanio << "),  "
        << texto << ", Is PK: " << isPk << endl; 
}

string Columna::paramsInsert() {
    string pains = "";
    if (orden == 1) {
        if (isPk == 1) {
            pains += "\t " + nombre + " " + texto + " OUT" + '\n'; 
        }
        else {
            pains += "\t " + nombre + " " + texto + '\n'; 
        }
    }
    else {
        if (isPk == 1) {
            pains += "\t," + nombre + " " + texto + " OUT" + '\n'; 
        }
        else {
            pains += "\t," + nombre + " " + texto + '\n'; 
        }
    }
    return pains;
}
