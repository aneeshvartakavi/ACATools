MatlabUtils
===========

A collection of useful functions for Audio Content Analysis in Matlab

===========

AudioReadConvert - Reads audio file and converts to a target sampling rate, also converting from stereo to mono if specified.

CustomSTFT - Computes the STFT, with a custom window. Discards symmetry. Use half sine window and preserve the phase spectrum to be able to invertSTFT after processing.

InverseSTFT - Computes inverse STFT using overlap add.

ConvertSampleRate - Convert to a target sample rate using direct-form polyphase FIR filter

