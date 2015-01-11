clc 
clear
load train.mat;
load test.mat;

X_tra = train(:,2:3);
temp = train(:,1);
n = size(X_tra,1);


%=take for =%
com = ones(n,1).*0;
y_tra = temp==com;
y_tra = (y_tra - 0.5).*2;

X_te = test(:,2:3);
temp = test(:,1);
nte = size(X_te,1);


%=take for =%
com = ones(nte,1).*0;
y_tes = temp==com;
y_tes = (y_tes - 0.5).*2;

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
choose = [];
for i=1:100,
    %=if need sample=%
    %just for randomly reducing the number of points
    Np = 1000;%sample points
    poinst = [];
    ind_sample = round(rand(Np,1)*n + 0.5);
    ss = sort(ind_sample);
    ind_comp = [];
    for j=1:n,
        f_ind = find(j==ind_sample);
        if isempty(f_ind),
            ind_comp = [ind_comp;j];
        end
    end
    X_tr = X_tra(ind_sample', :);
    y_tr = y_tra(ind_sample', :);
    X_te = X_tra(ind_comp', :);
    y_te = y_tra(ind_comp', :);
    %================&
    E_all = [];
    for g =[1 10 100 1000 10000],
        opt = sprintf('-s 0 -c 0.1 -t 2 -g %d', g);
        model = svmtrain(y_tr, X_tr,opt);
        [predict_label, accuracy, dec_values] = svmpredict(y_tr, X_tr, model);
        [predict_label_te, accuracy_te, dec_values_te] = svmpredict(y_te, X_te, model);

        Ein = sum(abs(y_tr - predict_label)/2)/n;
        E_all = [E_all;g 100-accuracy_te(1)];
    end
    sr = sortrows(E_all,2);
    choose = [choose; sr(1,1)];
end
