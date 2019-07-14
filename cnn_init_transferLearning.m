function net = cnn_init_transferLearning(num_categories,pretrained_net, freeze_all_but_last, image_size)

if isequal(pretrained_net, 'ImageVGG') 
    %% for  vgg-f
    %net = load(fullfile(strcat('data_results/data_', pretrained_net,'Data_',int2str(image_size), '-',int2str(image_size), '/imagenet-matconvnet-vgg-f.mat')));
    %last_FC_layer_nb_neurons=4096;
    %% for  alexnet
    net = load(fullfile(strcat('data_results/data_', pretrained_net,'Data_',int2str(image_size), '-',int2str(image_size), '/imagenet-caffe-alex.mat')));
    last_FC_layer_nb_neurons=4096;
else
    if isequal(pretrained_net, 'Phoenician') 
        nb_epochs = '57'; % was 23 for previous simulations
    elseif isequal(pretrained_net, 'Latin') 
        nb_epochs = '58'; % 58 for nb_instances=all_Emnist_reshaped(388) % 67 for nb_instances=all_Emnist_original(388) was 59 for nb_instances=54
    elseif isequal(pretrained_net, 'Digits') 
        nb_epochs = '13';
    elseif isequal(pretrained_net, 'Cifar') 
        nb_epochs = '118';        
    end
    %net = load(fullfile(strcat('data_results/data_', pretrained_net ,'Data_60-60/net-epoch-59.mat'))); % from Latin_to_Tig: pretrained Latin epoch28
    net = load(fullfile(strcat('data_results/data_', pretrained_net ,'Data_',int2str(image_size), '-',int2str(image_size), '_limitedData0/net-epoch-',nb_epochs,'.mat')));
    last_FC_layer_nb_neurons=500;
    net = net.net;
end


f=1/100; 
net.layers = net.layers(1:end-2);
net.layers{end + 1} = struct('type', 'conv', ...
                               'weights', {{f*randn(1,1,last_FC_layer_nb_neurons,num_categories, 'single'), zeros(1, num_categories, 'single')}}, ...
                               'size', [1 1 last_FC_layer_nb_neurons num_categories], ...
                               'stride', 1, ...
                               'pad', 0, ...
                               'name', 'fc3') ;
net.layers{end+1} = struct('type', 'softmaxloss', ...
                               'stride', 1, ...
                               'pad', 0) ;  

if freeze_all_but_last %freeze all layer weights expect weights of last 2 layers
    for i= 1:length(net.layers(1:end-2))
        net.layers{i}.learningRate = [0 0];
    end
end
%vl_simplenn_display(net, 'inputSize', [50 1 3 50])  % was [90 1 3 50]
disp(size(net.layers));



end
