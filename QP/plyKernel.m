function [ K ] = plyKernel( x1, x2 )
%PLYKERNEL Summary of this function goes here
%   Detailed explanation goes here
    K = (1 + x1'*x2)^2;

end

