function [ filters ] = filters( sampleRate, filterOrder )
%FILTERS create a filter for each frequency band

if nargin < 3
    filterOrder = sampleRate - 1;
end

filters = cell(1, 5);

%%% Delta filter
filters{1} = designfilt('lowpassfir', 'Window', 'hamming', 'FilterOrder', filterOrder, ...
    'SampleRate', sampleRate, 'CutoffFrequency', 4);
%%% Theta filter
filters{2} = designfilt('bandpassfir', 'Window', 'hamming', 'FilterOrder', filterOrder, ...
    'SampleRate', sampleRate, 'CutoffFrequency1', 4,'CutoffFrequency2', 8);
%%% Alpha filter
filters{3} = designfilt('bandpassfir', 'Window', 'hamming', 'FilterOrder', filterOrder, ...
    'SampleRate', sampleRate, 'CutoffFrequency1', 8, 'CutoffFrequency2', 12);
%%% Beta filter
filters{4} = designfilt('bandpassfir', 'Window', 'hamming', 'FilterOrder', filterOrder, ...
    'SampleRate', sampleRate, 'CutoffFrequency1', 12, 'CutoffFrequency2', 30);
%%% Gamma filter
filters{5} = designfilt('highpassfir', 'Window', 'hamming', 'FilterOrder', filterOrder, ...
    'SampleRate', sampleRate, 'CutoffFrequency', 30);
end
