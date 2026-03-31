function [trials] = getTrials(data)
    size_vector = size(squeeze(data));
    trials = size_vector(2);
end
