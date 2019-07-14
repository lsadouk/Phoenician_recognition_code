function [imdb, num_categories] = setup_data_cifar(image_size)
%code for Computer Vision, Georgia Tech by James Hays

%This path is assumed to contain 'test' and 'train' which each contain 15
%subdirectories. The train folder has 100 samples of each category and the
%test has an arbitrary amount of each category. This is the exact data and
%train/test split used in Project 4.
%%%SceneJPGsPath = 'data/EnglishData_WoutSpace/';
num_categories=10;

%% Load Database --------------------------------------------------------------
cifar10Data = 'data\cifar-10-matlab';
[trainX, trainY, testX, testY] = helperCIFAR10Data.load(cifar10Data);

trainX = imresize(trainX, [image_size image_size]); % TrainX=28 *2 = 56
testX = imresize(testX, [image_size image_size]);

%num_train_per_category = size(trainX, 4) / num_categories;
%num_test_per_category  = size(testX, 4) / num_categories; 
%total_images = 10*num_train_per_category + 10 * num_test_per_category; %32 classes
nb_train = size(trainX, 4);
nb_test = size(testX, 4);
total_images = nb_train+nb_test;
imdb.images.data   = zeros(image_size, image_size, 3, total_images, 'single');
imdb.images.labels = zeros(1, total_images, 'single');
imdb.images.set    = zeros(1, total_images, 'uint8');

%nb_train = 10*num_train_per_category;
%nb_test = 10 * num_test_per_category;

imdb.images.data(:,:,:, 1:nb_train) = trainX;
imdb.images.labels(1, 1:nb_train) = single(trainY');
imdb.images.set(1, 1:nb_train) = 1;

imdb.images.data(:,:,:, nb_train+1:nb_train+nb_test) = testX;
imdb.images.labels(:, nb_train+1:nb_train+nb_test) = testY';
imdb.images.set(:, nb_train+1:nb_train+nb_test) = 2;


end
