% Produces normalized stride-lengths (single-leg stride lengths) from all trials of a specified person/incline/speed

function [stride_lengths] = find_normalized_strideLengths(data, threshold, v_treadmill, marker, incline, legLength, directory)   
    stride_lengths = find_strideLengths(data, threshold, v_treadmill, marker, incline, directory);
    stride_lengths = stride_lengths ./ legLength;
end