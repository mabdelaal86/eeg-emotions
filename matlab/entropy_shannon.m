function [ y ] = entropy_shannon( x )
%ENTROPY_SHANNON compute the shannon entropy of a signal

%%% get probability of signal values
px = histcounts(x, 'Normalization', 'probability');

%%% skip 0 values (for log to work)
px = px(px~=0);

%%% compute shannon entropy
y = -sum(px .* log(px));

end
