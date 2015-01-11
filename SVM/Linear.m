clc 
clear
load test.mat;

X_tr = test(:,2:3);
temp = test(:,1);
n = size(X_tr,1);

%=take for =%
com = ones(n,1).*0;
y_tr = temp==com;
y_tr = (y_tr - 0.5).*2;

c = 0.01;
opt = sprintf('-s 0 -c %f -t 0', c);
model = svmtrain(y_tr, X_tr,opt);
w = model.SVs' * model.sv_coef;

fprintf('\nThe ||w|| = %f\n', sqrt(w'*w));