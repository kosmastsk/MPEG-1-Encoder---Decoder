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
for k = 1 : 1% length(images) % Change to 1 if we want to run for one image
    baseFileName = images(k).name;
    fullFileName = fullfile(myFolder, baseFileName);
    fprintf(1, 'Now reading %s\n', fullFileName);
    image = imread(fullFileName);
%     figure;
%     imshow(image);
%     title('Original image');

%     Convert the image to YCrCb
    [frameY, frameCr, frameCb] = ccir2ycrcb(image);
   
%     Inverse function
    frameRGB = ycrcb2ccir(frameY, frameCr, frameCb);

end

%% Motion Estimator
    
% % Read the image in which to apply motion estimation "coastguard003.tiff"
% baseFileName = images(4).name;
% fullFileName = fullfile(myFolder, baseFileName);
% fprintf(1, 'Now reading %s\n', fullFileName);
% image = imread(fullFileName);
% % Convert the image to YCrCb
% [frameY, frameCr, frameCb] = ccir2ycrcb(image);
% 
% % Read the reference image "coastguard001.tiff"
% baseFileName = images(2).name;
% fullFileName = fullfile(myFolder, baseFileName);
% fprintf(1, 'Now reading %s\n', fullFileName);
% refImage = imread(fullFileName);
% % Convert the image to YCrCb
% [refFrameY, refFrameCr, refFrameCb] = ccir2ycrcb(refImage);
% 
% % frameY now is 360 pixels wide, but we need 352 to apply a 16x16
% % macroblock size, so we need to delete 4 pixels in each side right and left. The same for the chroma
% % frames, 2 pixels in each side
% % frameY(:, 1:4) = 0;
% % frameY(:, 357:360) = 0;
% frameY = frameY(:, 5:356);
% 
% % frameCr(:, 1:2) = 0;
% % frameCr(:, 179:180) = 0;
% frameCr = frameCr(:, 3:178);
% 
% % frameCb(:, 1:2) = 0;
% % frameCb(:, 179:180) = 0;
% frameCb = frameCb(:, 3:178);
%   
% % The number of 16x16 macroblocks that can fit our image
% max_mBIndex = floor(size(frameY, 1) / 16) * floor(size(frameY, 2) / 16);
% 
% for mBIndex = 0 : max_mBIndex - 1 % minus 1 since we start counting from zero
%     % motion estimation
%     [eMBY, eMBCr, eMBCb, mV] = motEstP(frameY, frameCr, frameCb, mBIndex, refFrameY, refFrameCr, refFrameCb);
%     
%     % Inverse motion estimation
%     [mBY, mBCr, mBCb] = iMotEstP(eMBY, eMBCr, eMBCb, mBIndex, mV, refFrameY, refFrameCr, refFrameCb);
% end

%%  END 