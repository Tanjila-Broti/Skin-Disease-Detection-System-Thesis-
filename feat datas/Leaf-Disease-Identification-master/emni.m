%X_train = coder.load('Dermatitis_Feat.mat');
%y_train = coder.load('Impetigo_Feat.mat'); 
%X_test = coder.load('Melanoma_Feat.mat'); 
%y_test = coder.load('Ulcer_Feat.mat');
%Dermatitis_Feat=cell2mat(struct2cell(X_train));
%Impetigo_Feat=cell2mat(struct2cell(y_train));
%Melanoma_Feat=cell2mat(struct2cell(X_test));
%Ulcer_Feat=cell2mat(struct2cell(y_test));
%Train_Feat = [Impetigo_Feat;Melanoma_Feat];
%save Train_Feat;

I = imread('D:\4.2\DIP Lab\Lab1\peppers_color.jpg');
 %imshow(I)
 figure, imhist(I);
  J = histeq(I);
 subplot(2,2,1), imshow(I); 
 subplot(2,2,2), imhist(I);
 subplot(2,2,3), histeq(I);
 subplot(2,2,4), imhist(J);
clc
clear
I=imread('D:\4.2\DIP Lab\Lab1\peppers_color.jpg');
NewI=zeros(size(I));
[m,n]=size(I);
for i=1:m
    for j=1:n
     if(I(i,j)<127)
         NewI(i,j)=0;
     else
          NewI(i,j)=1;          
     end         
    end
end
subplot(1,2,1), imshow(I);
subplot(1,2,2), imshow(NewI);
clc
clear
i1 = imread('D:\4.2\DIP Lab\Lab1\peppers_color.jpg');
% [m,n]=size(i1);
% new=imresize(i1,[m*3 n/3]);
% subplot(2,2,1), imshow(i1);
% subplot(2,2,2), imshow(new);
% 
% I = rgb2gray(i1);
% I1 = im2bw(i1);
% 
% subplot(2,2,3), imshow(I);
% subplot(2,2,4), imshow(I1);
subplot(1,4,1),imshow(i1(:,:,1));
subplot(1,4,2),imshow(i1(:,:,2));
subplot(1,4,3),imshow(i1(:,:,3));
subplot(1,4,4),imshow(i1);
