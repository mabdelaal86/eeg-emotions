function extract_labels( )
%EXTRACT_LABELS Merge DEAP trials' labels into single file

%%% get metadata of DEAP
metadata = dataset.metadata();

%%% labels:
%    40: videos
%    4:  labels (valence, arousal, dominance, liking)
%    32: participants
labels = zeros(metadata.videosLen, 4, metadata.participantsLen);

%%% extract data
for participant = 1:metadata.participantsLen
    fileName = metadata.getSubjectFileName(participant);
    subject = load(fileName, 'labels'); % labels => subject.labels
    
    labels(:, :, participant) = subject.labels;
end

%%% save data into files
save(metadata.getDataFileName('labels'), 'labels')

end
