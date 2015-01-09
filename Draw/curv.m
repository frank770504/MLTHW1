function [ z ] = curv( x1, x2, w )
%CURV Summary of this function goes here
%   Detailed explanation goes here
    [n m] = size(x1);
    z = w(1).*ones(n,m) + w(2).*x1 + w(3).*x2 + w(4).*(x1.^2) + w(5).*(x2.^2) + w(6).*(x1.*x2);

end

