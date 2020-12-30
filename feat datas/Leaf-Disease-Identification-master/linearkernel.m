clc;
clear all;
close all;


load('Train_Feat.mat');
load('Train_Label.mat'); 
load('Test_Feat.mat'); 
load('Test_Label.mat');



%transposing the class label vectors
y_train_transpose = transpose(Train_Label);
y_test_transpose = transpose(Test_Label);

%initialization
%number of class-4
%number of test samples-5504
SVMModel = cell(4,1);
label = zeros(4,5504);

%1 in the place of index, other class 0
trainingClassLabelsMatrix = full(ind2vec(y_train_transpose,4));

%train the model one-vs-all
for index=1:4
    SVMModel{index} = fitcsvm(Train_Feat,trainingClassLabelsMatrix(index,:),'KernelFunction','linear');
end

%predict values
%load img
%filename
%nm=split filename

%Test_Feat=Test_Feat(57,:);
%X_test=X_test(nm,:);
for index=1:4
    label(index,:) = predict(SVMModel{index},Test_Feat);
end

%transform into index
predictedLabel=vec2ind(label);
result=predictedLabel;

if result==1
msgbox('Dermatitis')
elseif result==2
msgbox('Impetigo')
elseif result==3   
 msgbox('Melanoma')
elseif result==4
 msgbox('Ulcer')
 
end

%calculate accuracy
accuracy = sum(y_test_transpose == predictedLabel)/length(y_test_transpose);
accuracyPercentage = 100*accuracy;
fprintf('Accuracy = %f%%\n',accuracyPercentage)
