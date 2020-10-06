from flask import Flask,jsonify,request
import pandas as pd
from flask.templating import render_template

app = Flask(__name__)

def getdistricts(state):
    import pandas as pd
    states=pd.read_csv("States.csv")
    return states[states['State']==state]['District'].tolist()

@app.route("/")
def index():
    return render_template('form.html')

@app.route("/districts/",methods=['GET'])

def predict():
    query=request.args
    print(query['State'])
    state=query['State']
    districts=getdistricts(state)
    return jsonify({'State':state,'Districts':districts})

if __name__ == '__main__':
    app.run()