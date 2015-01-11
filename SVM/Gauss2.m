clc 
clear
load train.mat;
load test.mat;

X_tr = train(:,2:3);
temp = train(:,1);
n = size(X_tr,1);


%=take for =%
com = ones(n,1).*0;
y_tr = temp==com;
y_tr = (y_tr - 0.5).*2;

X_te = test(:,2:3);
temp = test(:,1);
nte = size(X_te,1);


%=take for =%
com = ones(nte,1).*0;
y_te = temp==com;
y_te = (y_te - 0.5).*2;

Ein_all = [];

% -s svm_type : set type of SVM (default 0)
% 	0 -- C-SVC
% 	1 -- nu-SVC
% 	2 -- one-class SVM
% 	3 -- epsilon-SVR
% 	4 -- nu-SVR
% -t kernel_type : set type of kernel function (default 2)
% 	0 -- linear: u'*v
% 	1 -- polynomial: (gamma*u'*v + coef0)^degree
% 	2 -- radial basis function: exp(-gamma*|u-v|^2)
% 	3 -- sigmoid: tanh(gamma*u'*v + coef0)
% -d degree : set degree in kernel function (default 3)
% -g gamma : set gamma in kernel function (default 1/num_features)
% -r coef0 : set coef0 in kernel function (default 0)
% -c cost : set the parameter C of C-SVC, epsilon-SVR, and nu-SVR (default 1)
for g =[1 10 100 1000 10000],
    opt = sprintf('-s 0 -c 0.1 -t 2 -g %d', g);
    model = svmtrain(y_tr, X_tr,opt);
    [predict_label, accuracy, dec_values] = svmpredict(y_tr, X_tr, model);
    [predict_label_te, accuracy_te, dec_values_te] = svmpredict(y_te, X_te, model);

    Ein = sum(abs(y_tr - predict_label)/2)/n;
    Ein_all = [Ein_all;g 100-accuracy(1) model.totalSV 100-accuracy_te(1)];
end

sr = sortrows(Ein_all,4);
fprintf('\nThe smallest Eout is in %d, which is %f\n', sr(1,1), sr(1,4));
%plot2class(X_tr, y_tr);