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
% % Read every image in the folder specified
% for k = 1 : 1%length(images) % Change to 1 if we want to run for one image
%     baseFileName = images(k).name;
%     fullFileName = fullfile(myFolder, baseFileName);
%     fprintf(1, 'Now reading %s\n', fullFileName);
%     image = imread(fullFileName);
%     figure;
%     imshow(image);
%     title('Original image');
% 
% %     Convert the image to YCrCb
%     [frameY, frameCr, frameCb] = ccir2ycrcb(image);
%    
% %     Inverse function
%     frameRGB = ycrcb2ccir(frameY, frameCr, frameCb);
% end

%% Motion Estimator for P frames
%     
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
%     
%     % motion estimation P frames
%     [eMBY, eMBCr, eMBCb, mV] = motEstP(frameY, frameCr, frameCb, mBIndex, refFrameY, refFrameCr, refFrameCb);   
%     
%     % Inverse motion estimation P frames
%     [mBY, mBCr, mBCb] = iMotEstP(eMBY, eMBCr, eMBCb, mBIndex, mV, refFrameY, refFrameCr, refFrameCb);
% end

%% Motion Estimator for B frames
    
% % Read the image in which to apply motion estimation "coastguard003.tiff"
% baseFileName = images(4).name;
% fullFileName = fullfile(myFolder, baseFileName);
% fprintf(1, 'Now reading %s\n', fullFileName);
% image = imread(fullFileName);
% % Convert the image to YCrCb
% [frameY, frameCr, frameCb] = ccir2ycrcb(image);
% 
% % Read the forward frame"coastguard001.tiff" % picture in the past
% baseFileName = images(2).name;
% fullFileName = fullfile(myFolder, baseFileName);
% fprintf(1, 'Now reading %s\n', fullFileName);
% forwFrame = imread(fullFileName);
% % Convert the image to YCrCb
% [forwFrameY, forwFrameCr, forwFrameCb] = ccir2ycrcb(forwFrame);
% 
% % Read the backward frame "coastguard004.tiff" % picture in the future
% baseFileName = images(5).name;
% fullFileName = fullfile(myFolder, baseFileName);
% fprintf(1, 'Now reading %s\n', fullFileName);
% backwFrame = imread(fullFileName);
% % Convert the image to YCrCb
% [backwFrameY, backwFrameCr, backwFrameCb] = ccir2ycrcb(backwFrame);
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
% for mBIndex = 10 :10% max_mBIndex - 1 % minus 1 since we start counting from zero
%     % motion estimation B frames
%     [eMBY, eMBCr, eMBCb, mV, MBY] = motEstB(frameY, frameCr, frameCb, mBIndex, backwFrameY, backwFrameCr, backwFrameCb, forwFrameY, forwFrameCr, forwFrameCb);
% 
%     % Inverse motion estimation B frames
%     [mBY, mBCr, mBCb] = iMotEstB(eMBY, eMBCr, eMBCb, mBIndex, mV, backwFrameY, backwFrameCr, backwFrameCb, forwFrameY, forwFrameCr, forwFrameCb);
%     isequal(MBY, mBY)
%     MBY;
%     mBY;
% end

%% DCT Transformation

% The functions are ready, but where to apply them? Directly to the image
% frames or to the errors after motion estimation, or what?
% Fuck it. We 'll see.

% Read every image in the folder specified
% for k = 1 : 1%length(images) % Change to 1 if we want to run for one image
%     baseFileName = images(k).name;
%     fullFileName = fullfile(myFolder, baseFileName);
%     fprintf(1, 'Now reading %s\n', fullFileName);
%     image = imread(fullFileName);
% 
% %     Convert the image to YCrCb
%     [frameY, frameCr, frameCb] = ccir2ycrcb(image);
% 
%     % DCT transform
%     % Apply the transformation in blocks of size 8x8
%     for i = 1 : 8 : size(frameY, 2)
%         for j = 1 : 8 : size(frameY, 1)
%             frameY(j : j + 7, i : i + 7) = blockDCT(frameY(j : j + 7, i : i + 7));
%         end
%     end
%     
%     for i = 1 : 8 : size(frameCr, 2)
%         for j = 1 : 8 : size(frameCr, 1)
%             frameCb(j : j + 7, i : i + 7) = blockDCT(frameCb(j : j + 7, i : i + 7));
%             frameCr(j : j + 7, i : i + 7) = blockDCT(frameCr(j : j + 7, i : i + 7));
%         end
%     end
%     
% %   Inverse function
%      for i = 1 : 8 : size(frameY, 2)
%         for j = 1 : 8 : size(frameY, 1)
%             frameY(j : j + 7, i : i + 7) = iBlockDCT(frameY(j : j + 7, i : i + 7));
%         end
%      end
%     
%      for i = 1 : 8 : size(frameCr, 2)
%         for j = 1 : 8 : size(frameCr, 1)
%             frameCb(j : j + 7, i : i + 7) = blockDCT(frameCb(j : j + 7, i : i + 7));
%             frameCr(j : j + 7, i : i + 7) = blockDCT(frameCr(j : j + 7, i : i + 7));
%         end
%      end
%     
%      % Now frameY, frameCr and frameCb are on their initial state
%     
% end

%% Quantization




%%  END 