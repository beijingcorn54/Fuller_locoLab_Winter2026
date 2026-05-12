% Produces cadences from all trials of a specified person/incline/speed

function [cadences] = find_cadence(data)
    % Establish variables
    stride_details = data.events.StrideDetails;

    % Extract stride times from stride details
    stride_times = [];
    for i = 1 : size(stride_details, 1)
        % 100Hz = 0.01 sec
        stride_times = [stride_times, stride_details(i, 3) * 0.01];
    end

    % Cadence = Steps Per Minute
    cadences = 60 ./ stride_times;
end
