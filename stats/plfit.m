function [a, k, y2] = plfit(x, y, x0);

% function [a, k, y2] = plfit(x, y, x0);
%
% Find power-law fit coefficients for the given series
% such that y = a * x^k.
%
% inputs:
% x - independent variable
% y - dependent variable
% x0 - values at which to compute dependent variable for fit
%
% outputs:
% a - power law constant
% k - power law exponent
% y2 - value of dependent variable at x0 values in fit
%
% 2006 aloke mukherjee

xx = log(x);  yy = log(y);  exx = mean(xx);  eyy = mean(yy);
k = cov(xx,yy)/var(xx);
k = k(1,2);
a = exp(eyy - k*exx);
y2 = a * (x0 .^ k);