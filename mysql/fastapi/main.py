from typing import Union
from fastapi import FastAPI

import mysql.connector
import json

mydb = mysql.connector.connect(
  host="192.168.100.36",
  user="db2023",
  password="db2023",
  database="UTN"
)

def getSps():
    s0="select routine_schema,routine_name from information_schema.routines where routine_schema='UTN'"
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

    c2 = mydb.cursor(buffered=True)
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

def genTodo():
    data = list()
    for d in getSps():
        data.append(getPars(d))
    return data

def genWork():
    for x in genTodo():
        print(json.dumps(x, indent=4))

app = FastAPI()

@app.get("/")
def read_root():
    return {"Hello": "World"}

@app.get("/items/{item_id}")
def read_item(item_id: int, q: Union[str, None] = None):
    return {"item_id": item_id, "q": q}

@app.get("/procs")
def procs():
    return genTodo()

