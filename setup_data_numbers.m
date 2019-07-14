function [imdb, num_categories] = setup_data_numbers(image_size)
%code for Computer Vision, Georgia Tech by James Hays

%This path is assumed to contain 'test' and 'train' which each contain 15
%subdirectories. The train folder has 100 samples of each category and the
%test has an arbitrary amount of each category. This is the exact data and
%train/test split used in Project 4.
%%%SceneJPGsPath = 'data/EnglishData_WoutSpace/';
num_categories=10;
num_train_per_category = 6000; %  = 6/7 of 70000 are training images per category
num_test_per_category  = 1000; % 18 = 1/7 of 70000 are testing images per category
total_images = 10*num_train_per_category + 10 * num_test_per_category; %32 classes


%% Load Database --------------------------------------------------------------
[trainX, trainY, testX, testY] = getMNIST();
trainX = imresize(trainX, 2); % TrainX=28 *2 = 56
testX = imresize(testX, 2);
%trainX = double(reshape(trainX, 28*28, 60000)) / 255;
%trainY = ((0:9)' * ones(1, 60000)) == (ones(10, 1) * double(trainY'));
%testX  = double(reshape(testX, 28*28, 10000)) / 255;
%testY  = ((0:9)' * ones(1, 10000)) == (ones(10, 1) * double(testY'));

% instanceX = trainX(:,:,2);
% imshow(instanceX);
% instanceY = trainY(:,2);
imdb.images.data   = zeros(image_size, image_size, 1, total_images, 'single');
imdb.images.labels = zeros(1, total_images, 'single');
imdb.images.set    = zeros(1, total_images, 'uint8');

nb_train = 10*num_train_per_category;
nb_test = 10 * num_test_per_category;

%imdb.images.data(:,:,1, 1:nb_train) = trainX;
imdb.images.labels(1, 1:nb_train) = single(trainY');
imdb.images.set(1, 1:nb_train) = 1;

%imdb.images.data(:,:,1, nb_train+1:nb_train+nb_test) = testX;
imdb.images.labels(:, nb_train+1:nb_train+nb_test) = testY';
imdb.images.set(:, nb_train+1:nb_train+nb_test) = 2;


for i=1:size(trainX,3)
    cur_image = trainX(:,:,i); % size of image 28*28
    cur_image = padarray(cur_image, [2, 2], 'replicate');  % size of image 30*30
    %cur_image  = Resize_put_cadre(cur_image, image_size );
    imdb.images.data(:,:,1,i) = cur_image;
end

for i=1:size(testX,3)
    cur_image = testX(:,:,i); % size of image 28*28
    cur_image = padarray(cur_image, [2, 2], 'replicate');  % size of image 30*30
    %cur_image  = Resize_put_cadre(cur_image, image_size );
    imdb.images.data(:,:,1,i+size(trainX,3)) = cur_image;
end

end
