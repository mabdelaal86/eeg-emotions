function [ classes ] = lowhigh( labels )
%LOWHIGH map labels (1-9) into classes (0,1)

common.printonce('* Map labels (1-9) into classes (0,1) \n');

classes = labels >= 5;

end
