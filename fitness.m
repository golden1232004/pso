function [ fit_value ] = fitness(x)
%
    fit_value = 100 * ( x(2) - x(1)^2)^2 + (1- x(1))^2;
    
 end

