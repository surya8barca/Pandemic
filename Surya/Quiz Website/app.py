from flask import Flask,jsonify,request
import joblib
import pandas as pd
from flask.templating import render_template
import numpy as np
from sklearn.preprocessing import LabelEncoder

from sklearn.model_selection import train_test_split
import xgboost as xgb


app = Flask(__name__)

@app.route("/")
def index():
    return render_template('form.html')

@app.route("/predict/",methods=['GET'])
def predict():
    result=request.args
    model=joblib.load('XGB_model.sav')
    data = [[1, 1, 1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0]]
    test = pd.DataFrame(np.array(data), columns=['Breathing Problem', 'Fever', 'Dry Cough', 'Sore throat', 'Running Nose', 'Asthma', 'Chronic Lung Disease', 'Headache', 'Heart Disease', 'Diabetes', 'Hyper Tension', 'Fatigue ', 'Gastrointestinal ', 'Abroad travel', 'Contact with COVID Patient', 'Attended Large Gathering', 'Visited Public Exposed Places', 'Family working in Public Exposed Places', 'Wearing Masks', 'Sanitization from Market'])
    value=model.predict(test)
    prediction=''
    if(value[0]==0):
        prediction="High Risk"
    else:
        prediction="Low Risk"
    return jsonify({'prediction':prediction}) 


if __name__ == '__main__':
    app.run()