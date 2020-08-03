function fMap = esComputeFeatures(fovSeq, fType, fParam)
%esComputeFeatures - Computes features using a foveated sequence of frames
%
% Synopsis
%   fMap = esComputeFeatures(fovSeq, fType, fParam)
%
% Description
%   The function is a simple wrapper for feature computation. Executes some kind
%   of feature extraction algorithm which is defined from the parameter
%   fType by calling the appropriate function. 
%   Here for simplicity only the Self Resemblance method has been considered. 
%   If other methods need to be experimented, then you should extend the if...elseif...end
%   control structure
%
% Inputs ([]s are optional)
%   (matrix) fovSeq       the foveated sequence of frames
%   (string) fType        the chosen method
%
% Outputs ([]s are optional)
%   (matrix) fMap         the feature map
%   ....
%
% Examples
%   fMap = esComputeFeatures(fovSeq, fType, fParam);
%
% See also
%   ThreeDLARK
%
% Requirements
%   ThreeDLARK (./saltools/SelfResemblance2/)

% References
%   H. Seo and P. Milanfar, Static and space-time visual saliency detection by self-resemblance, 
%                           Journal of Vision, vol. 9, no. 12, pp. 1?27, 2009
%
% Authors
%   Giuseppe Boccignone <Giuseppe.Boccignone(at)unimi.it>
%
% License
%   The program is free for non-commercial academic use. Please 
%   contact the authors if you are interested in using the software
%   for commercial purposes. The software must not modified or
%   re-distributed without prior permission of the authors.
%
% Changes
%   12/12/2012  First Edition
%

if strcmp(fType,'3DLARK_SELFRESEMBLANCE')
   fMap = ThreeDLARK(fovSeq,fParam);    
else
    fprintf('\n UNKNOWN TYPE OF EXPERIMENT.......\n')
end;
end