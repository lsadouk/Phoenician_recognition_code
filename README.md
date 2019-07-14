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

<h2>Usage</h2>
In our article, we aim at:
1. presenting a deep 

1. You can train and test the neural network by running the file 'proj_regression.m' (<b>see examples below </b>):

- using either the standard (baseline) algorithm (e.g., the standard loss function) or the cost-sensitive learning algorithm (e.g., the cost-sensitive version of the loss function) applied on ones of the following loss functions:  <b>L<sub>2</sub></b>, <b>L<sub>2</sub> &#959; &#963;</b>, <b>Mshinge</b>, <b>Mshinge<sub>2</sub></b>, <b>Mshinge<sub>3</sub></b>, <b>log &#959; &#963;</b>.

- using either shallow and deep neural networks: 
    *  shallow neural networks such as Multi-Layer Perceptrons (MLPs), by using one of the 1D datasets: (ionosphere) / ("pid" - Pima Indians Diabetes) / (WP_Breast_Cancer) / (SPECTF_Heart) / (yeast_8l) / (car) / (satimage) / (thyroid).
    *  deep learning models such as Convolutional Neural Networks, by using one of the 2D datasets: (mnist10) / (mnist30) / (mnist40) / (mnist50).

2. You can compare the standard or cost-sensitive learning algorithm to one of existent methods including: 
- <b>undersampling method</b>: training the neural network (MLP or CNN) with the undersampling strategy,
- <b>oversampling method</b>: training the neural network (MLP or CNN) with the oversampling strategy,
- <b>ST1 method (Alejo et al. 2007)</b>: from the paper ["Improving the performance of the RBF neural networks trained with imbalanced samples"](https://pdfs.semanticscholar.org/483f/afc0a2901fb184a4e18d0cb57a44e3dcf893.pdf) .


<h2>Examples for training and testing our models : </h2>
<h3>1. Example of training and testing our cost-sensitive learning algorithm using the Mshinge<sub>2</sub> loss function</h3>
In this example, we want to train our CNN using 
