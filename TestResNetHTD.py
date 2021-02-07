# -*- coding: utf-8 -*-
"""
Created on Mon May  6 17:19:20 2019

@Authors: Malihe Javidi. Email: m.javidi [at] qiet.ac.ir
@Authors: Mahdi Jampour. Email: jampour [at] icg.tugraz.at
"""
from __future__ import print_function
from keras.utils import np_utils
import numpy as np
import os
import cv2
import scipy.io
from keras.models import load_model


######Load HTD feature descriptor######
mat1 = scipy.io.loadmat('.\\HTDDescriptor\\Data_CERUG_Te.mat')                                                  # Load HTD Test
HTDTe = mat1["Data1"]

######Load test samples######
path_Ts    = '.\\Datasets\\My_CERUG-EN_IMG\\Te_Rand\\'                           				# Set PathTest
all_images = []
y_test     = []
subjects   = os.listdir(path_Ts)
for number1 in range(0, num_classes):  
    print(number1)
    pathFold = (path_Ts + subjects[number1] + '\\')
    files    = os.listdir(pathFold);
    numberOfsamples = len(files)
    for number2 in range(0, test_no):                                                          # test number
        pathImg = pathFold + files[number2]
        img     = cv2.imread(pathImg , 0)
        img     = img.reshape(img_rows, img_cols, img_channels)
        all_images.append(img)
        y_test.append(int(number1))

X_test = np.array(all_images)
y_test = np.array(y_test, dtype=np.uint16) 
print(X_test.shape)

# Convert class vectors to binary class matrices.
Y_test  = np_utils.to_categorical(y_test, num_classes)
X_test  = X_test.astype('float32')

######Predict######
model = load_model('.\\ResNetModels\\model_CERUG_EN-28-0.8914.h5')                                               # Load saved model
score = model.evaluate([X_test,HTDTe], Y_test, verbose=0)
print('Test Loss:', score[0])
print('Test Accuracy:', score[1])