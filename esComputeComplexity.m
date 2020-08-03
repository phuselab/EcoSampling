function [Disorder Order Compl] = esComputeComplexity(cType, histmat, N, Nbins)
%esComputeComplexity - Computes spatial configuration complexity $$ C(t)$$ 
%                      of Interest points
%
% Synopsis
%   [Disorder Order Compl] = esComputeComplexity(cType, histmat, N, Nbins)
%
% Description
%   The function is a simple wrapper for complexity computation. Executes some kind
%   of complexity algorithm which is defined from the parameter
%   cType by calling the appropriate function. 
%
% Inputs ([]s are optional)
%   (string) cType         the chosen method
%   (matrix) histmat       the 2D spatial histogram of IPs
%   (real) N               number of points
%   (real) Nbins           number of bins
%
% Outputs ([]s are optional)
%   (real) Disorder        disorder parameter
%   (real) Order           order parameter
%   (real) Compl           complexity parameter
%
% Examples
%   [Disorder Order Compl] = esComputeComplexity('SDL', histmat, N, Nbins);
%
% References
%  J. Shiner, M. Davison, and P. Landsberg, ?Simple measure for complexity,? 
%  Physical review E, vol. 59, no. 2, pp. 1459?1464, 1999.
% 
%  R. Lopez-Ruiz, H. Mancini, and X. Calbet, ?A statistical measure of complexity* 1,? 
%  Physics Letters A, vol. 209, no. 5-6, pp. 321?326, 1995.
% 
%  D. Feldman and J. Crutchfield, ?Measures of statistical complexity: Why?? 
%  Physics Letters A, vol. 238, no. 4-5, pp.244?252, 1998
%
% Authors
%   Giuseppe Boccignone <Giuseppe.Boccignone(at)unimi.it>
%
% Changes
%   12/12/2012  First Edition
%

% H is Shannon entropy (which is an equivalent of Boltzman-Gibbs's entropy)
phistmat= histmat/N + eps;
H= - sum(sum(phistmat.*log(phistmat)));

if strcmp(cType,'SDL')
    % Shiner-Davison-Landsberg (SDL) complexity  
    Hsup     = log(Nbins);
    Disorder = H / Hsup; %disorder parameter    
    Order    = 1-Disorder;       
elseif strcmp(cType,'LMC')
    % Lòpez-Ruiz, Mancini, and Calbet complexity
    % D is called disequilibrium. This quantity is a measure of the 
    % divergence of the given probability distribution from the uniform one.
    D        = (phistmat - 1/Nbins).^2;
    Disorder = H;
    Order    = sum(sum(D));
elseif strcmp(cType,'FC')
    % Feldman and Crutchfield's amendment replaces Order with the
    % Kullback-Leibler divergence. 
    % For the purpose of serving as a component of complexity, one of the 
    % compared distributions is taken to be uniform
    Disorder = H;
    Order    = sum(sum(phistmat.*log(Nbins*phistmat)));   
else
    fprintf('\n UNKNOWN TYPE OF COMPLEXITY');
end

Compl = Disorder * Order;

end