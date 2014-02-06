function [ samples, Fs ] = audioReadConvert( fileName, targetFs, stereoToMono,normalize )
%AUDIOREAD Reads audio file and converts sampling rate and stereo to mono
%if specified
% INPUTS - 
% fileName(string) - Path to file.
%
% targetFs (double) - Set target sample rate in Hz
% (default - 16000Hz)
% An input of 0 will not convert sampling rate
%
% stereoToMono(logical) - Set to true to convert to mono 
% (default - true)
%
% normalize (logic) - Set to true if samples should be normalized 
% (default - true)
%
% OUTPUTS - 
%
% samples - Audio data
%
% Fs - Final sample rate
%
% Author - Aneesh Vartakavi

if(nargin<2)
    targetFs = 16000;
end

if(nargin<3)
    stereoToMono = true;
end

if(nargin<4)
    normalize = true;
end

if verLessThan('matlab', '8.1.0')
    [samples, Fs] = audioread(fileName);
else
    [samples, Fs] = wavread(fileName);
end

if(targetFs~=0)
    if(Fs~=targetFs)
        [L,M] = rat(targetFs/Fs);
        hm = mfilt.firsrc(L,M);
        samples = filter(hm,samples);
        Fs = targetFs;
    end
end
if(stereoToMono)
    samples = mean(samples,2);
end

if(normalize)
    samples = samples/max(abs(samples));
end


end

