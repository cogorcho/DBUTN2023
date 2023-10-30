from flask_wtf import FlaskForm
from wtforms import StringField, SubmitField
from wtforms.validators import DataRequired

# ----------------------------------
# Form para Baseescuela
# ----------------------------------
class BaseEscuelaForm(FlaskForm):
    Jurisdiccion = StringField('Jurisdiccion')
    Sector = StringField('Sector')
    Ambito = StringField('Ambito')
    Departamento = StringField('Departamento')
    Codigo_de_departamento = StringField('Codigo_De_Departamento')
    Localidad = StringField('Localidad')
    Codigo_de_localidad = StringField('Codigo_De_Localidad')
    Cueanexo = StringField('Cueanexo')
    Nombre = StringField('Nombre')
    Domicilio = StringField('Domicilio')
    codpos = StringField('Codpos')
    Telefono = StringField('Telefono')
    Mail = StringField('Mail')
    submit = SubmitField('Submit')

# ----------------------------------
# Form para Sector
# ----------------------------------
class SectorForm(FlaskForm):
    id = StringField('Id')
    nombre = StringField('Nombre', validators=[DataRequired()])
    submit = SubmitField('Submit')

# ----------------------------------
# Form para Ambito
# ----------------------------------
class AmbitoForm(FlaskForm):
    id = StringField('Id')
    nombre = StringField('Nombre', validators=[DataRequired()])
    submit = SubmitField('Submit')

# ----------------------------------
# Form para Provincia
# ----------------------------------
class ProvinciaForm(FlaskForm):
    id = StringField('Id')
    nombre = StringField('Nombre', validators=[DataRequired()])
    submit = SubmitField('Submit')

# ----------------------------------
# Form para Departamento
# ----------------------------------
class DepartamentoForm(FlaskForm):
    id = StringField('Id')
    provinciaid = StringField('Provinciaid', validators=[DataRequired()])
    nombre = StringField('Nombre', validators=[DataRequired()])
    submit = SubmitField('Submit')

# ----------------------------------
# Form para Localidad
# ----------------------------------
class LocalidadForm(FlaskForm):
    id = StringField('Id')
    departamentoid = StringField('Departamentoid', validators=[DataRequired()])
    nombre = StringField('Nombre', validators=[DataRequired()])
    submit = SubmitField('Submit')

# ----------------------------------
# Form para Escuela
# ----------------------------------
class EscuelaForm(FlaskForm):
    id = StringField('Id', validators=[DataRequired()])
    nombre = StringField('Nombre', validators=[DataRequired()])
    cueanexo = StringField('Cueanexo', validators=[DataRequired()])
    domicilio = StringField('Domicilio', validators=[DataRequired()])
    codpos = StringField('Codpos')
    telefono = StringField('Telefono')
    email = StringField('Email')
    sectorid = StringField('Sectorid', validators=[DataRequired()])
    ambitoid = StringField('Ambitoid', validators=[DataRequired()])
    provinciaid = StringField('Provinciaid', validators=[DataRequired()])
    departamentoid = StringField('Departamentoid', validators=[DataRequired()])
    localidadid = StringField('Localidadid', validators=[DataRequired()])
    submit = SubmitField('Submit')
