function [xCord yCord scale ] = InterestPoint_Sampling(map,Interest_Point)
%InterestPoint_Sampling - Simple interest point generator 
%
% Synopsis
%   [xCord yCord scale ] = InterestPoint_Sampling(map,Interest_Point)
%
% Description
%       1. Sample Interest_Point.Max_Points points from set of points, weighted according to their salience
%       2. For each sample, set scale by drawing from uniform distribution ...
%          over Interest_Point.Scale 
%
% Inputs ([]s are optional)
%   (matrix) map              Frame saliency map
%   (struct) Interest_Point   structure holding all settings of the interest operator
%   - (bool)Weighted_Sampling if true, using weighted sampling; otherwise,
%                             uniform sampling
%   - (int ) Max_Points       maximum number of points to sample
%   - (bool)Weighted_Scale    if true, using weighted scale;
%
% Outputs ([]s are optional)
%   (vector) xCord            (1 x Interest_Point.Max_Points) coordinates and scale of IPs   
%   (vector) yCord
%   (vector) scale            (1 x Interest_Point.Max_Points) characteristic scale of points (radius,inpixels)
%
%
% Authors
%   Giuseppe Boccignone <Giuseppe.Boccignone(at)unimi.it>
%
% Changes
%   12/12/2012  First Edition
%
    
%DEBUG switch. Normally set to 0 but if set to >=1 will start plotting
% out results so user can check operation of the fucntion    
DEBUG  = 0;

% Default parameters section
if (nargin<2)
   fprintf(' using defaults...\n');
   Interest_Point.Max_Points = 200;
   Interest_Point.Weighted_Sampling = 1;
   Interest_Point.Weighted_Scale = 1;
end

% Reset variables
x = []; xx = [];
y = []; yy = [];
strength = [];
scale = []; score = [];

% Get map size
[imy,imx]=size(map);

% Find salient points
[yy,xx,strength]=getPoints(map);
%   xx=xx';
%   yy=yy';

[ro,co]=size(strength);
%strength= reshape(strength,1,imy*imx);
%strength=strength';

% Total number of salient points exracted from image
nSalPoints = length(strength);

if (nSalPoints>0) % check that some points were found in the image
    % Obtain sampling density
    % choose between uniform and weighted towards those points with a
    % stronger saliency strength 
    if Interest_Point.Weighted_Sampling
      sample_density = strength / sum(strength);
    else
      sample_density = ones(1,nPoints)/nPoints;
    end
    %Choose how many points to sample
    nPoints_to_Sample = Interest_Point.Max_Points;
    sampledensity=double(sample_density);

    %% draw samples from density
    samples = discrete_sampler(sampledensity,nPoints_to_Sample,1);

    %% Lookup points corresponding to samples 
    x = xx(samples);
    y = yy(samples);

    % now draw scales from uniform
    scale = rand(1,nPoints_to_Sample)*(max(Interest_Point.Scale)-min(Interest_Point.Scale))+min(Interest_Point.Scale);

    % get scores for each point (its saliency strength)
    score = strength(samples);

else
    % No salient points found in image at all
    % Set all output variables for the frame to be empty
    x = [];  y = [];  scale = [];  score = [];
end

xCord = x; yCord = y;


if DEBUG
    % Show image with region marked
    figure(1); clf;
    imagesc(map);
    colormap(gray);
    hold on;
    for b=1:length(scale)
      plot(y(b),x(b),'r.');
      drawcircle(x(b),y(b),scale(b)+1,'g',1);
      hold on;
    end
    title(['Interest regions on image: ',num2str(i)]);
    pause
end
%save(output_file_names{i},'x','y','scale','score');
end


function [yy,xx,strength]=getPoints(map)

meansal= mean(mean(map));
[xx,yy,vals] = find(map>meansal);
ind=find(map>meansal);
strength=map(ind);
end

