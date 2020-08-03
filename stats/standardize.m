function K = standardize(X)
% Standardize data to have zero mean and unit variance.
% 
% Inputs:
%       X           dataset
%       
%
% Outputs:
%       X           standardized data
%
%
% Copyright by Stijn Vanderlooy, MICC, Universiteit Maastricht, 2007


% init variables
[N, d] = size(X);

M = sum(X) / N;
M2 = sum(X.^2) / N;
SD = sqrt(M2 - M.^2);


% compute the standardization
K = (X - repmat(M, N, 1)) ./ repmat(SD, N, 1);