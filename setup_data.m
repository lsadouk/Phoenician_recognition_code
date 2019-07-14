function [imdb, num_categories] = setup_data(dataset, all_limited_target_data, image_size,pretrained_net)
%code for Computer Vision, Georgia Tech by James Hays
% input:    dataset= the name of the dataset to be used for training
% outputs:
%           imdb= preprocessed database
%           num_categories= #labels or classes

%This path is assumed to contain 'test' and 'train' which each contain 15
%subdirectories. The train folder has 100 samples of each category and the
%test has an arbitrary amount of each category. This is the exact data and
%train/test split used in Project 4.
SceneJPGsPath = strcat('data/', dataset,'/');
nb_instances_limited_data = 99; % was 200, 99, 51
if isequal(dataset, 'PhoenicianData') 
    nb_instances_per_char = 486;
    categories = {'1_,',	'2_B',	'3_G',	'4_D',	'5_H',...
        '6_W',	'7_Z',	'8_Ho',	'9_To',	'10_Y',	'11_K',	'12_L',...
        '13_M',	'14_N',	'15_S',	'16_ap',	'17_P',...
        '18_So',	'19_Q',	'20_R',	'21_Shat',	'22_T' ...
        };
    file_extension = 'jpg';
elseif isequal(dataset, 'TifinaghData') || isequal(dataset, 'TifinaghData_or')
    if all_limited_target_data==1,        nb_instances_per_char = nb_instances_limited_data; % was 54, 201
    else,         nb_instances_per_char = 780;
    end
    categories = {'a',	'aa',	'b',	'ch',	'd',...
         'dd',	'e',	'f',	'g',	'gh',	'h',	'hh',...
         'i',	'j',	'k',	'kh',	'l',...
         'm',	'n',	'q',	'r',	'rr',	's',	'ss',...
         't',	'tt',	'u',	'w',	 ...
         'y',	'z',	'zz',...
         'gw',	'kw'}; % these 2 have just been added
     file_extension = 'png';
elseif isequal(dataset, 'ArabicData66') 
    if all_limited_target_data==1,        nb_instances_per_char = nb_instances_limited_data; % was 54
    else,         nb_instances_per_char = 100;
    end
    categories = {'Aeen_A',	'Aeen_B',	'Aeen_E_1',	'Aeen_E_2',	'Aeen_M_1',... %5
         'Aeen_M_2',	'Alif_A',	'Alif_E',	'Alif_Lam_Jeem',	'Baa_A',	'Baa_B',	'Baa_E', 'Baa_M',... %8
         'Daal_A',	'Daal_E',	'Faa_A',	'Faa_B',	'Faa_E','Faa_M',... %6
         'Haa_A',	'Haa_B',	'Haa_E',	'Haa_M_1',	'Haa_M_2',	'Hamza_A',	'Jeem_A',... %7
         'Jeem_B',	'Jeem_E',	'Jeem_M',	'Kaaf_B',	'Kaaf_M', ... %5
         'Laam_A',	'Laam_B',	'Laam_E',  'Laam_M',... %4
         'Lam_Alif_A_1',	'Lam_Alif_A_2',  'Lam_Alif_E', 'Lam_Jeem' , 'Lam_Mem' , 'Lam_Mem_Jeem', ... %6
         'Meem_A',	'Meem_B',	'Meem_E',  'Meem_M',... %4
         'Mem_Jeem',	'Noon_A',	'Noon_E',  'Raa_A', 'Raa_E',... %5
         'Saad_A',	'Saad_B',	'Saad_E',  'Saad_M', ... %4
         'Seen_A_1',	'Seen_A_2',	'Seen_B_1',  'Seen_B_2', 'Seen_E','Seen_M',... %6
         'Taa_A',	'Taa_E',	'Waao_A',  'Waao_E', ... %4
         'Yaa_A',	'Yaa_E' ... %2
         }; 
     file_extension = 'jpg';    
elseif isequal(dataset, 'ArabicData24') 
    if all_limited_target_data==1,        nb_instances_per_char = nb_instances_limited_data; % was 54
    else,         nb_instances_per_char = 100;
    end
    categories = {'Aeen_A', 'Alif_A',	'Alif_Lam_Jeem',	'Baa_A', 'Daal_A', 'Faa_A',... %6
         'Haa_A',	'Hamza_A',	'Jeem_A',... %3
         'Kaaf_B',	'Laam_A',	'Lam_Alif_A_2', 'Lam_Jeem' , 'Lam_Mem' , 'Lam_Mem_Jeem', ... %6
         'Meem_A',	'Mem_Jeem',	'Noon_A', 'Raa_A', 'Saad_A', 'Seen_A_1',... %6
         'Taa_A',	'Waao_A',  'Yaa_A'	... %3
         }; 
     file_extension = 'jpg';         
elseif isequal(dataset, 'LatinData')
    if all_limited_target_data==1,        nb_instances_per_char = nb_instances_limited_data; % was 54 201
    else,         nb_instances_per_char = 387; % letter E contains only 388 letters
    end
    categories = {'A',	'B',	'C',	'D',...
         'E',	'F',	'G',	'H',	...
         'I',	'J',	'K',	'L',...
         'M',	'N', 'O', 'P',	'Q',	'R',	'S', ...
         'T',	'U', 'V' , 'W',	 ...
         'X', 'Y',	'Z'}; % these 2 have just been added
     file_extension = 'png';  
elseif isequal(dataset, 'RussianData')
    if all_limited_target_data==1,        nb_instances_per_char = nb_instances_limited_data; % was 54
    else,         nb_instances_per_char = 400;
    end
    categories = {	'e_dot',	'a',	'b',... %3
         'v',	'g',	'd',	'e',	...     %4
         'z_hat',	'z',	'i',	'j',...         %4
         'k',	'l', 'm', 'n',	'o',	'p',	'r', ...    %7
         's',	't', 'u' , 'f', 'x', 'c', 'c_hat', 's_hat',	 ...    %8
         's_hat_c_hat', 'double_quote',	'y', 'single_quote','e_hat', 'ju','ja'};   %7
     file_extension = 'png';         
elseif isequal(dataset, 'DevanagariData')
    if all_limited_target_data==1,        nb_instances_per_char = nb_instances_limited_data; % was 54
    else,         nb_instances_per_char = 300;
    end
    categories = {	'1_ka',	'2_kha',	'3_ga',... %3
         '4_gha',	'5_kna',	'6_cha',	'7_chha',	...     %4
         '8_ja',	'9_jha',	'10_yna',	'11_taamatar',...         %4
         '12_thaa',	'13_daa', '14_dhaa', '15_adna',	'16_tabala',	'17_tha',	'18_da', ...    %7
         '19_dha',	'20_na', '21_pa' , '22_pha', '23_ba', '24_bha', '25_ma', '26_yaw',	 ...    %8
         '27_ra', '28_la',	'29_waw', '30_motosaw','31_petchiryakha', '32_patalosaw','33_ha',...%7
         '34_chhya', '35_tra', '36_gya'};   %3
     file_extension = 'png';    
elseif isequal(dataset, 'BengaliData')
    if all_limited_target_data==1,        nb_instances_per_char = nb_instances_limited_data; % was 54
    else,         nb_instances_per_char = 224;
    end
    categories = {	'172',	'173',	'174','175','176','177','178','179',... %8
         '180',	'181',	'182',	'183','184','185','186','187','188','189',	...     %10
         '190',	'191',	'192',	'193','194','195','196','197','198','199',	...     %10
         '200',	'201',	'202',	'203','204','205','206','207','208','209',	...     %10
         '210',	'211',	'212',	'213','214','215','216','217','218','219',	...     %10
         '220',	'221',... %2
         };   
     file_extension = 'bmp';            
end

num_categories = length(categories);
num_train_per_category = 2/3 * nb_instances_per_char; % 324 = 2/3 of 486 are training images per category
num_test_per_category  = 1/3 * nb_instances_per_char; % 162 = 1/3 of 486 are testing images per category
total_images = num_categories *num_train_per_category + num_categories * num_test_per_category; %32 classes

image_size = [image_size image_size]; %downsampling + uniformising data 
if isequal(pretrained_net, 'ImageVGG'), nb_channels = 3; else, nb_channels =1; end %=1 for other pretrained models + Rand. Init. CNNs of all datasets
imdb.images.data   = zeros(image_size(1), image_size(2), nb_channels, total_images, 'single');
imdb.images.labels = zeros(1, total_images, 'single');
imdb.images.set    = zeros(1, total_images, 'uint8');
image_counter = 1;

sets = {'train', 'test'};

fprintf('Loading %d train and %d test images from each category\n', ...
          num_train_per_category, num_test_per_category)
fprintf('Each image will be resized to %d by %d\n', image_size(1),image_size(2));

%threshold = 0.88;
for set = 1:length(sets)
    for category = 1:num_categories
        cur_path = fullfile( SceneJPGsPath,  categories{category});
        cur_images = dir( fullfile( cur_path,  strcat('*.', file_extension) ) );
        
        if(set == 1)
            fprintf('Taking %d out of %d images in %s\n', num_train_per_category, length(cur_images), cur_path);
            cur_images = cur_images(1:num_train_per_category); % go from image 1 to 40
        elseif(set == 2)
            fprintf('Taking %d out of %d images in %s\n', num_test_per_category, length(cur_images), cur_path);
            cur_images = cur_images(num_train_per_category+1:num_train_per_category+num_test_per_category); % go from image 41 to 80
        end

        for i = 1:length(cur_images)
            cur_image = imread(fullfile(cur_path, cur_images(i).name));
            %if isequal(dataset, 'DevanagariData'), cur_image = 255- cur_image; end
            cur_image  = Resize_put_cadre(cur_image, image_size );
            %imshow(cur_image); % TO DELETE
            cur_image  = cur_image *255;
            
            if isequal(pretrained_net, 'ImageVGG') || isequal(pretrained_net, 'Cifar') % 3 channels for target dataset if pretrained model is VGG16
                imdb.images.data(:,:,1,image_counter) = cur_image; 
                imdb.images.data(:,:,2,image_counter) = cur_image; 
                imdb.images.data(:,:,3,image_counter) = cur_image; 
            else % 1 channel for other pretrained models + Rand. Init. CNNs of all datasets
                imdb.images.data(:,:,1,image_counter) = cur_image;
            end
            imdb.images.labels(  1,image_counter) = category;
            imdb.images.set(     1,image_counter) = set; %1 for train, 2 for test (val?)
            
            image_counter = image_counter + 1;
        end
    end
end


%%  Zero centering images METHOD1 : substract the mean image of all images from each image
% % calculate the mean from the array
% mean_img = mean(imdb.images.data,4);
% % subtract the mean image from all the images in array
% imdb.images.data = imdb.images.data - repmat(mean_img,[1 1 1 size(imdb.images.data,4)]);
% % % another method
% % for i = 1:size(imdb.images.data,4)
% %     imdb.images.data(:,:,:,i) = imdb.images.data(:,:,:,i) - mean_img;
% % end

