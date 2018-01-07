function [frameY, frameCr, frameCb] = ccir2ycrcb(frameRGB)
%CCIR2YCRCB Create a sequence of images 352x288 in YCrCb 4:2:0
%   2-D.3.1 in MPEG video documentation (p. 57)

disp('Hello from ccir2ycrrb function\n');
%% Initialize
% frameRGB is 576x720x3 struct

frameRGB = im2double(frameRGB); % Convert the image to double precision

R = frameRGB(:,:,1) ; % Red channel
G = frameRGB(:,:,2) ; % Green channel
B = frameRGB(:,:,3) ; % Blue channel

% initialize the output arrays in uint8 format
frameY = uint8(zeros(size(frameRGB(:,:,1))));
frameCr = uint8(zeros(size(frameY(:,:),1), size(frameY(:,:),2) / 2)); %the Cr Cb frames have the half number of pixels per row
frameCb = uint8(zeros(size(frameY(:,:),1), size(frameY(:,:),2) / 2));


%% Convert the values from RGB to YCrCb pixels

frameY = uint8(floor(77*R + 150*G + 29*B));
frameCb = uint8(floor(((-44*R(:, 1:2:end) - 87*G(:, 1:2:end) + 131*B(:, 1:2:end))/256 + 0.5)*256));
frameCr = uint8(floor(((131*R(:, 1:2:end) - 110*G(:, 1:2:end) - 21*B(:, 1:2:end))/256 + 0.5)*256));

% See the result of the initial convertion
% figure;
% imshow(frameY);
% title('frame Y');
% 
% figure;
% imshow(frameCr);
% title('frame Cr');
% 
% figure;
% imshow(frameCb);
% title('frame Cb');

%% Odd field only

frameY = downsample(frameY, 2);
frameCr = downsample(frameCr, 2);
frameCb = downsample(frameCb, 2);

%% Luminance Subsampling Filter Tap Weights

lum_tap_weights = [-29, 0, 88, 138, 88, 0, -29];
lum_tap_weights = (lum_tap_weights / 256);

%% Chrominance Subsampling Filter Tap Weights

chr_tap_weights = [1, 3, 3, 1];
chr_tap_weights = (chr_tap_weights / 8);

%% Horizontal Filter and subsample

frameY = imfilter(frameY', lum_tap_weights); % transpose to apply the filter horizontally
frameCr = imfilter(frameCr', chr_tap_weights);
frameCb = imfilter(frameCb', chr_tap_weights);

frameY = downsample(frameY, 2);
frameCr = downsample(frameCr, 2);
frameCb = downsample(frameCb, 2);

% frameY = frameY(: , 1:2:end);
% frameCr = frameCr(: , 1:2:end);
% frameCb = frameCb(: , 1:2:end);

%% Vertical Filter and subsample for frames Cr and Cb

frameCr = imfilter(frameCr', chr_tap_weights);
frameCb = imfilter(frameCb', chr_tap_weights);

frameCr = downsample(frameCr, 2); % transpose again to bring it in the initial format
frameCb = downsample(frameCb, 2);
frameY = frameY';

%% Hopefully SIF resolution is done

%% Plots and testing
% figure;
% imshow(frameY);
% title('frame Y');
% 
% figure;
% imshow(frameCr);
% title('frame Cr');
% 
% figure;
% imshow(frameCb);
% title('frame Cb');

% figure;
% imshow(cat(3, frameY, frameCr, frameCb));
% title('Y Cr Cb image - my implementation')

% 
% figure;
% imshow(ycbcr);
% title('rgb2ycbcr MATLAB function result')
% 
% figure;
% imshow(ycbcr(:,:,1));
% title('Y from MATLAB')
% 
% figure;
% imshow(ycbcr(:,:,2));
% title('Cb from MATLAB')
% 
% figure;
% imshow(ycbcr(:,:,3));
% title('Cr from MATLAB')
% whos
end

