function display_stride_lengths(data, threshold, v_treadmill, marker, incline, directory)

    addpath(directory + 'computation_functions/'); 
    stride_lengths = find_strideLengths(data, threshold, v_treadmill, marker, incline, directory);

    stride_lengths_size_vector = size(stride_lengths);
    for i = 1 : stride_lengths_size_vector(2)
        disp("Stride Lengths, Trial #" + i + ": " + stride_lengths(i));
    end
end