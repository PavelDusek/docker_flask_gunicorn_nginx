import os
from flask import Flask
#from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)
#app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:////app/data.db'
#db = SQLAlchemy(app)

@app.route("/")
def index():
        return "Blablabla %s" % os.environ.get('HOSTNAME')

if __name__ == "__main__":
        app.run(host='0.0.0.0', port='80')
