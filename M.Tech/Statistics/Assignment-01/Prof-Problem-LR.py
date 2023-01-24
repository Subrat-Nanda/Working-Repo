# -*- coding: utf-8 -*-
"""
Created on Thu Oct  27 00:55:34 2022

@author: Subrat
"""

import numpy as np 
import pandas as pd 
from sklearn.preprocessing import LabelEncoder
from sklearn.model_selection import train_test_split
from sklearn import linear_model
from sklearn.metrics import r2_score

#Reading the data execluding top 3 rows 
data = pd.read_excel(r"D:\DS\Stast\Assignment-01\W06586-XLS-ENG (1).xls",skiprows=[0,1,2])

print(data.head())

data.shape;

data.info();

data = data.drop(["Wholesaler"], axis=1)
data.describe()


# Get list of categorical variables
s = (data.dtypes =="object")
object_cols = list(s[s].index)
print("Categorical variables:")
print(object_cols)


# Make copy to avoid changing original data 
label_data = data.copy()

# Apply label encoder to each column with categorical data
label_encoder = LabelEncoder()
for col in object_cols:
    label_data[col] = label_encoder.fit_transform(label_data[col])
label_data.head()



# Assigning the featurs as X and trarget as y
x= label_data.drop(["Price"],axis =1)
y= label_data["Price"]
x_train, x_test, y_train, y_test = train_test_split(x, y,test_size=0.30, random_state=5)



#create model
reg=linear_model.LinearRegression()
#modeling
reg.fit(x_train,y_train)

#Predicted Y
y_hat=reg.predict(x_test)
#CorrectAnswer
y_ans=y_test

print("\n" + "*"*50 )
# Explained variance score: 1 is perfect prediction
print('Variance score: %.2f' % reg.score(x_test, y_ans))
print("Mean absolute error: %.2f" % np.mean(np.absolute(y_hat - y_ans)))
print("Residual sum of squares (MSE): %.2f" % np.mean((y_hat - y_ans) ** 2))
print("R2-score: %.2f" % r2_score(y_ans , y_hat) )
