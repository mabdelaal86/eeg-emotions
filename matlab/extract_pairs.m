%%% get metadata of DEAP
metadata = dataset.metadata();

%%% set data files
fileName = '+welch/+psd/+bands/+32/power_log';

%%% load data
channels = load(metadata.getDataFileName(fileName));

%%% Calc data of pair channels
pair1Data = channels.data(metadata.pairChannels(:, 1), :, :, :);
pair2Data = channels.data(metadata.pairChannels(:, 2), :, :, :);

data = pair1Data - pair2Data;

info = channels.info;
info{4, 2} = '14 pairs of channels';

%%% save data
fileName = strrep(fileName, '+32/', '+14/');
save(metadata.getDataFileName(fileName), 'data', 'info');
