function [ground_speeds] = calculate_ground_speeds(data, marker, threshold, incline, directory)
    y = data.markers.LHEE(:, 2, :);
    size_vector = size(squeeze(y));
    num_trials = size_vector(2);
    ground_speeds = zeros(1, num_trials);
    
    addpath(directory + 'computation_functions/');
    cadences = find_cadence(data, marker);
    [HS, TO] = find_HS_TO(data, threshold, directory);
    rmpath(directory + 'computation_functions/');
    stride_times = 60 ./ cadences;
    
    
    for i_trials = 1 : size_vector(2)

        % Calculate ground data
        this_y_grounded = zeros(1, 10);
        count = 0;
        for i_stride_points = (HS(i_trials) + 20) : (HS(i_trials) + 30)
            count = count + 1;
            this_y_grounded(count) = y(i_stride_points, i_trials);
        end

        % Calculate stride length and stride time
        this_y_size = size(y);
        stride_length_grounded = abs(this_y_grounded(1) - this_y_grounded(end)) ./ cos(incline * pi / 180);
        stride_time_grounded = stride_times(i_trials) * (10 / this_y_size(1));

        % Speeds = stride length / stride_time
        this_ground_speed = stride_length_grounded / stride_time_grounded;
        ground_speeds(i_trials) = this_ground_speed;
    end
end