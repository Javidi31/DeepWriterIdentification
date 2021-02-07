# -*- coding: utf-8 -*-
"""
Created on Mon May  6 17:19:20 2019

@Authors: Malihe Javidi. Email: m.javidi [at] qiet.ac.ir
@Authors: Mahdi Jampour. Email: jampour [at] icg.tugraz.at
"""
from __future__ import print_function
from keras.utils import np_utils
from keras.callbacks import ReduceLROnPlateau, CSVLogger, EarlyStopping
import numpy as np
import ResNetHTDModel
import os
import cv2
from keras.callbacks import ModelCheckpoint
import scipy.io


#Load HTD feature descriptor
mat1 = scipy.io.loadmat('.\\HTDDescriptor\\Data_CERUG_Tr.mat')                                                  # Load HTD Train
HTDTr = mat1["Data1"]



lr_reducer    = ReduceLROnPlateau(factor=np.sqrt(0.1), cooldown=0, patience=5, min_lr=0.5e-6)
early_stopper = EarlyStopping(min_delta=0.001, patience=10)
csv_logger    = CSVLogger('resnet18_HTDTrVar_CERUG_BS64.csv')                             # Set name of log file

batch_size    = 64                                                                           #Set batch size
nb_epoch      = 50                                                                           #Set number of epochs
data_augmentation = False
VALIDATION_SPLIT  = 0.2         #######
img_rows, img_cols = 60, 180                                                                 #Set image row and column
img_channels  = 1                                                                            #Set image channel
INPUT_SHAPE   = (img_channels, img_rows, img_cols)
HTD_SHAPE     = HTDTr.shape[1]
feat_SHAPE    = HTD_SHAPE 
TrNo          = HTDTr.shape[0]


###############################################################################
path_Tr     = '.\\Datasets\\My_CERUG-EN_IMG\\Train\\'                           				# Set PathTrain
all_images  = []
y_train     = []
subjects    = os.listdir(path_Tr)
num_classes = len(subjects)     
print('Number of Classes: ', num_classes)
train_no    = 600                                                                              # Set number of train samples
test_no     = 30                                                                               # Set number of test samples
for number1 in range(0, num_classes):  
    print(number1)
    pathFold = (path_Tr + subjects[number1] + '\\')
    files    = os.listdir(pathFold);
    numberOfsamples = len(files)
    for number2 in range(0, train_no):                                                         # train number
        pathImg = pathFold + files[number2]
        img     = cv2.imread(pathImg , 0)
        img     = img.reshape(img_rows, img_cols, img_channels)
        all_images.append(img)
        y_train.append(int(number1))

X_train = np.array(all_images)
y_train = np.array(y_train, dtype=np.uint16) 
print(X_train.shape)



# Convert class vectors to binary class matrices.
Y_train = np_utils.to_categorical(y_train, num_classes)
X_train = X_train.astype('float32')


# subtract mean and normalize
mean_image = np.mean(X_train, axis=0)
X_train   -= mean_image
X_train   /= 128.


model = ResNetHTDModel.ResnetBuilder.build_resnet_18(input_shape=INPUT_SHAPE, feat_shape=feat_SHAPE, num_outputs=num_classes)
model.compile(loss='categorical_crossentropy',
              optimizer='adam',
              metrics=['accuracy'])

MODEL_DIR = ".\\ResNetModels"                                         # Set log directory
filepath = "saved-model-{epoch:02d}-{val_acc:.4f}.hdf5"
checkpoint = ModelCheckpoint(filepath=os.path.join(MODEL_DIR,"model_CERUG_EN-{epoch:02d}-{val_acc:.4f}.h5"),
                             monitor = "val_acc", save_best_only = True)


history = model.fit([X_train,HTDTr], Y_train,batch_size=batch_size,
                    nb_epoch=nb_epoch, verbose=VERBOSE,validation_split=VALIDATION_SPLIT,
                    shuffle=True,callbacks=[lr_reducer, early_stopper, csv_logger,checkpoint])