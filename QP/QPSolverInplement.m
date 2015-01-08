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

%find the g(x)
%         N
%        ----
% g(x) =  >    alpha_n*y_n*K(x_n,x) + b
%        ----
%        n = 1
%               N
%              ----
%    b = y_s -  >    alpha_n*y_n*K(x_n,x_s)
%              ----
%              n = 1
[v ind] = max(alpha);
y = X(:,3);
b = y(ind);
xs = X(ind,1:2)';
for i=1:N,
    xi = X(i,1:2)';
    b = b - alpha(i)*y(i)*plyKernel(xi,xs);
end
%m = [ 1 2xn1 2xn2 xn1^2 xn2^2 2x1x2]
%      1 x1   x2   x1^2  x2^2  x1x2
M = [];
for i=1:n,
    A = alpha(i)*y(i);
    xn1 = X(i,1);
    xn2 = X(i,2);
    m = [1 2*xn1 2*xn2 xn1^2 xn2^2 2*xn1*xn2];
    M = [M;A.*m];
end
M = sum(M);

syms x1 real 
syms x2 real
M = sym(M, 'd')';
XX = [ 1;x1;x2;x1^2;x2^2;x1*x2 ];
%g(x) = XX'*M + b
g = XX'*M + b;
fprintf('the g(x) is');
pretty(g)