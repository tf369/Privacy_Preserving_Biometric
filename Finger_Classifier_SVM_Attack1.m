%% The Script for Classifying the Fingerprint Biometric Data
%% Preparing Environment
tic;
clear all; close all; clc;
Fing_With_Path = 'C:\Users\shaya\Desktop\Milad Work\Chosen Dataset\True_Fake_Fingerprint\With_Cooperation';
Fing_Without_Path = 'C:\Users\shaya\Desktop\Milad Work\Chosen Dataset\True_Fake_Fingerprint\Without_Cooperation';

%% Getting Training Data

% Train_Files --> The files for training
% Train_Labels --> The labels for training

img_ix = 1; % The index of the vector of image files

Fing_With_Dir = dir(Fing_With_Path);

for iq = 3:length(Fing_With_Dir)
    img_dir = Fing_With_Dir(iq);
    fake_path = [Fing_With_Path,'\',img_dir.name,'\Fake'];
    true_path = [Fing_With_Path,'\',img_dir.name,'\True'];
    fake_imgs = dir(fake_path);
    true_imgs = dir(true_path);
    
    for iw = 3:length(fake_imgs)
        if (strcmp(fake_imgs(iw).name((end-5):(end-4)),'01') || strcmp(fake_imgs(iw).name((end-5):(end-4)),'02'))
            Train_Files{img_ix} = [fake_path,'\',fake_imgs(iw).name];
            Train_Labels{img_ix} = 'Fake';
            img_ix = img_ix + 1;
        end
    end
    
    for iw = 3:length(true_imgs)
          if (strcmp(true_imgs(iw).name((end-5):(end-4)),'01') || strcmp(true_imgs(iw).name((end-5):(end-4)),'02'))
              Train_Files{img_ix} = [true_path,'\',true_imgs(iw).name];
              Train_Labels{img_ix} = 'True';
              img_ix = img_ix + 1;
          end
    end
end

Fing_Without_Dir = dir(Fing_Without_Path);

for iq = 3:length(Fing_Without_Dir)
    img_dir = Fing_Without_Dir(iq);
    fake_path = [Fing_Without_Path,'\',img_dir.name,'\Fake'];
    true_path = [Fing_Without_Path,'\',img_dir.name,'\True'];
    fake_imgs = dir(fake_path);
    true_imgs = dir(true_path);
    
    for iw = 3:length(fake_imgs)
        if (strcmp(fake_imgs(iw).name((end-5):(end-4)),'01') || strcmp(fake_imgs(iw).name((end-5):(end-4)),'02'))
            Train_Files{img_ix} = [fake_path,'\',fake_imgs(iw).name];
            Train_Labels{img_ix} = 'Fake';
            img_ix = img_ix + 1;
        end
    end
    
    for iw = 3:length(true_imgs)
          if (strcmp(true_imgs(iw).name((end-5):(end-4)),'01') || strcmp(true_imgs(iw).name((end-5):(end-4)),'02'))
              Train_Files{img_ix} = [true_path,'\',true_imgs(iw).name];
              Train_Labels{img_ix} = 'True';
              img_ix = img_ix + 1;
          end
    end
end

img_train = imageDatastore(Train_Files);
img_train.Labels = Train_Labels;

%% Getting Testing Data

% Test_Files --> The files for testing
% Test_Labels --> The labels for testing

img_iy = 1; % The index of the vector of image files

Fing_With_Dir = dir(Fing_With_Path);

for iq = 3:length(Fing_With_Dir)
    img_dir = Fing_With_Dir(iq);
    fake_path = [Fing_With_Path,'\',img_dir.name,'\Fake'];
    true_path = [Fing_With_Path,'\',img_dir.name,'\True'];
    fake_imgs = dir(fake_path);
    true_imgs = dir(true_path);
    
    for iw = 3:length(fake_imgs)
        if (strcmp(fake_imgs(iw).name((end-5):(end-4)),'03') || strcmp(fake_imgs(iw).name((end-5):(end-4)),'04'))
            Test_Files{img_iy} = [fake_path,'\',fake_imgs(iw).name];
            Test_Labels{img_iy} = 'Fake';
            img_iy = img_iy + 1;
        end
    end
    
    for iw = 3:length(true_imgs)
          if (strcmp(true_imgs(iw).name((end-5):(end-4)),'03') || strcmp(true_imgs(iw).name((end-5):(end-4)),'04'))
              Test_Files{img_iy} = [true_path,'\',true_imgs(iw).name];
              Test_Labels{img_iy} = 'True';
              img_iy = img_iy + 1;
          end
    end
end

Fing_Without_Dir = dir(Fing_Without_Path);

for iq = 3:length(Fing_Without_Dir)
    img_dir = Fing_Without_Dir(iq);
    fake_path = [Fing_Without_Path,'\',img_dir.name,'\Fake'];
    true_path = [Fing_Without_Path,'\',img_dir.name,'\True'];
    fake_imgs = dir(fake_path);
    true_imgs = dir(true_path);
    
    for iw = 3:length(fake_imgs)
        if (strcmp(fake_imgs(iw).name((end-5):(end-4)),'03') || strcmp(fake_imgs(iw).name((end-5):(end-4)),'04'))
            Test_Files{img_iy} = [fake_path,'\',fake_imgs(iw).name];
            Test_Labels{img_iy} = 'Fake';
            img_iy = img_iy + 1;
        end
    end
    
    for iw = 3:length(true_imgs)
          if (strcmp(true_imgs(iw).name((end-5):(end-4)),'03') || strcmp(true_imgs(iw).name((end-5):(end-4)),'04'))
              Test_Files{img_iy} = [true_path,'\',true_imgs(iw).name];
              Test_Labels{img_iy} = 'True';
              img_iy = img_iy + 1;
          end
    end
end

img_test = imageDatastore(Test_Files);
img_test.Labels = Test_Labels;

%% Using CNN for Feature Extraction and SVM for Classification
% Feature Extraction = Convolutional Neural Network
% Classifier = Support Vector Machine
net = alexnet();
img_train.ReadFcn = @(filename)readAndPreprocessImage(filename);
featureLayer = 'fc7';
trainingFeatures = activations(net,img_train, featureLayer, ...
    'MiniBatchSize', 32, 'OutputAs', 'columns');
%{
% Attack 1: Manipulation of the Labels
mal_labels = img_train.Labels;
ix = 1;
while (ix <= (length(img_train.Labels)/2))
    indx_1 = floor(512*rand()+1);
    indx_2 = floor(512*rand()+1);
    rand_1 = img_train.Labels(indx_1);
    rand_2 = img_train.Labels(indx_2);
    if (cellfun(@strcmp,rand_1,rand_2) == 0)
        mal_labels(indx_1) = rand_2;
        mal_labels(indx_2) = rand_1;
        ix = ix + 1;
    end
end

figure();
subplot(2,1,1);
plot(find(strcmp(mal_labels,'True')),'-b','LineWidth',1.5);
hold on;
plot(find(strcmp(img_train.Labels,'True')),':k','LineWidth',1.5);
hold off;
ylabel(['Index in Label Array'], 'FontSize', 14);
xlabel('Index in True Array', 'FontSize', 14);
title('Comparison Between Actual and Manipulated True Labels', 'FontSize', 14);
AX=legend('Manipulated Labels','Acual Labels','Location','SouthEast');
LEG = findobj(AX,'type','text');
set(LEG,'FontSize',10);
set(gca, 'fontsize', 10);

subplot(2,1,2);
plot(find(strcmp(mal_labels,'Fake')),'-r','LineWidth',1.5);
hold on;
plot(find(strcmp(img_train.Labels,'Fake')),':k','LineWidth',1.5);
hold off;
ylabel(['Index in Label Array'], 'FontSize', 14);
xlabel('Index in Fake Array', 'FontSize', 14);
title('Comparison Between Actual and Manipulated Fake Labels', 'FontSize', 14);
AX=legend('Manipulated Labels','Acual Labels','Location','SouthEast');
LEG = findobj(AX,'type','text');
set(LEG,'FontSize',10);
set(gca, 'fontsize', 10);
%}

classifier = fitcecoc(trainingFeatures,img_train.Labels, ...
    'Learners', 'Linear', 'Coding', 'onevsall', 'ObservationsIn', 'columns');

img_test.ReadFcn = @(filename)readAndPreprocessImage(filename);
testFeatures = activations(net,img_test,featureLayer,'MiniBatchSize',32);
predictedLabels = predict(classifier, testFeatures);

% TP = A "True" is correctly recognized as "True".
% TN = A "Fake" is correctly recognized as "Fake".
% FP = A "Fake" is wrongly recognized as "True".
% FN = A "True" is wrognly recognized as "Fake".

TP = 0; TN = 0; FP = 0; FN = 0;
for iq = 1:length(predictedLabels)
    if (isequal(img_test.Labels(iq),{'True'}))
        if (isequal(predictedLabels(iq),{'True'}))
            TP = TP + 1;
        else
            FN = FN + 1;
        end
	else
        if (isequal(predictedLabels(iq),{'Fake'}))
            TN = TN + 1;
        else
            FP = FP + 1;
        end
    end
end

Perf_Data = [TP,FN;FP,TN];
Perf_Mat = [(TP/(TP+FN)),(FN/(FN+TP));(FP/(FP+TN)),(TN/(TN+FP))];
toc;