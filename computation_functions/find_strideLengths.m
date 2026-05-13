% Produces stride-lengths from all trials of a specified person/incline/speed

function [stride_lengths, normalized_stride_lengths] = find_strideLengths(data, v_treadmill, incline, legLength)
    y = correct_strides(data, v_treadmill);
    stride_lengths = zeros(1, size(y, 2));

    % Make calculations
    for i = 1 : size(y, 2)
        stride_lengths(i) = abs(y(150, i) - y(1, i));
    end

    % Account for incline
    stride_lengths = stride_lengths ./ cos(incline * pi /180);

    % Produce normalized stride lengths
    normalized_stride_lengths = stride_lengths ./ legLength;
end