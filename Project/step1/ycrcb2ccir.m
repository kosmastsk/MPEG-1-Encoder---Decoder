function [ frameRGB ] = ycrcb2ccir(  frameY, frameCr, frameCb )
%YCRCB2CCIR Reconstructs the input in RGB CCIR601 with resolution 720x576
%   2-D.8.2 in MPEG video documentation (p. 109)

disp('Hello from ycrcb2ccir function\n');

%% Initialization
% Input size:
% frameY: 360x288
%frameCr, frameCb: 180x144
% output must be of size: 720x576x3

R = double(zeros(576, 720));
G = double(zeros(576, 720));
B = double(zeros(576, 720));
frameRGB = double(zeros(576, 720, 3));

frameY = double(frameY);
frameCr = double(frameCr);
frameCb = double(frameCb);

lum_upsampling_weights = [-12, 0, 140, 256, 140, 0, -12];
lum_upsampling_weights = lum_upsampling_weights / 256;
 
chr_upsampling_weights = [1, 3, 3, 1];
chr_upsampling_weights = chr_upsampling_weights / 4;

%% Vertical Upsampling Filter for chrominance SIF

frameCr = upsample(frameCr, 2);
frameCb = upsample(frameCb, 2);

frameCr = filter(chr_upsampling_weights, 1, frameCr); % apply the filter vertically in every column
frameCb = filter(chr_upsampling_weights, 1, frameCb);

%% Horizontal Upsampling Filter

frameY = upsample(frameY', 2); % transpose the matrix to use the same function but upsample to the other direction
frameCr = upsample(frameCr', 2);
frameCb = upsample(frameCb', 2);

% frameY = upsamplematrix(frameY, 2, 2);
% frameCr = upsamplematrix(frameCr, 2, 2);
% frameCb = upsamplematrix(frameCb, 2, 2);
% 
frameY = filter(lum_upsampling_weights, 1, frameY); % apply the filter vertically in every row, since we have transposed it
frameCr = filter(chr_upsampling_weights, 1, frameCr); 
frameCb = filter(chr_upsampling_weights, 1, frameCb);

%% Vertical Upsampling Filter

frameY = upsample(frameY', 2); % transpose the matrix again to make it the same as before
frameCr = upsample(frameCr', 2);
frameCb = upsample(frameCb', 2);

frameY = filter(lum_upsampling_weights, 1, frameY); % apply the filter vertically in every column
frameCr = filter(chr_upsampling_weights, 1, frameCr); 
frameCb = filter(chr_upsampling_weights, 1, frameCb);

% We not have the dimension we need for YCrCb

%% Convert the YCrCb to RGB

for h = 1 : size(frameY, 1) % height
    for w = 1 : size(frameY, 2) % width
        R(h, w) = (255/219) * (frameY(h, w) - 16) + (255/112) * 0.701 * (frameCr(h, ceil(w/2)) - 128);
        G(h, w) = (255/219) * (frameY(h, w) - 16) - (255/112) * 0.886 * (0.114/0.587) * (frameCb(h, ceil(w/2)) - 128) - (255/112) * 0.701 * (0.299/0.587) * (frameCr(h, ceil(w/2)) - 128);
        B(h, w) = (255/219) * (frameY(h, w) - 16) + (255/112) * 0.886 * (frameCb(h, ceil(w/2)) - 128);
    end
end

R = R * 255;
G = G * 255;
B = B * 255;

frameRGB(:,:,1) = R;
frameRGB(:,:,2) = G;
frameRGB(:,:,3) = B;

%% Testing and ploting - Hope it works

imshow(R);
figure;
imshow(G);
figure;
imshow(B);

figure;
imshow(frameRGB)
% 
% 
% whos
