%%% get metadata of DEAP
metadata = dataset.metadata();

b1 = 6; % beta index
b2 = 5; % alpha index

%%% load data
fileName = '+welch/+psd/+bands/+32/power_log';
bands = load(metadata.getDataFileName(fileName));

%%% calc band to band features
data = bands.data(:, b1, :, :) ./ bands.data(:, b2, :, :);

%%% set data info
info = bands.info;
info{2, 2} = 'Beta to Alpha';

%%% save data
fileName = strrep(fileName, '+32/', '+b2b/');
fileName = [fileName '_beta2alpha'];

save(metadata.getDataFileName(fileName), 'data', 'info');
