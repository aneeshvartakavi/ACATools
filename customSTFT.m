function [magSpec,F,T, phaseSpec] = customSTFT( samples,Fs,blockSize,hopSize,windowType)
%CUSTOMSTFT Computes the STFT, with a custom window. Discards symmetry.
%  
% INPUTS
%
% samples (double) - Audio Data
%
% Fs (double) - Sample rate
%
% blockSize (double) - Desired block length
% (Default - 1024)
%
% hopSize (double) - Desired hop length
% (Default - blockSize/2, or 50% overlap)
%
% window (string) - Type of window to use.
% (Default - Half sine window, to allow for inverse STFT)
% Options : 'hann' - Hanning
%            'sine' - Half sine window
%
% OUTPUTS
% magSpec - The computed magnitude STFT, matrix of dimension [blockSize/2 +1, number of blocks]
%
% F - Frequency index, in Hertz
%
% T - Time indices, in seconds
%
% phaseSpec - The computed phase STFT, same dimensions as magSpec.
%
% Author - Aneesh Vartakavi

if(nargin < 3)
    blockSize = 1024;
end

if(nargin<4)
    hopSize = blockSize/2;
end

if(nargin<5)
    windowType = 'sine';
end

numZerosToPad = hopSize - rem(length(samples),blockSize-hopSize);
samples = padarray(samples,numZerosToPad,0,'post');

blocks = buffer(samples,blockSize,blockSize - hopSize,'nodelay');

% Time and Frequency indices
F = linspace(0,Fs/2,blockSize/2);
T = ((0:size(blocks,2)-1) * hopSize + (blockSize/2))/Fs;

if(strcmp(windowType,'sine'))
    
    frequency = 1/(2*(blockSize-1));
    t1 = 0:blockSize-1;
    sineWindow = sin(2*pi*frequency*t1);
    W = diag(sparse(sineWindow));

elseif(strcmp(windowType,'hann'))
    
    W = diag(sparse(hann(blockSize)));
end

% Applying window
blocks = W*blocks;

spec = fft(blocks,blockSize);
spec((blockSize/2)+2:end,:) = [];
magSpec = abs(spec);
phaseSpec = angle(spec);

end


