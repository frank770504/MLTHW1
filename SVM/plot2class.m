function [ output_args ] = plot2class( X_tr, y_tr)
%PLOT2CLASS Summary of this function goes here
%   Detailed explanation goes here
    Z = X_tr;
    n = size(X_tr,1);
    hh = figure(1);
    hold on
    for i=1:n,
        if y_tr(i)>0,
            plot(Z(i,1), Z(i,2),'+');
        else
            plot(Z(i,1), Z(i,2), 'rx');
        end
    end

end

