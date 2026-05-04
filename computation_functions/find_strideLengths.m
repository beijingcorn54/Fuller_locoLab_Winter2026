% Produces stride-lengths (single-leg stride lengths) from all trials of a specified person/incline/speed
% HS to next HS

function [stride_lengths] = find_strideLengths(data, threshold, v_treadmill, marker, incline, directory)   
    % Get Position Variables
    y = squeeze(data.markers.LHEE(:, 2, :));

    addpath(directory + 'helper_functions/');
    y = correct_strides(y, data, threshold, v_treadmill, marker, directory);

    addpath(directory + 'helper_functions/');
    y_size = getTrials(y);

    stride_lengths = zeros(1, y_size);

    % Make calculations
    for i = 1 : y_size
        stride_lengths(i) = abs(y(150, i) - y(1, i));
    end

    % Account for incline
    stride_lengths = stride_lengths ./ cos(incline * pi /180);

end