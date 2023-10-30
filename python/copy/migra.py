from orm import Sector, Ambito, Provincia, Departamento, Localidad, Escuela
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

engine1 = create_engine('sqlite:///Escuelas.db')
engine2 = create_engine('sqlite:///data.sqlite')

sesion_origen = sessionmaker(bind=engine1)
session_destino= sessionmaker(bind=engine2)
origen = sesion_origen()
destino = session_destino()

def iSector():
    sectores = origen.query(Sector).all()
    print(f"A insertar {len(sectores)} sectores")
    counter = 0
    for s in sectores:
        destino.add(Sector(nombre=s.nombre))
        counter+=1
    destino.commit()
    print(f"{counter} sectores insertados")

def iAmbito():
    ambitos = origen.query(Ambito).all()
    print(f"A insertar {len(ambitos)} ambitos")
    counter = 0
    for a in ambitos:
        destino.add(Ambito(nombre=a.nombre))
        counter+=1
    destino.commit()
    print(f"{counter} ambitos insertados")

def iProvincia():
    provincias = origen.query(Provincia).all()
    print(f"A insertar {len(provincias)} provincias")
    counter = 0
    for p in provincias:
        destino.add(Provincia(nombre=p.nombre))
        counter+=1
    destino.commit()
    print(f"{counter} provincias insertadas")

def iDepartamento():
    departamentos = origen.query(Departamento).all()
    print(f"A insertar {len(departamentos)} departamentos")
    counter = 0
    for d in departamentos:
        destino.add(Departamento(provinciaid=d.provinciaid, nombre=d.nombre.title()))
        counter+=1
    destino.commit()
    print(f"{counter} departamentos insertados")

def iLocalidad():
    localidades = origen.query(Localidad).all()
    print(f"A insertar {len(localidades)} localidades")
    counter = 0
    for l in localidades:
        destino.add(Localidad(departamentoid=l.departamentoid, nombre=l.nombre))
        counter+=1
    try:
        destino.commit()
    except Exception as error:
        print(error)
    print(f"{counter} localidades insertadas")

def iEscuela():
    escuelas = origen.query(Escuela).all()
    print(f"A insertar {len(escuelas)} escuelas")
    counter = 0
    for e in escuelas:
        destino.add(Escuela(
            nombre=e.nombre,
            cueanexo=e.cueanexo,
            domicilio=e.domicilio,
            codpos=e.codpos,
            telefono=e.telefono,
            email=e.email,
            sectorid=e.sectorid,
            ambitoid=e.ambitoid,
            provinciaid=e.provinciaid,
            departamentoid=e.departamentoid,
            localidadid=e.localidadid
        ))
        counter+=1
    try:
        destino.commit()
    except Exception as error:
        print(error)
    print(f"{counter} escuelas insertadas")

def borrarTodo():
    print("Borrando Escuela...")
    destino.query(Escuela).delete()
    destino.commit()

    destino.query(Localidad).delete()
    destino.commit()
    print("Borrando Localidad...")

    destino.query(Departamento).delete()
    destino.commit()
    print("Borrando Departamento...")

    destino.query(Provincia).delete()
    destino.commit()
    print("Borrando Provincia...")

    destino.query(Ambito).delete()
    destino.commit()
    print("Borrando Ambito...")

    destino.query(Sector).delete()
    destino.commit()
    print("Borrando Sector...")

def insertarTodo():
    iSector()
    iAmbito()
    iProvincia()
    iDepartamento()
    iLocalidad()
    iEscuela()

borrarTodo()
insertarTodo()
