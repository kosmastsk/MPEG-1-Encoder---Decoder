function [ frameRGB ] = ycrcb2ccir(  frameY, frameCr, frameCb )
%YCRCB2CCIR Reconstructs the input in RGB CCIR601 with resolution 720x576
%   2-D.8.2 in MPEG video documentation

disp('Hello from ycrcb2ccir function\n');

%% Initialization
% Input size:
% frameY: 360x288
%frameCr, frameCb: 180x144
% output must be of size: 720x576x3

R = uint8(zeros(576, 720));
G = uint8(zeros(576, 720));
B = uint8(zeros(576, 720));
frameRGB = uint8(zeros(576, 720, 3));

%frameY = double(frameY);

lum_upsampling_filter = [-12, 0, 140, 256, 140, 0, -12];
chr_upsampling_filter = [1, 3, 3, 1];

%% Vertical Upsampling Filter for chrominance SIF
frameCr = upsample(frameCr, 2);
frameCb = upsample(frameCb, 2);
% 
% frameCr = imfilter(frameCr, chr_upsampling_filter);
% frameCb = imfilter(frameCb, chr_upsampling_filter);

%% Horizontal Upsampling Filter
% frameY = upsamplematrix(frameY, 2, 2);
% frameCr = upsamplematrix(frameCr, 2, 2);
% frameCb = upsamplematrix(frameCb, 2, 2);

% frameY = imfilter(frameY, lum_upsampling_filter);
% frameCr = imfilter(frameCr, chr_upsampling_filter);
% frameCb = imfilter(frameCb, chr_upsampling_filter);

%% Vertical Upsampling Filter
frameY = upsample(frameY, 2);
frameCr = upsample(frameCr, 2);
frameCb = upsample(frameCb, 2);

frameY = imfilter(frameY, lum_upsampling_filter);
frameCr = imfilter(frameCr, chr_upsampling_filter);
frameCb = imfilter(frameCb, chr_upsampling_filter);

%% Convert the YCrCb to RGB

for h = 1 : size(frameY, 1) % height
    for w = 1 : size(frameY, 2) % width
        R(h, w) = frameY(h, w) + 1.4022 * frameCr(h, ceil(w/2));
        G(h, w) = frameY(h, w) -0.3456 * frameCb(h, ceil(w/2)) - 0.7145 * frameCr(h, ceil(w/2));
        B(h, w) = frameY(h, w) + 1.7710 * frameCb(h, ceil(w/2));
    end
end
whos


R = R * 255;
G = G * 255;
B = B * 255;

imshow(R);
figure;
imshow(G);
figure;
imshow(B);

% frameRGB(:,:,1) = R;
% frameRGB(:,:,2) = G;
% frameRGB(:,:,3) = B;


%% Testing and ploting - Hope it works

whos
