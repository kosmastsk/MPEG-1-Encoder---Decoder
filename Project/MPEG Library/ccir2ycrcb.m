function [ frameY, frameCr, frameCb ] = ccir2ycrcb( frameRGB )
%CCIR2YCRCB Create a sequence of images 352x288 in YCrCb 4:2:0
%   2-D.3.1 in MPEG video documentation

disp('Hello from ccir2ycrrb function\n');
%% Initialize
% frameRGB is 576x720x3 struct

R = frameRGB(:,:,1) / 255; % Red channel
G = frameRGB(:,:,2) / 255; % Green channel
B = frameRGB(:,:,3) / 255; % Blue channel

% initialize the output arrays in uint8 format
frameY = uint8(zeros(size(frameRGB(:,:,1))));
frameCr = uint8(zeros(size(frameY(:,:),1), size(frameY(:,:),2) / 2)); %the Cr Cb frames have the half number of pixels per row
frameCb = uint8(zeros(size(frameY(:,:),1), size(frameY(:,:),2) / 2));


%% Convert the values from RGB to YCrCb pixels
% http://www.bilsen.com/aic/colorconversion.shtml
% for h = 1 : size(frameRGB, 1) % height
%     for w = 1 : size(frameRGB, 2) % width
%         frameY(h, w) = 0.2989 * R(h,w) + 0.5866 * G(h,w) + 0.1145 * B(h,w);
%         if (mod(w, 2) ~= 0)
%             frameCr(h, ceil(w/2)) = 0.5 * R(h,w) - 0.4184 * G(h,w) - 0.0816 * B(h,w);
%             frameCb(h, ceil(w/2)) = - 0.1687 * R(h,w) - 0.3313 * G(h,w) + 0.5 * B(h,w);
%         end
%     end
% end
%% Wikipedia numbers
for h = 1 : size(frameRGB, 1) % height
    for w = 1 : size(frameRGB, 2) % width
        frameY(h, w) = 16 + 65.481 * R(h,w) + 128.553 * G(h,w) + 24.966 * B(h,w);
        if (mod(w, 2) ~= 0)
            frameCb(h, ceil(w/2)) = 128 - 37.797 * R(h,w) - 74.203 * G(h,w) + 112.0 * B(h,w);
            frameCr(h, ceil(w/2)) = 128 + 112.0 * R(h,w) - 93.786 * G(h,w) - 18.214 * B(h,w);
        end
    end
end

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
n_h = 1; % new height
% Reject all the even rows
% for h = 1 : 2: size(frameRGB, 1)
%     frameY(n_h, :) = frameY(h, :);
%     frameCr(n_h, :) = frameCr(h, :);
%     frameCb(n_h, :) = frameCb(h, :);
%     n_h = n_h + 1;
% end
% % Set to 0 the rest of the rows, so that we can remove them
% for n_h = n_h : size(frameRGB, 1)
%     frameY(n_h, :) = 0;
%     frameCr(n_h, :) = 0;
%     frameCb(n_h, :) = 0;
% end
% frameY = frameY(any(frameY, 2),:);
% frameCb = frameCb(any(frameCb, 2),:);
% frameCr = frameCr(any(frameCr, 2),:);

% There was such an easier way :/ 
frameY = downsample(frameY, 2);
frameCr = downsample(frameCr, 2);
frameCb = downsample(frameCb, 2);

%% Luminance Subsampling Filter Tap Weights
lum_tap_weights = [-29, 0, 88, 138, 88, 0, -29];
lum_tap_weights = lum_tap_weights / 255;

%% Chrominance Subsampling Filter Tap Weights
chr_tap_weights = [1, 3, 3, 1];
chr_tap_weights = chr_tap_weights / 255;

%% Horizontal Filter and subsample
frameY = imfilter(frameY, lum_tap_weights);
frameCr = imfilter(frameCr, chr_tap_weights);
frameCb = imfilter(frameCb, chr_tap_weights);
frameY = frameY(: , 1:2:end);
frameCr = frameCr(: , 1:2:end);
frameCb = frameCb(: , 1:2:end);

%% Vertical Filter and subsample for frames Cr and Cb
frameCr = imfilter(frameCr, chr_tap_weights);
frameCb = imfilter(frameCb, chr_tap_weights);
frameCr = downsample(frameCr, 2);
frameCb = downsample(frameCb, 2);

%% Hopefully SIF resolution is done

%% Plots and testing
figure;
imshow(frameY);
title('frame Y');

figure;
imshow(frameCr);
title('frame Cr');

figure;
imshow(frameCb);
title('frame Cb');

% figure;
% imshow(cat(3, frameY, frameCr, frameCb));
% title('Y Cr Cb image - my implementation')

% ycbcr = rgb2ycbcr(frameRGB);
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

