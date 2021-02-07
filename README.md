This is a [Keras](https://keras.io/) implementation of ResNet conjugated with classic descriptor.

Residual networks with HTD classic descriptor implementation using Keras-1.0 functional API. To know more about our proposed model, please read the [original paper](https://www.sciencedirect.com/science/article/abs/pii/S0952197620302463).

1. Download ["CERUG-EN data set"](https://www.ai.rug.nl/~sheng/writeridataset.html), 
2. As this dataset is word-base (unlike to the IAM, etc.), run ["Preparing.m"](https://github.com/Javidi31/DeepWriterIdentification/blob/main/Preparing.m) to merge words as a whole image for each subject.
3. Run "[main_ExtPatch.m](https://github.com/Javidi31/DeepWriterIdentification/blob/main/main_ExtPatch.m)" in Matlab to prepare the train and test patches in appropriate folders.
4. Run "[dataAugment.py](https://github.com/Javidi31/DeepWriterIdentification/blob/main/dataAugment.py)" in Pyhon if you want to augment training samples.
5. Run "[HTD.m](https://github.com/Javidi31/DeepWriterIdentification/blob/main/HTD.m)" in Matlab to extract HTD classic descriptor.
6. Run "[TrainResNetHTD.py](https://github.com/Javidi31/DeepWriterIdentification/blob/main/TrainResNetHTD.py)" in Python To train the ResNet model with HTD classic descriptor.
7. Run "[TestResNetHTD.py](https://github.com/Javidi31/DeepWriterIdentification/blob/main/TestResNetHTD.py)" in Python to evaulate the test data with the best saved model in previous step.

**************************************************************************************************************************************************

Good luck



# Cite information
Malihe Javidi, Mahdi Jampour,

A deep learning framework for text-independent writer identification,

Engineering Applications of Artificial Intelligence, Volume 95, 2020, 103912, https://doi.org/10.1016/j.engappai.2020.103912.
