function [eMBY, eMBCr, eMBCb, mV] = motEstP(frameY, frameCr, frameCb, mBIndex, refFrameY, refFrameCr, refFrameCb)
%MOTESTP estimates the move for P-frames
% 2-D.6.2 Motion Estimation and Compensation in the documentation (p.80)
% eMBY: 16x16 macroblock of estimation error -- luminance
% eMBCr, eMBCb: 8x8 macroblock of estimation error -- chroma
% mV: Motion vectors for the specific macroblocks. 2x2 array. For P-frames
% the 2nd column in NaN
% frameY, frameCr, frameCb: channels of the current P-frame
% mBIndex: index number of the macroblock
% refFrameY, refFrameCr, refFrameCb: channels for reference frames

 