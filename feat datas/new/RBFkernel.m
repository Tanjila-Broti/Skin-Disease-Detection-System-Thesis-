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
%number of class-6
%number of test samples-2947
SVMModel = cell(4,1);
label = zeros(4,5504);

%1 in the place of index, other class 0
trainingClassLabelsMatrix = full(ind2vec(y_train_transpose,4));

%train the model one-vs-all
for index=1:4
    SVMModel{index} = fitcsvm(Train_Feat,trainingClassLabelsMatrix(index,:),'Standardize',true,'KernelFunction','RBF',...
  'KernelScale', 'auto');
end

%predict values
for index=1:4
    label(index,:) = predict(SVMModel{index},Test_Feat);
end

%transform into index
predictedLabel=vec2ind(label);
cp = classperf(y_test_transpose,predictedLabel);
fprintf('Accuracy: %f\n',1- cp.ErrorRate);
fprintf('Sensitivity: %f\n',cp.Sensitivity);
fprintf('Specificity: %f\n\n',cp.Specificity);

%calculate accuracy
accuracy = sum(y_test_transpose == predictedLabel)/length(y_test_transpose);
accuracyPercentage = 100*accuracy;
fprintf('Accuracy = %f%%\n',accuracyPercentage)

T = y_test_transpose; % True classes
Y = predictedLabel; % Predicted classes

M = size(unique(T),2);
N = size(T,2);
targets = zeros(M,N);
outputs = zeros(M,N);
targetsIdx = sub2ind(size(targets), T, 1:N);
outputsIdx = sub2ind(size(outputs), Y, 1:N);
targets(targetsIdx) = 1;
outputs(outputsIdx) = 1;
% Plot the confusion matrix
plotconfusion(targets,outputs)

h = gca;
h.XTickLabel = {'Class A','Class B','Class C','Class D',''};
h.YTickLabel = {'Class A','Class B','Class C','Class D',''};
h.YTickLabelRotation = 90;


actual=T(:);
predict=Y(:);
group =T(:);
grouphat = Y(:);

un_actual=unique(actual);
un_predict=unique(predict);

class_list=un_actual;
disp('Class List in given sample')
disp(class_list)
fprintf('\nTotal Instance = %d\n',length(actual));
n_class=length(un_actual);
c_matrix=zeros(n_class);
predict_class=cell(1,n_class);
class_ref=cell(n_class,1);
row_name=cell(1,n_class);
            %Calculate confusion for all classes
 for i=1:n_class
      class_ref{i,1}=strcat('class',num2str(i),'==>',num2str(class_list(i)));
      for j=1:n_class
          val=(actual==class_list(i)) & (predict==class_list(j));
          c_matrix(i,j)=sum(val);
          predict_class{i,j}=sum(val);
      end          
          row_name{i}=strcat('Actual_class',num2str(i));
          disp(class_ref{i})
  end
 c_matrix_table=cell2table(predict_class);
 c_matrix_table.Properties.RowNames=row_name;
 disp('Confusion Matrix')
 disp(c_matrix_table)
 value1 = confusionmat(group,grouphat)
 numOfClasses = size(value1,1);
totalSamples = sum(sum(value1));
    
field2 = 'accuracy';  
value2 = (2*trace(value1)+sum(sum(2*value1)))/(numOfClasses*totalSamples);

[TP,TN,FP,FN,sensitivity,specificity,precision,f_score] = deal(zeros(numOfClasses,1));
for class = 1:numOfClasses
   TP(class) = value1(class,class);
   tempMat = value1;
   tempMat(:,class) = []; % remove column
   tempMat(class,:) = []; % remove row
   TN(class) = sum(sum(tempMat));
   FP(class) = sum(value1(:,class))-TP(class);
   FN(class) = sum(value1(class,:))-TP(class);
end
 P=TP(class)+FN(class);
 N=FP(class)+TN(class);

for class = 1:numOfClasses
    accuracy(class)=(TP(class)+TN(class))/(P+N);
    sensitivity(class) = TP(class) / (TP(class) + FN(class));
    specificity(class) = TN(class) / (FP(class) + TN(class));
    precision(class) = TP(class) / (TP(class) + FP(class));
    f_score(class) = 2*TP(class)/(2*TP(class) + FP(class) + FN(class));
end
accuracy=accuracy(:,1);
fprintf('Accuracy = %f%%\n\n\n',accuracy*100)

FPR=1-specificity;%false positive rate
Error=1-accuracy;
disp(accuracy)
disp(mean(sensitivity))
disp(mean(specificity))
disp(mean(precision))
disp(mean(f_score))
disp(mean(FPR))
disp(Error)
