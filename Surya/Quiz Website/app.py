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
    print(result)
    model=joblib.load('XGB_model.sav')
    data = [[int(result['Breathing Problem']),int(result['Fever']),int(result['Dry Cough']),int(result['Sore throat']),int(result['Running Nose']),int(result['Asthma']),int(result['Chronic Lung Disease']),int(result['Headache']),int(result['Heart Disease']),int(result['Diabetes']),int(result['Hyper Tension']),int(result['Fatigue']),int(result['Gastrointestinal']),int(result['Abroad travel']),int(result['Contact with COVID Patient']),int(result['Attended Large Gathering']),int(result['Visited Public Exposed Places']),int(result['Family working in Public Exposed Places']),int(result['Wearing Masks']),int(result['Sanitization from Market'])]]
    test = pd.DataFrame(np.array(data), columns=['Breathing Problem', 'Fever', 'Dry Cough', 'Sore throat', 'Running Nose', 'Asthma', 'Chronic Lung Disease', 'Headache', 'Heart Disease', 'Diabetes', 'Hyper Tension', 'Fatigue ', 'Gastrointestinal ', 'Abroad travel', 'Contact with COVID Patient', 'Attended Large Gathering', 'Visited Public Exposed Places', 'Family working in Public Exposed Places', 'Wearing Masks', 'Sanitization from Market'])
    value=model.predict(test)
    prediction=''
    if(value[0]==0):
        prediction="Low Risk"
    else:
        prediction="High Risk"
    return jsonify({'prediction':prediction}) 


if __name__ == '__main__':
    app.run()