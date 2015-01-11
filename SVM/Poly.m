clc 
clear
load test.mat;

X_tr = test(:,2:3);
temp = test(:,1);
n = size(X_tr,1);

Ein_all = [];
for i=0:9,
    %=take for =%
    com = ones(n,1).*i;
    y_tr = temp==com;
    y_tr = (y_tr - 0.5).*2;

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

    c = 0.01;
    Q = 2;
    opt = sprintf('-s 0 -c %f -t 1 -g 1 -r 1 -d %d', c, Q);
    model = svmtrain(y_tr, X_tr,opt);
    [predict_label, accuracy, dec_values] = svmpredict(y_tr, X_tr, model);

    Ein = sum(abs(y_tr - predict_label)/2)/n;
    Ein_all = [Ein_all;i Ein];
       
end

plot2class(X_tr, y_tr);