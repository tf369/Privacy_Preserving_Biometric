%% The script for preparation of the datasets
%% Using Bag of Features for Feature Extraction and SVM for Classification
clear all; close all; clc;
%% Preparing Environment
Img_Files = { ...
    'C:\Users\shaya\Desktop\Milad Work\Chosen Dataset\Fingerprint\P01\L\I1_P01_Ref.jpg'; ...
    'C:\Users\shaya\Desktop\Milad Work\Chosen Dataset\Fingerprint\P01\L\I2_P01_Tst.jpg'; ...
    'C:\Users\shaya\Desktop\Milad Work\Chosen Dataset\Fingerprint\P01\L\I3_P01_Tst.jpg'; ...
    'C:\Users\shaya\Desktop\Milad Work\Chosen Dataset\Fingerprint\P01\R\I1_P01_Ref.jpg'; ...
    'C:\Users\shaya\Desktop\Milad Work\Chosen Dataset\Fingerprint\P01\R\I2_P01_Tst.jpg'; ...
    'C:\Users\shaya\Desktop\Milad Work\Chosen Dataset\Fingerprint\P01\R\I3_P01_Tst.jpg'; ...
    'C:\Users\shaya\Desktop\Milad Work\Chosen Dataset\Fingerprint\P10\L\I1_P10_Ref.jpg'; ...
    'C:\Users\shaya\Desktop\Milad Work\Chosen Dataset\Fingerprint\P10\L\I2_P10_Tst.jpg'; ...
    'C:\Users\shaya\Desktop\Milad Work\Chosen Dataset\Fingerprint\P10\L\I3_P10_Tst.jpg'; ...
    'C:\Users\shaya\Desktop\Milad Work\Chosen Dataset\Fingerprint\P10\R\I1_P10_Ref.jpg'; ...
    'C:\Users\shaya\Desktop\Milad Work\Chosen Dataset\Fingerprint\P10\R\I2_P10_Tst.jpg'; ...
    'C:\Users\shaya\Desktop\Milad Work\Chosen Dataset\Fingerprint\P10\R\I3_P10_Tst.jpg'; ...
    'C:\Users\shaya\Desktop\Milad Work\Chosen Dataset\Fingerprint\P25\L\I1_P25_Ref.jpg'; ...
    'C:\Users\shaya\Desktop\Milad Work\Chosen Dataset\Fingerprint\P25\L\I2_P25_Tst.jpg'; ...
    'C:\Users\shaya\Desktop\Milad Work\Chosen Dataset\Fingerprint\P25\L\I3_P25_Tst.jpg'; ...
    'C:\Users\shaya\Desktop\Milad Work\Chosen Dataset\Fingerprint\P25\R\I1_P25_Ref.jpg'; ...
    'C:\Users\shaya\Desktop\Milad Work\Chosen Dataset\Fingerprint\P25\R\I2_P25_Tst.jpg'; ...
    'C:\Users\shaya\Desktop\Milad Work\Chosen Dataset\Fingerprint\P25\R\I3_P25_Tst.jpg'; ...
    'C:\Users\shaya\Desktop\Milad Work\Chosen Dataset\Fingerprint\P38\L\I1_P38_Ref.jpg'; ...
    'C:\Users\shaya\Desktop\Milad Work\Chosen Dataset\Fingerprint\P38\L\I2_P38_Tst.jpg'; ...
    'C:\Users\shaya\Desktop\Milad Work\Chosen Dataset\Fingerprint\P38\L\I3_P38_Tst.jpg'; ...
    'C:\Users\shaya\Desktop\Milad Work\Chosen Dataset\Fingerprint\P38\R\I1_P38_Ref.jpg'; ...
    'C:\Users\shaya\Desktop\Milad Work\Chosen Dataset\Fingerprint\P38\R\I2_P38_Tst.jpg'; ...
    'C:\Users\shaya\Desktop\Milad Work\Chosen Dataset\Fingerprint\P38\R\I3_P38_Tst.jpg'; ...
    'C:\Users\shaya\Desktop\Milad Work\Chosen Dataset\Iris\P01\L\I1_P01_Ref.jpg'; ...
    'C:\Users\shaya\Desktop\Milad Work\Chosen Dataset\Iris\P01\L\I2_P01_Tst.jpg'; ...
    'C:\Users\shaya\Desktop\Milad Work\Chosen Dataset\Iris\P01\L\I3_P01_Tst.jpg'; ...
    'C:\Users\shaya\Desktop\Milad Work\Chosen Dataset\Iris\P01\R\I1_P01_Ref.jpg'; ...
    'C:\Users\shaya\Desktop\Milad Work\Chosen Dataset\Iris\P01\R\I2_P01_Tst.jpg'; ...
    'C:\Users\shaya\Desktop\Milad Work\Chosen Dataset\Iris\P01\R\I3_P01_Tst.jpg'; ...
    'C:\Users\shaya\Desktop\Milad Work\Chosen Dataset\Iris\P10\L\I1_P10_Ref.jpg'; ...
    'C:\Users\shaya\Desktop\Milad Work\Chosen Dataset\Iris\P10\L\I2_P10_Tst.jpg'; ...
    'C:\Users\shaya\Desktop\Milad Work\Chosen Dataset\Iris\P10\L\I3_P10_Tst.jpg'; ...
    'C:\Users\shaya\Desktop\Milad Work\Chosen Dataset\Iris\P10\R\I1_P10_Ref.jpg'; ...
    'C:\Users\shaya\Desktop\Milad Work\Chosen Dataset\Iris\P10\R\I2_P10_Tst.jpg'; ...
    'C:\Users\shaya\Desktop\Milad Work\Chosen Dataset\Iris\P10\R\I3_P10_Tst.jpg'; ...
    'C:\Users\shaya\Desktop\Milad Work\Chosen Dataset\Iris\P25\L\I1_P25_Ref.jpg'; ...
    'C:\Users\shaya\Desktop\Milad Work\Chosen Dataset\Iris\P25\L\I2_P25_Tst.jpg'; ...
    'C:\Users\shaya\Desktop\Milad Work\Chosen Dataset\Iris\P25\L\I3_P25_Tst.jpg'; ...
    'C:\Users\shaya\Desktop\Milad Work\Chosen Dataset\Iris\P25\R\I1_P25_Ref.jpg'; ...
    'C:\Users\shaya\Desktop\Milad Work\Chosen Dataset\Iris\P25\R\I2_P25_Tst.jpg'; ...
    'C:\Users\shaya\Desktop\Milad Work\Chosen Dataset\Iris\P25\R\I3_P25_Tst.jpg'; ...
    'C:\Users\shaya\Desktop\Milad Work\Chosen Dataset\Iris\P38\L\I1_P38_Ref.jpg'; ...
    'C:\Users\shaya\Desktop\Milad Work\Chosen Dataset\Iris\P38\L\I2_P38_Tst.jpg'; ...
    'C:\Users\shaya\Desktop\Milad Work\Chosen Dataset\Iris\P38\L\I3_P38_Tst.jpg'; ...
    'C:\Users\shaya\Desktop\Milad Work\Chosen Dataset\Iris\P38\R\I1_P38_Ref.jpg'; ...
    'C:\Users\shaya\Desktop\Milad Work\Chosen Dataset\Iris\P38\R\I2_P38_Tst.jpg'; ...
    'C:\Users\shaya\Desktop\Milad Work\Chosen Dataset\Iris\P38\R\I3_P38_Tst.jpg'; ...
    };
img_train = imageDatastore(Img_Files);
img_train.Labels = { ...
'P01_Finger_Left'; ...
'P01_Finger_Left'; ... 
'P01_Finger_Left'; ...
'P01_Finger_Right'; ...
'P01_Finger_Right'; ... 
'P01_Finger_Right'; ...
'P10_Finger_Left'; ...
'P10_Finger_Left'; ... 
'P10_Finger_Left'; ...
'P10_Finger_Right'; ...
'P10_Finger_Right'; ... 
'P10_Finger_Right'; ...
'P25_Finger_Left'; ...
'P25_Finger_Left'; ... 
'P25_Finger_Left'; ...
'P25_Finger_Right'; ...
'P25_Finger_Right'; ... 
'P25_Finger_Right'; ...
'P38_Finger_Left'; ...
'P38_Finger_Left'; ... 
'P38_Finger_Left'; ...
'P38_Finger_Right'; ...
'P38_Finger_Right'; ... 
'P38_Finger_Right'; ...
'P01_Iris_Left'; ...
'P01_Iris_Left'; ... 
'P01_Iris_Left'; ...
'P01_Iris_Right'; ...
'P01_Iris_Right'; ... 
'P01_Iris_Right'; ...
'P10_Iris_Left'; ...
'P10_Iris_Left'; ... 
'P10_Iris_Left'; ...
'P10_Iris_Right'; ...
'P10_Iris_Right'; ... 
'P10_Iris_Right'; ...
'P25_Iris_Left'; ...
'P25_Iris_Left'; ... 
'P25_Iris_Left'; ...
'P25_Iris_Right'; ...
'P25_Iris_Right'; ... 
'P25_Iris_Right'; ...
'P38_Iris_Left'; ...
'P38_Iris_Left'; ... 
'P38_Iris_Left'; ...
'P38_Iris_Right'; ...
'P38_Iris_Right'; ... 
'P38_Iris_Right'; ...
};
% Feature Extraction = Bag of Features
% Classifier = Support Vector Machine
bag = bagOfFeatures(img_train);
categoryClassifier = trainImageCategoryClassifier(img_train,bag);
confMatrix = evaluate(categoryClassifier,img_train)
mean(diag(confMatrix))
img_Test = 'C:\Users\shaya\Desktop\Milad Work\Chosen Dataset\Iris\P25\L\I5_P25_Tst.jpg';
img = imread(img_Test);
[labelIdx, score] = predict(categoryClassifier,img)
categoryClassifier.Labels(labelIdx)