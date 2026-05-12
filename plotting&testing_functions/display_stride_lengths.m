function display_stride_lengths(data, v_treadmill, incline, legLength, directory)

    addpath(directory + 'computation_functions/'); 
    [stride_lengths, normalized_stride_lengths] = find_strideLengths(data, v_treadmill, incline, legLength);

    for i = 1 : size(stride_lengths, 2)
        disp("[Stride Length, Normalized Stride Length] Trial #" + i + ": " + stride_lengths(i) ...
            + ", " + normalized_stride_lengths(i));
    end
end
