function [ y ] = power_welch( x, sampleRate, freqrange )
%POWER_WELCH compute the spectral power of a signal

if nargin < 3
    freqrange = [0, sampleRate/2];
end

y = bandpower(x, sampleRate, freqrange);

end
