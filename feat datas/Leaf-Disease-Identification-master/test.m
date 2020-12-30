% Training Part
%Features of Dermatitis
for i=1:1332
    disp(['Processing frame1 no.',num2str(i)]);
    img=imread(['D:\4.1\Thesis\DATASET\Final dataset22\Dermatitis_augmented\test2\',num2str(i),'.png']);
    %img = imresize(img,[256,256]);
    %img = imadjust(img,stretchlim(img));
    %imshow(img);title('Anthracnose Leaf Image');
    [feat_disease] =  EvaluateFeatures3(img);
    Dermatitis_Test(i,:) = feat_disease;
    save Dermatitis_Test;
    close all
end

% Features of Impetigo
for i=1:1332
    disp(['Processing frame2 no.',num2str(i)]);
    img=imread(['D:\4.1\Thesis\DATASET\Final dataset22\Impetigo_augmented\test2\',num2str(i),'.png']);
    
   
    [feat_disease] =  EvaluateFeatures2(img);
    Impetigo_Test(i,:) = feat_disease;
    save Impetigo_Test;
    close all
end

% Features of Melanoma
for i=1:1332
    disp(['Processing frame3 no.',num2str(i)]);
    img=imread(['D:\4.1\Thesis\DATASET\Final dataset22\melanoma(isic+ph21)\test2\',num2str(i),'.png']);
    
    
    [feat_disease] =  EvaluateFeatures(img);
    Melanoma_Test(i,:) = feat_disease;
    save Melanoma_Test;
    close all
end

% Featurs of Ulcer
for i=1:1332
    disp(['Processing frame4 no.',num2str(i)]);
    img=imread(['D:\4.1\Thesis\DATASET\Final dataset22\Ulcer_augmented\test2\',num2str(i),'.png']);
    
    [feat_disease] =  EvaluateFeatures3(img);
    Ulcer_Test(i,:) = feat_disease;
    save Ulcer_Test;
    close all
end


%
% Dataset Preparation
close all
clear all
clc
load('Dermatitis_Test.mat')
load('Impetigo_Test.mat')
load('Melanoma_Test.mat')
load('Ulcer_Test.mat')


Test_Feat = [Melanoma_Test;Dermatitis_Test;Ulcer_Test;Impetigo_Test];
save Test_Feat;
Test_Label = [ ones(1332,1)*3; ones(1332,1);ones(1332,1)*4;ones(1332,1)*2 ];
save Test_Label;


%