function extract_features( )
%Extract EEG features from DEAP dataset

metadata = dataset.metadata();
rhythmRangs = { [0,4], [4,8], [8,12], [12,30], [30,64] };
filters = signal.filters(metadata.sampleRate, rhythmRangs);
data = zeros(metadata.channelsLen, length(rhythmRangs), ...
    metadata.videosLen, metadata.participantsLen);

%%% extract data
for pId = 1:metadata.participantsLen
    fileName = metadata.getSubjectFileName(pId);
    subject = load(fileName, 'data'); % data => subject.data
    for vId = 1:metadata.videosLen
        for cId = 1:metadata.channelsLen
            eegSig = squeeze(subject.data(vId, cId, :));
            %%% extract from 4th to 63rd second (skip 1st three seconds)
            eegSig = eegSig((3*metadata.sampleRate+1):end);
            data(cId, :, vId, pId) = featcalc(...
                eegSig, metadata.sampleRate, filters, rhythmRangs);
        end
    end
end

%%% save data into files
save(metadata.getDataFileName('data32'), 'data');
end

function [ y ] = featcalc( x, fs, filters, rhythmRangs ) %#ok<INUSL>
% y = calcsigfeat(x, @mean, filters);
% y = calcsigfeat(x, @std, filters);
% y = calcsigfeat(x, @var, filters);
% y = calcsigfeat(x, @skewness, filters);
% y = calcsigfeat(x, @kurtosis, filters);
% y = calcsigfeat(x, @signal.hjorth_mobility, filters);
% y = calcsigfeat(x, @signal.hjorth_complexity, filters);
% y = calcsigfeat(x, @signal.oscillation, filters);
% y = calcsigfeat(x, @signal.peak2peak, filters);
% y = calcsigfeat(x, @signal.entropy_shannon, filters);
% y = calcsigfeat(fft(x), @signal.entropy_spectral, rhythmRangs, fs);
% y = calcsigfeat(x, @signal.energy, filters); % absolute energy
% y = calcsigfeat(x, @signal.power_welch, rhythmRangs, fs); % absolute power
y = log(calcsigfeat(x, @signal.power_welch, rhythmRangs, fs)); % log of power
end

function y = calcsigfeat( x, func, filters, fs )
L = length(filters);  y = zeros(L, 1);
for r = 1:L
    if nargin==4,     y(r) = func( x, fs, filters{r} );
    else              y(r) = func( filtfilt(filters{r}, x) );
    end
    if isnan(y(r)),   error('# Feature value is NaN !!!');    end
end
end
