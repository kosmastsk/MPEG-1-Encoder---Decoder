%% Demo 1
% This script demostrates the functionality for the first part of the
% project - MPEG Library

%% Initialize the demo
clear all;
close all;
clc;

%% Get a list of all files in the folder with the desired file name pattern.

% Specify the folder where the files live.
% images available in the ../../coastguard-tiffs directory
myFolder = '../../coastguard-tiffs';
if ~isdir(myFolder)
  errorMessage = sprintf('Error: The following folder does not exist:\n%s', myFolder);
  uiwait(warndlg(errorMessage));
  return;
end

filePattern = fullfile(myFolder, '*.tiff');
images = dir(filePattern);

%% Preprocessing
% Read every image in the folder specified
% for k = 1 : length(images) % Change to 1 if we want to run for one image
%     baseFileName = images(k).name;
%     fullFileName = fullfile(myFolder, baseFileName);
%     fprintf(1, 'Now reading %s\n', fullFileName);
%     image = imread(fullFileName);
%     figure;
%     imshow(image);
%     title('Original image');
% 
%     % Convert the image to YCrCb
%     [frameY, frameCr, frameCb] = ccir2ycrcb(image);
%    
%     % Inverse function
%     frameRGB = ycrcb2ccir(frameY, frameCr, frameCb);
%     imshow(frameRGB);
% end

%% Motion Estimator
% Read every image in the folder specified
for k = 1 : 1 %length(images)
    baseFileName = images(k).name;
    fullFileName = fullfile(myFolder, baseFileName);
    fprintf(1, 'Now reading %s\n', fullFileName);
    image = imread(fullFileName);
    
    
end

%%  END 