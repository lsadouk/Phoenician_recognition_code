# Phoenician_recognition_code
A code for recognizing Phoenician Handwritten characters and also for recognizing any Handwritten alphabet which presents a lack of annotated data.

Welcome. This repository contains the data and scripts comprising the article 'Using Handwritten Phoenician Character recognition to improve recognition of handwritten alphabets with a lack of annotated data.'

Included are the tools to allow you to easily run the code.

This readme is a brief overview and contains details for setting up and running the project. Please refer to the following:

<h1>Running the project</h1>
<h2>Initial requirements</h2>

1. To the code, the environment needed is Matlab. So you need to install: 
    * Matlab if run on CPU mode,
    * Matlab 2016b or higher, Cuda toolkit and cuDNN linrary if run on GPU mode.
2. To run this project, the MatConvNet Toolbox 1.0-beta25 needs to be installed (and saved into the main directory) and compiled. You can dowload the Toolbox by clicking on this link: http://www.vlfeat.org/matconvnet/download/matconvnet-1.0-beta25.tar.gz
For further information about how to compile the toolbox, please refer to the following url: http://www.vlfeat.org/matconvnet/install/
3. The alphabet datasets have already been preprocessed and can be downloaded from the following links:
- Tifinagh Handwritten dataset: https://drive.google.com/file/d/1p-vCAztwFPRKBA_C3emvHIPvOF3zzbu8/view?usp=sharing
- Phoenician Handwritten dataset: https://osf.io/4j9b6/
- Russian Handwritten dataset: https://drive.google.com/open?id=11snRx-wBHcvB2033IVYdG9njY5MIGMJJ
- Latin Handwritten dataset:  https://drive.google.com/file/d/1z27RIxP-yCSyeAAKRqd12M7gpnS8r2cq/view?usp=sharing
- Bengali Handwritten dataset: https://drive.google.com/file/d/1msBOYcCbNkST4jIuT6TudgEV39iESpJR/view?usp=sharing
- Arabic Handwritten dataset: (need to ask permission of authors of AMHCD)
- Cifar Handwritten dataset : https://www.cs.toronto.edu/~kriz/cifar-10-matlab.tar.gz

, then unzipped to the folder './data/'.

<h2>Contributions</h2>
The main contributions of our article are:

1. We introduce a database for Phoenician handwritten characters (PHCDB) for the first time. It is freely available at :https://osf.io/4j9b6/

2. We develop a deep learning recognition system for Handwritten Phoenician Character recognition which is based on Convolutional Neural Networks (ConvNets)  (section 3 of article)

3. We propose a transfer learning system which uses Phoenician characters’ shapes to improve the recognition of the Handwritten Tifinagh alphabet (section 4 of article)

4. We propose a light-weight and fast transfer learning network for recognizing existing alphabets which experience a lack of annotated data (section 5 of article)

<h2>Usage</h2>

- <b>CONTRIBUTION 1: Training a ConvNet on Phoenician Data to obtain the <i>Phoenician ConvNet</i></b>

Run the code "proj_phoenician.m"

>>Please select among the following target datasets: (PhoenicianData)/(TifinaghData)/(LatinData)/(ArabicData24)/(RussianData)/(BengaliData)/(DigitsData)/(CifarData) <b>PhoenicianData</b>

>>Please select among the following: (0) full target dataset / (1)limited target dataset <b>0</b>

>>Please choose: (1)Train a randomly initialized CNN / (2)Apply Transfer Learning <b>1</b>

The displayed result is: <b>Lowest validation error is 0.9851 at epoch 57</b>

Resultant ConvNet models per epoch are saved in the following location: './data_results/data_PhoenicianData_60-60_limitedData0/'

- <b>CONTRIBUTION 2: Finetuning the whole <i>Phoenician ConvNet</i> (all weights of the convnet) using the Tifinagh dataset </b>

First, we need the pre-trained <i>Phoenician ConvNet</i> model which can be obtained by running "CONTRIBUTION 1" (the best <i>Phoenician ConvNet</i> being at epoch 57  and being available at: './data_results/data_PhoenicianData_60-60_limitedData0/net-epoch-57.mat'

Run the code "proj_phoenician.m"

>>Please select among the following target datasets: (PhoenicianData)/(TifinaghData)/(LatinData)/(ArabicData24)/(RussianData)/(BengaliData)/(DigitsData)/(CifarData)<b>TifinaghData</b>

>>Please select among the following: (0) full target dataset / (1)limited target dataset <b>0</b>

>>Please choose: (1)Train a randomly initialized CNN / (2)Apply Transfer Learning <b>2</b>

>>Please choose among pre-trained CNN model/net: (Phoenician)/(Latin)/(Arabic66)/(Arabic24)/(Russian)/(Devanagari)/(Bengali)/(ImageVGG)/(Digits)/(Cifar) <b>Phoenician</b>

>>Please choose: (0)Fine-tune the whole network / (1)Fine-tune only last layer (freeze others) <b>0</b>

The displayed result is: <b>Lowest validation error is 99.05 at epoch 35</b>

Resultant ConvNet models per epoch are saved in the following location: './data_results/data_TL_from_Phoenician_to_TifinaghData_freeze0_60-60__limitedData0/'

-<b> CONTRIBUTION 3: Fine-tuning only last layer weights of the "Phoenician ConvNet" using a target dataset with limited training data to obtain the <i>TL ConvNet using Phoenician</i> system.</b>

Example of the target dataset: RussianData
Number of training data per target dataset: n=99

First, we need the pre-trained <i>Phoenician ConvNet</i> model which can be obtained by running "CONTRIBUTION 1" (the best <i>Phoenician ConvNet</i> being at epoch 57  and being available at: './data_results/data_PhoenicianData_60-60_limitedData0/net-epoch-57.mat'

>>Please select among the following target datasets: (PhoenicianData)/(TifinaghData)/(LatinData)/(ArabicData24)/(RussianData)/(BengaliData)/(DigitsData)/(CifarData) <b>RussianData</b>

>>Please select among the following: (0) full target dataset / (1)limited target dataset <b>1</b>

>>Please choose: (1)Train a randomly initialized CNN / (2)Apply Transfer Learning <b>2</b>

>>Please choose among pre-trained CNN model/net: (Phoenician)/(Latin)/(Arabic66)/(Arabic24)/(Russian)/(Devanagari)/(Bengali)/(ImageVGG)/(Digits)/(Cifar) <b>Phoenician</b>

>>Please choose: (0)Fine-tune the whole network / (1)Fine-tune only last layer (freeze others) <b>1</b>

The displayed result is: <b>Lowest validation error is 0.8333 at epoch 30</b>

Resultant ConvNet models per epoch are saved in the following location: './data_results/data_TL_from_Phoenician_to_LatinData_freeze1_60-60__limitedData1/'
