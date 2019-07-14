function [net, stats] = proj_phoenician()
%code for Computer Vision, Georgia Tech by James Hays
%based off the MNIST and CIFAR examples from MatConvNet
run matconvnet-1.0-beta25/matlab/vl_setupnn ;

opts.batchSize = 100  ; % set to 100 for training and 486/3 * 22 for testing
opts.learningRate = 0.01;% for SGD LR=0.01, for ADAM LR=0.001
%opts.solver = @adam;% solver . set to adam
opts.continue = true ;
opts.gpus = [1] ; % set to [] for cpu mode and to [1] for gpu mode
%opts.plotDiagnostics = true ; % plot 1st conv. layer weighter/filters

%% ---------------------------------------------------------------------
%                                                            INPUTS
% ---------------------------------------------------------------------
dataset =input('Please select among the following target datasets: (PhoenicianData)/(TifinaghData)/(TifinaghData_or)/(LatinData)/(ArabicData66)/(ArabicData24)/(RussianData)/(DevanagariData)/(BengaliData)/(DigitsData)/(CifarData)','s'); %dataset = 'PhoenicianData';
all_limited_target_data = input('Please select among the following: (0) full target dataset / (1)limited target dataset '); % limited= 55 instances/char
training_type =input('Please choose: (1)Train a randomly initialized CNN / (2)Apply Transfer Learning ');
freeze_all_but_last= false; 
pretrained_net = [];
if training_type ==2
    pretrained_net =input('Please choose among pre-trained CNN model/net: (Phoenician) / (Latin)/(Arabic66)/(Arabic24)/(Russian)/(Devanagari)/(Bengali)/(ImageVGG)/(Digits)/(Cifar)', 's');
    freeze_all_but_last =logical(input('Please choose: (0)Fine-tune the whole network / (1)Fine-tune only last layer (freeze others) ')); 
end

if training_type ==2 && isequal(pretrained_net, 'ImageVGG'),     image_size = 224;
else, image_size = 60; % CHANGE IT BACK TO 60
end
% --------------------------------------------------------------------
%                                                         Prepare data
% --------------------------------------------------------------------
if isequal(dataset, 'DigitsData')
    [imdb, num_categories] = setup_data_numbers(image_size);
elseif isequal(dataset, 'CifarData')
    [imdb, num_categories] = setup_data_cifar(image_size);
else    
    [imdb, num_categories] = setup_data(dataset, all_limited_target_data, image_size,pretrained_net); %num_categories= #labels or classes
end
%% -------------------------------------------------------------------
%                                    Prepare Net. Architecture & Train
% --------------------------------------------------------------------

if training_type ==1 % randomly initialized CNN
    opts.expDir = fullfile('data_results',strcat('data_',dataset, '_',int2str(image_size), '-',int2str(image_size),'_limitedData', int2str(all_limited_target_data),'') );
    net = proj_cnn_init_33labels(num_categories, dataset);  %net = proj_cnn_init_2019(num_categories, dataset);%net = proj_cnn_init_new(num_categories);
    if all_limited_target_data==1, opts.numEpochs =  30; else, opts.numEpochs =  70; end % was 30 for phoenician and 70 for the rest
else % TL
    opts.expDir = fullfile('data_results',strcat('data_TL_from_',pretrained_net,'_to_',dataset,'_freeze',int2str(int8(freeze_all_but_last)), ...
                            '_',int2str(image_size), '-',int2str(image_size),'__limitedData99', int2str(all_limited_target_data)) );
    net = cnn_init_transferLearning(num_categories,pretrained_net, freeze_all_but_last, image_size);
    opts.numEpochs =  35; % was 35 and changed to 50 for TL from Ph to Arabic
end

[net, stats] = cnn_train(net, imdb, @getBatch, ...
    opts, ...
    'val', find(imdb.images.set == 2)) ;
[min_val,min_ind] = min([stats.val.top1err]);
fprintf('Lowest validation error is %f at epoch %d \n',min_val,min_ind )
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
