%% Demo 1
% This script demostrates the functionality for the first part of the
% project - MPEG Library

%% Initialize the demo
clear all;
close all;
clc;

%% Read images in RGB 720x576 and convert it to 352X288 YCrCb 4:2:0 images
% 2-D.3.1 in the MPEG video documentation
% images available in the ../../coastguard-tiffs directory

% Specify the folder where the files live.
myFolder = '../../coastguard-tiffs';
if ~isdir(myFolder)
  errorMessage = sprintf('Error: The following folder does not exist:\n%s', myFolder);
  uiwait(warndlg(errorMessage));
  return;
end

% Get a list of all files in the folder with the desired file name pattern.
filePattern = fullfile(myFolder, '*.tiff');
images = dir(filePattern);

% Read every image in the folder specified
for k = 1 : 1 %length(images)
  baseFileName = images(k).name;
  fullFileName = fullfile(myFolder, baseFileName);
  fprintf(1, 'Now reading %s\n', fullFileName);
  image = imread(fullFileName);
  figure;
  imshow(image);
  title('Original image');
  [frameY, frameCr, frameCb] = ccir2ycrcb(image);
  % 
  % Inverse function
%   frameRGB = ycrcb2ccir(frameY, frameCr, frameCb);
%   imshow(frameRGB);
end


%%   