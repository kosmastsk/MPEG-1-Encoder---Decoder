function runSymbols = ivlc(vlcStream)
% IVLC - Inverse Variable Length Coding function receives as an input stream
% of VLC codes and creates the runSymbols that this stream came from.
% The encoding is using the codes included in the tables 2-D.15, 2-D.16 and
% 2-D.17 in the MPEG-1 documentation, which are global variables
% p. 92 in the documentation

% Define the global variables to use them also in this file
global d15a;
global d15b;
global d16a;
global d16b;
global d17a;
global d17b;

L = length(vlcStream);

%% Scan the VLC code and change it to run Symbols
vlcTable(vlcStream)

runSymbols = 0 ;