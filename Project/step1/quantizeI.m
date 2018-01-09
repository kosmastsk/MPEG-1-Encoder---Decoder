function qBlock = quantizeI(dctBlock, qTable, qScale)
% QUANTIZEI is performing the quantization of the I-frames.
% Procedure described at 2-D.6.3.4 in the MPEG-1 documentation (p. 89)
% qBlock contains the quantized coefficients of the DCT coefficients of the
% block. 
% dctBlock coontains the DCT coefficients
% qTable is the quantizer table  (2-D.6.3.4)
% qScale is the quantizer scale  (2-D.6.4.5)
% The result is a symbol and not a number.

