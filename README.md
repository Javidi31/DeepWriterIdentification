This is a [Keras](https://keras.io/) implementation of ResNet conjugated with classic descriptor.

Residual networks with HTD classic descriptor implementation using Keras-1.0 functional API.
1. In pre-processing step, to prepare training and test patches, run "main_ExtPatch.m" in Matlab.
2. If you want to augment training samples of dataset, run "dataAugment.py" in Pyhon.
3. To extract HTD classic descriptor, run "HTD.m" in Matlab.
4. To train the ResNet model with HTD classic descriptor, run "TrainResNetHTD.py" in Python.
5. To test with the best saved model, run "TestResNetHTD.py" in Python.

**************************************************************************************************************************************************

Good luck


# Cite information
Malihe Javidi, Mahdi Jampour, 

"A deep learning framework for text-independent writer identification,"

Engineering Applications of Artificial Intelligence, Volume 95, 2020,(https://www.sciencedirect.com/science/article/abs/pii/S0952197620302463)
