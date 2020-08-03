function nu = esHyperParamUpdate(nu, Disorder,Order,Compl, C_EPS)
%esHyperParamUpdate - Dirichlet hyper-parameter update  
%                     
%
% Synopsis
%          nu = esHyperParamUpdate(nu, Disorder,Order,Compl,  C_EPS)
%
% Description
% Computes the new Dirichlet hyper-parameter $$\nu_{k}(t)$$
% Given the complexity $\mathcal{C}(t)$,  we partition the complexity range in order to define  
% $K$ possible complexity events $\{E_{\mathcal{C}(t)}=k\}_{k=1}^{K}$. 
% This way the hyper-parameter update    can be rewritten as the recursion
% 
%    $$\nu_{k}(t)= \nu_k(t-1) +\left[ E_{\mathcal{C}(t)} = k \right], k=1,\cdots,K$$.

%
%
% Inputs ([]s are optional)
%   (vector) nu           old Dirichlet Hyperparameters
%   (real) Disorder       disorder parameter
%   (real) Order          order parameter
%   (real) Compl          complexity parameter $\mathcal{C}(t)$
%   (real) C_EPS          the chaos edge
%
% Outputs ([]s are optional)
%   
%   (vector) nu           new Dirichlet Hyperparameters
%
% Example:
%   
%   nu = esHyperParamUpdate(nu_old, Disorder,Order,Compl, COMPL_EDGE)
%
%

% References
%   [1] G. Boccignone and M. Ferraro, The active sampling of gaze-shifts, in Image Analysis and Processing ICIAP 2011, 
%                                     ser. Lecture Notes in Computer Science, G. Maino and G. Foresti, Eds.	
%                                     Springer Berlin / Heidelberg, 2011, vol. 6978, pp. 187?196
%
%   [2] G. Boccignone and M. Ferraro, Ecological Sampling of Gaze Shifts,
%                                     IEEE Trans. SMC-B, 
%                                     
%   
%
% Author
%   Giuseppe Boccignone <Giuseppe.Boccignone(at)unimi.it>
%
%
% Changes
%   12/12/2012  First Edition
%
%
VERBOSE=false;


thresh = (0.25 -  C_EPS); %if beyond threshold we are in the complex domain

reset_step=25; %parameter to control hysteresis
nu(1)= mod(nu(1),reset_step);
if(nu(1)==0) nu(1)=1;end
nu(2)= mod(nu(2),reset_step);
if(nu(2)==0) nu(2)=1;end
nu(3)= mod(nu(3),reset_step);
if(nu(3)==0) nu(3)=1;end

if Compl <= thresh
    if (Disorder < Order)
%         order event 
        nu(1)= nu(1) + 1; 
    else 
%         disorder event    
        nu(3)= nu(3) + 1;           
    end
else
    % at the edge of chaos        
    nu(2)= nu(2) + 1 ;       

    if VERBOSE    
     disp('MAX COMPLEXITY!!!!!!')
    end                  
end
    