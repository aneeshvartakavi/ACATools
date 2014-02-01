function [ audioData ] = inverseSTFT( magSpec,phaseSpec, blockSize, hopSize)
%INVERSESTFT Computes inverse STFT using overlap add
%
% Expects the dimensions of magSpec and phaseSpec to be equal, with number
% of rows equal to (blockSize/2 + 1)
% 
% Inputs - 
% magSpec (double) - Magnitude spectrum
% 
% phaseSpec (double) - Phase spectrum
%
% blockSize (double) - Block size (should be the same as used for STFT)
%
% hopSize (double) - Hop size (should be the same as used for STFT)
%
% Outputs - 
% audioData - Reconstructed audio data
%
% Author - Aneesh Vartakavi

assert(isequal(size(magSpec),size(phaseSpec)),'Size of magSpec not equal to size of phaseSpec');

assert(blockSize == 2*(size(magSpec,1)-1),'Number of rows in input spectrum incorrect, see help for details');

magSpec(blockSize/2+2:blockSize,:) = flipud(magSpec(2:blockSize/2,:));
phaseSpec(blockSize/2+2:blockSize,:) = -1*flipud(phaseSpec(2:blockSize/2,:));
 
spec = magSpec.*exp(1j*phaseSpec);
spec = real(ifft(spec));

frequency = 1/(2*(blockSize-1));
t1 = 0:blockSize-1;
sineWindow = sin(2*pi*frequency*t1);
W = diag(sparse(sineWindow));
spec = W * spec;

L = (size(spec,2)-1)*(hopSize) +blockSize;

audioData = zeros(L,1);

audioData(1:blockSize) = spec(:,1);

for i=1:size(spec,2)-1
    audioData((hopSize*i)+1:(hopSize*i)+blockSize) = audioData((hopSize*i)+1:(hopSize*i)+blockSize)...
                                        + spec(:,i+1);
end

end

