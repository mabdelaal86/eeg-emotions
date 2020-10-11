function [ metadata ] = metadata( )
%METADATA Generate metadata objects for DEAP dataset

metadata.orginalPath = '/path/to/DEAP-dataset/data_preprocessed_matlab/';

metadata.getSubjectFileName = @(participant) ...
    [metadata.orginalPath 's' num2str(participant, '%02u') '.mat'];

curPath = fileparts(mfilename('fullpath'));

metadata.getDataFileName = @(fileName) ...
    [curPath '/../+dataset/' fileName '.mat'];

metadata.participantsLen = 32;
metadata.videosLen = 40;
metadata.trialsLen = 1280; % 32*40
metadata.channelsLen = 32;
metadata.pairChannelsLen = 14;
metadata.sampleRate = 128;
metadata.labelNames = { 'Valence', 'Arousal', 'Dominance', 'Liking' };
metadata.channelNames = {
    'Fp1', 'AF3', 'F3',  'F7',  'FC5', 'FC1', 'C3',  'T7', ...
    'CP5', 'CP1', 'P3',  'P7',  'PO3', 'O1',  'Oz',  'Pz', ...
    'Fp2', 'AF4', 'Fz',  'F4',  'F8',  'FC6', 'FC2', 'Cz', ...
    'C4',  'T8',  'CP6', 'CP2', 'P4',  'P8',  'PO4', 'O2', ...
};

metadata.pairChannels = [
    01 , 17 ;  % Fp1 - Fp2
    02 , 18 ;  % AF3 - AF4
    03 , 20 ;  % F3  - F4
    04 , 21 ;  % F7  - F8
    05 , 22 ;  % FC5 - FC6
    06 , 23 ;  % FC1 - FC2
    07 , 25 ;  % C3  - C4
    08 , 26 ;  % T7  - T8
    09 , 27 ;  % CP5 - CP6
    10 , 28 ;  % CP1 - CP2
    11 , 29 ;  % P3  - P4
    12 , 30 ;  % P7  - P8
    13 , 31 ;  % PO3 - PO4
    14 , 32 ;  % O1  - O2
];

metadata.males = [1,5,6,7,12,16,17,18,19,20,21,23,26,27,28,29,30];
metadata.females = [2,3,4,8,9,10,11,13,14,15,22,24,25,31,32];

metadata.reshapedata = @(data) reshape(data, [], metadata.videosLen, metadata.participantsLen);
metadata.reformatdata = @(data) permute(metadata.reshapedata(data), [2 1 3]);

end
