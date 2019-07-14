function  svm_classification()
%% ---------------------------------------------------------------------
%                                                            INPUTS
% ---------------------------------------------------------------------
dataset =input('Please select among the following target datasets: (PhoenicianData)/(TifinaghData)/(TifinaghData_or)/(LatinData)/(ArabicData66)/(ArabicData24)/(RussianData)/(DevanagariData)/(BengaliData)/(DigitsData)/(CifarData)','s'); %dataset = 'PhoenicianData';
all_limited_target_data = input('Please select among the following: (0) full target dataset / (1)limited target dataset '); % limited= 55 instances/char

%% ---------------------------------------------------------------------
%                                                            PREPARE DATA
% ---------------------------------------------------------------------
image_size = 60; pretrained_net = [];
[imdb, num_categories] = setup_data(dataset, all_limited_target_data, image_size,pretrained_net); %num_categories= #labels or classes
training_batch = find(imdb.images.set == 1); % training set 
%training_batch = training_batch(1:2000);
testing_batch =  find(imdb.images.set == 2); % testing set 


%% ---------------------------------------------------------------------
%                                                    FEATURE EXTRACTION
%                                                       & CLASSIFICATION                  
% ---------------------------------------------------------------------
cellSize = [4 4];

[data, labels] = getBatch(imdb, training_batch) ;
numImages = numel(training_batch);
hogFeatures = extractHOGFeatures(data(:,:,:,1),'CellSize',cellSize); %HOGDEATURES 7056
trainingFeatures = zeros(numImages, length(hogFeatures), 'single');
for i = 1:numImages
    %img = readimage(trainingSet, i);    img = rgb2gray(img);    img = imbinarize(img);
    trainingFeatures(i, :) = extractHOGFeatures(data(:,:,:,i), 'CellSize', cellSize);  
end

% fitcecoc uses SVM learners and a 'One-vs-One' encoding scheme.
classifier = fitcecoc(trainingFeatures, labels);

% Make class predictions using the test features.
[data, labels] = getBatch(imdb, testing_batch) ;
numImages = numel(testing_batch);
testFeatures = zeros(numImages, length(hogFeatures), 'single');
for i = 1:numImages
    %img = readimage(trainingSet, i);    img = rgb2gray(img);    img = imbinarize(img);
    testFeatures(i, :) = extractHOGFeatures(data(:,:,:,i), 'CellSize', cellSize);  
end
predictedLabels = predict(classifier, testFeatures);

% Tabulate the results using a confusion matrix.
confMat = confusionmat(labels(:), predictedLabels)


% %% ---------------------------------------------------------------------
% %                                                    CLASSIFICATION W/ SVM
% % ---------------------------------------------------------------------
% 
% %build svm model
% 
% data = reshape(data, size(data,1) * size(data,2), size(data,4)); % convert from h x w x 1 x n to (h*w) x n
% SVMModel = svm.train(data',labels', 'kernel_function','rbf');  % was fitsvm for binary
% % test svm model
% [data, labels] = getBatch(imdb, testing_batch) ;
% data = reshape(imdb, size(data,1) * size(data,2), size(data,4)); % convert from h x w x 1 x n to (h*w) x n
% predicted_label = svm.predict(SVMModel,data'); %predict
% 
Accuracy=mean(labels(:)==predictedLabels)*100;
fprintf('\nAccuracy =%d\n',Accuracy)

end

% --------------------------------------------------------------------
function [im, labels] = getBatch(imdb, batch)
%getBatch is called by cnn_train.

%'imdb' is the image database.
%'batch' is the indices of the images chosen for this batch.

%'im' is the height x width x channels x num_images stack of images. If
%opts.batchSize is 50 and image size is 64x64 and grayscale, im will be
%64x64x1x50.
%'labels' indicates the ground truth category of each image.

%This function is where you should 'jitter' data.
% --------------------------------------------------------------------
N = length(batch);
im = imdb.images.data(:,:,:,batch) ;
labels = imdb.images.labels(1,batch) ;

% Add jittering here before returning im
for i = 1:N
%% 1. 1randomly rotate the training images for jittering
roll = rand();
if roll>0.5
    im(:,:,:,i) = rotating(im(:,:,:,i)); 
end

%% 2. randomly scale the training images for jittering
roll = rand();
if roll>0.5
    im(:,:,:,i) = scaling2(im(:,:,:,i));
    %imshow(im(:,:,:,i));
end
end

end


