# -*- coding: utf-8 -*-
"""
Created on Mon May  6 17:19:20 2019

@Authors: Malihe Javidi. Email: m.javidi [at] qiet.ac.ir
@Authors: Mahdi Jampour. Email: jampour [at] icg.tugraz.at
"""

import cv2
import os
from numpy import expand_dims
from keras.preprocessing.image import img_to_array
from keras.preprocessing.image import ImageDataGenerator


pathTrain   = '.\\Datasets\\My_CERUG-EN_IMG\\Train\\';   			#Train Path 
subjects    = os.listdir(pathTrain)
num_classes = len(subjects)
noFiles     = 1500                                         #Maximum number of augmented files for each class
augFact     = 10                                           #Augmented factor
print('Number of Classes: ', num_classes)
for number1 in range(0,num_classes):  
    pathFold = (pathTrain + subjects[number1]+'\\')
    files    = os.listdir(pathFold);
    numberOfsamples = len(files)    
    if numberOfsamples<noFiles:
        print(pathFold)
        for number2 in range(0, numberOfsamples):
            pathImg = pathFold + files[number2]
            img  = cv2.imread(pathImg , 0)
            # convert to numpy array
            data = img_to_array(img)
            # expand dimension to one sample
            samples = expand_dims(data, 0)
            datagen = ImageDataGenerator(
                    width_shift_range  = 0.3,              # randomly shift images horizontally (fraction of total width)
                    height_shift_range = 0.1,              # randomly shift images vertically (fraction of total height)
                    rotation_range     = 10,               # randomly rotate images in the range (degrees, 0 to 180)
                    #horizontal_flip   = True,             # randomly flip images horizontally
                    #vertical_flip     = False,            # randomly flip images vertically
                    fill_mode='constant',cval=255)         #fill mode can be: nearest#reflect#wrap
            # prepare iterator
            it    = datagen.flow(samples, batch_size=1)
            # generate samples and plot
            count = numberOfsamples+1                    
            for i in range(augFact):            
                batch = it.next()
                image = batch[0].astype('uint8')
                if(count<100):
                   cv2.imwrite(os.path.join(pathFold , '00'+str(count)+'.png'),image)
                elif(count<1000):
                   cv2.imwrite(os.path.join(pathFold , '0'+str(count)+'.png'),image)
                else:
                   cv2.imwrite(os.path.join(pathFold , str(count)+'.png'),image)
                count = count + 1
            
            files = os.listdir(pathFold);
            numberOfsamples = len(files)    
            if numberOfsamples>noFiles:
                print(numberOfsamples)
                break