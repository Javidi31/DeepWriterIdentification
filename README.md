This is a [Keras](https://keras.io/) implementation of ResNet conjugated with classic descriptor.

Residual networks with HTD classic descriptor implementation using Keras-1.0 functional API.

0. Download ["CERUG-EN data set"](https://www.ai.rug.nl/~sheng/writeridataset.html) 
1. Run "main_ExtPatch.m" in Matlab to prepare the train and test patches in appropriate folders.
2. Run "dataAugment.py" in Pyhon if you want to augment training samples.
3. Run "HTD.m" in Matlab to extract HTD classic descriptor.
4. Run "TrainResNetHTD.py" in Python To train the ResNet model with HTD classic descriptor.
5. Run "TestResNetHTD.py" in Python to evaulate the test data with the best saved model in previous step.

**************************************************************************************************************************************************

Good luck



# Cite information
Malihe Javidi, Mahdi Jampour, 

"A deep learning framework for text-independent writer identification,"

Engineering Applications of Artificial Intelligence, Volume 95, 2020,(https://www.sciencedirect.com/science/article/abs/pii/S0952197620302463)
