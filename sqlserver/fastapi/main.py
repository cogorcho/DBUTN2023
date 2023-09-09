from typing import Union
from fastapi import FastAPI

import json
import pyodbc

drivers=['ODBC Driver 18 for SQL Server', 'ODBC Driver 17 for SQL Server']
driver=drivers[-1]
server="localhost"
database="Boquita"
uid="sa"
pwd="Soler225"
con_string = f'DRIVER={driver};SERVER={server};DATABASE={database};UID={uid};PWD={pwd}'

mydb = pyodbc.connect(con_string)

def getTablas():
    s0="select table_name from information_schema.tables"
    c1 = mydb.cursor()
    c1.execute(s0)
    tabs=list()
    for x in c1:
        tabs.append(x[0])
    c1.close()
    return tabs

def getSps():
    s0="select routine_schema,routine_name from information_schema.routines where routine_schema='dbo'"
    c1 = mydb.cursor()
    c1.execute(s0)
    procs=list()
    for x in c1:
        procs.append(x)
    c1.close()
    return procs

def getPars(sp):
    s1="""select PARAMETER_NAME,PARAMETER_MODE,DATA_TYPE ,CHARACTER_MAXIMUM_LENGTH
    from information_schema.parameters
    where SPECIFIC_NAME = '{1}'
    and SPECIFIC_SCHEMA = '{0}'""".format(sp[0], sp[1])

    c2 = mydb.cursor()
    c2.execute(s1)

    curli=list()
    for h in c2.description:
        curli.append(h[0])

    pas=list()
    for y in c2:
        pas.append(dict(zip(curli,y)))
    d={}
    d["procedure"] = sp[1]
    d["parametros"] = pas

    c2.close()
    return d

def genParams():
    data = list()
    for d in getSps():
        data.append(getPars(d))
    return data

def genWork():
    for x in genParams():
        print(json.dumps(x, indent=4))

app = FastAPI()

@app.get("/params")
def procs():
    return genParams()

@app.get("/procs")
def sps():
    l = [y for (x,y) in getSps()]
    print(l)
    d = {}
    d['nombre'] = "Stored Procedures"
    d['data'] = l
    return d

@app.get("/tablas")
def tablas():
    d = {}
    d['nombre'] = "Tablas"
    d['data'] = getTablas()
    return d