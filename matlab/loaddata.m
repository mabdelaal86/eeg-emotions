function [ featdata, labels ] = loaddata( filenames, filterfun )
%LOADDATA Load needed features and labels

fprintf('* Loaded data: %s. \n', strjoin(filenames, ', '));
filesLen = length(filenames);

%%% load features data
filedata = cell(filesLen, 1);
for fn = 1:filesLen
    data = []; load(['dataset/' filenames{fn}], 'data');
    %%% select specific frequency bands
    data = filterfun(data, filenames{fn});
    %%% reshape data to fit classification process (c,r,v,p => v,c*r,p)
    data = reformatdata(data);
    filedata{fn} = data;
end
featdata = horzcat(filedata{:});

%%% Load labels
labels = [];
load('dataset/labels', 'labels');

end

function y = reformatdata(x)

sz = size(x);
y = zeros(sz(3), sz(1) * sz(2), sz(4));

for c = 1:sz(1)
    for r = 1:sz(2)
        for v = 1:sz(3)
            for p = 1:sz(4)
                y(v, (c-1) * sz(2) + r, p) = x(c, r, v, p);
            end
        end
    end
end

end
