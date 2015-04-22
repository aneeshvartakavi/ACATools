function [ samples, Fs ] = convertSampleRate( samples, inputFs, outputFs ) %#codegen
%CONVERTSAMPLERATE Converts audio sampling rate
% Aneesh Vartakavi

if(inputFs~=outputFs)
    [L,M] = rat(outputFs/inputFs);
    hm = mfilt.firsrc(L,M);
    samples = filter(hm,samples);
end

Fs = outputFs;

end

