%% Testing the filter function.

%% interpolation to be applied after upsampling

% % % line = [12, 32, 23, 9, 12, 49, 95, 95];
% % % line = upsample(line, 2, 1);
% % % weights = [-12, 0, 140, 256, 140, 0, -12]; % /256
% % % 
% % % line = lumInterpFilter(line, weights, 256);
% % % line = round(line)
% % % true = [10, 12, 22, 32, 29, 23, 15, 9, 8, 12, 28, 49, 74, 95, 97, 95];


%% Filtering and Subsampling

% % % line = [10, 12, 20, 30, 35, 15, 19, 11, 11, 19, 26, 45, 80, 90, 92, 90];
% % % true = [ 12, 32, 23, 9, 12, 49, 95, 95];
% % % weights = [-29, 0, 88, 138, 88, 0, -29]; % /256

% % % line = FIRsubsampling(line, weights, div)
% % % line = downsample(line, 2, 1)
% % % true