__all__ = ["routes", "models", "lib"]
from flask import Flask
from flask.ext.sqlalchemy import SQLAlchemy

app = Flask(__name__)
app.config.from_object(__name__)
app.config.update(dict(
    SQLALCHEMY_DATABASE_URI='sqlite:////tmp/test.db',
    SQLALCHEMY_ECHO=True,
    SECRET_KEY='development key',
    USERNAME='admin',
    PASSWORD='default'
))
db = SQLAlchemy(app)
app.db = db
from hello_world.routes import *
