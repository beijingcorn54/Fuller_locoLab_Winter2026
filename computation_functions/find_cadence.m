% Produces cadences (single-leg cadence) from all trials of a specified person/incline/speed

function [cadences] = find_cadence(data, marker)
    % Establish variables
    stride_details = data.events.StrideDetails;
    strideDetails_size_vector = size(stride_details);

    % Leg Marker
    leg = 1;

    % Extract stride times from stride details
    stride_times = 0;
    for i = 1 : strideDetails_size_vector(1)
        if stride_details(i, 4) == leg
            % 100Hz = 0.01 sec
            new_stride_times = stride_details(i, 3) * 0.01;
            stride_times = [stride_times, new_stride_times];
        end
    end
    stride_times = stride_times(2 : end);

    % Cadence = Steps Per Minute
    cadences = 60 ./ stride_times;
end
