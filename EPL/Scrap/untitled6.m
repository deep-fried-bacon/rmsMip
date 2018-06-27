% Create a toy dataset to represent yours
N = 100; % number of points
time = sort(rand(N,1)); % assumes time is monotonically increasing
quality = rand(N,1);
% Since you are plotting amt vs quality (y vs x), the following sort of
% represnts amt being a linear function of quality + noise.
amt = quality + .1*randn(N,1); 
data = [time,amt,quality];
% see comments in buildcmap
cmap = buildcmap(data(:,1));
scatter(data(:,3),data(:,2),[],cmap,'filled')
% Uncomment the following lines and run it to confirm that buildcmap is
% creating a colormap based on its vector input.  
% cmap2 = buildcmap(data(:,2));
% scatter(data(:,3),data(:,2),[],cmap2)