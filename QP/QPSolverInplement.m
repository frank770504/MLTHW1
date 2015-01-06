clc
clear all

% using function [x,fval,exitflag,output,lambda] = quadprog(H,f,A,b,Aeq,beq,lb,ub,x0)
%
% f(x) = (1/2) x'Hx + f'x
% Ax <= b
% Aeqx <= beq

% X = [ x1 x2 y;...]
X = [  1  0 -1;
       0  1 -1;
       0 -1 -1;
      -1  0  1;
       0  2  1;
       0 -2  1;
      -2  0  1];
N = size(X,1);

% H(7,7)
H = zeros(N,N);
% qn,m = (yn)(ym)(zn')(zm)
% qn.m = (yn)(ym)K(xn,xm)
for n=1:N,
    for m=1:N,
        xn = X(n,1:2)';
        yn = X(n,3);
        xm = X(m,1:2)';
        ym = X(m,3);
        H(n,m) = yn*ym*plyKernel(xn,xm);
    end
end
% f = -1'
f = ones(1,N).*-1;
% A*x=b
Aeq = X(:,3)';
beq = 0;
% x>0
lb = zeros(N,1);

% no A b ub
alpha = quadprog(H,f,[],[],Aeq,beq,lb,[],[],optimset('Algorithm','interior-point-convex'));

fprintf('max(alpha) is %d-th\n', find(max(alpha)==alpha));
fprintf('min(alpha) is %d-th\n', find(min(alpha)==alpha));
fprintf('sum(alpha) is %f\n', sum(alpha));
  
