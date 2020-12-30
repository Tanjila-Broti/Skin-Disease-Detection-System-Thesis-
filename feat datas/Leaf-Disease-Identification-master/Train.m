%{
    % Training Part
%Features of Dermatitis
for i=1:1376
    disp(['Processing frame1 no.',num2str(i)]);
    img=imread(['D:\4.1\Thesis\DATASET\Final dataset\Dermatitis_augmented\train\',num2str(i),'.png']);
    %img = imresize(img,[256,256]);
    %img = imadjust(img,stretchlim(img));
    %imshow(img);title('Anthracnose Leaf Image');
    [feat_disease] =  EvaluateFeatures3(img);
    Dermatitis_Train2(i,:) = feat_disease;
    save Dermatitis_Train2;
    close all
end

% Features of Impetigo
for i=1:1376
    disp(['Processing frame2 no.',num2str(i)]);
    img=imread(['D:\4.1\Thesis\DATASET\Final dataset\Impetigo_augmented\train\',num2str(i),'.png']);
    
   
    [feat_disease] =  EvaluateFeatures2(img);
    Impetigo_Train2(i,:) = feat_disease;
    save Impetigo_Train2;
    close all
end

% Features of Melanoma
for i=1:1376
    disp(['Processing frame3 no.',num2str(i)]);
    img=imread(['D:\4.1\Thesis\DATASET\Final dataset\melanoma(isic+ph21)\train\',num2str(i),'.png']);
    
    
    [feat_disease] =  EvaluateFeatures(img);
    Melanoma_Train2(i,:) = feat_disease;
    save Melanoma_Train2;
    close all
end

% Featurs of Ulcer
for i=1:1376
    disp(['Processing frame4 no.',num2str(i)]);
    img=imread(['D:\4.1\Thesis\DATASET\Final dataset\Ulcer_augmented\train\',num2str(i),'.png']);
    
    [feat_disease] =  EvaluateFeatures3(img);
    Ulcer_Train2(i,:) = feat_disease;
    save Ulcer_Train2;
    close all
end


%
% Dataset Preparation
close all
clc
load('Dermatitis_Train2.mat')
load('Impetigo_Train2.mat')
load('Melanoma_Train2.mat')
load('Ulcer_Train2.mat')


Train_Feat = [Dermatitis_Train2;Impetigo_Train2;Melanoma_Train2;Ulcer_Train2];
save Train_Feat2;
%}
Train_Label = [ ones(1376,1); ones(1376,1)*2;ones(1376,1)*3;ones(1376,1)*4 ];
save Train_Label2;


%