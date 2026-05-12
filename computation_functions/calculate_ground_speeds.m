function [ground_speeds] = calculate_ground_speeds(data, force_threshold, incline, directory)
    y = [squeeze(data.markers.LHEE(:, 2, :)), squeeze(data.markers.RHEE(:, 2, :))];
    ground_speeds = zeros(1, size(y, 2));
    
    addpath(directory + 'computation_functions/');
    cadences = find_cadence(data);
    [HS, Ignore_TO] = find_HS_TO(data, force_threshold);
    
    stride_times = 60 ./ cadences;
    
    for i_col = 1 : size(y, 2)

        % Calculate ground data
        this_y_grounded = zeros(1, 10);
        count = 0;

        for i_stride_points = (HS(i_col) + 20) : (HS(i_col) + 30)
            count = count + 1;
            this_y_grounded(count) = y(i_stride_points, i_col);
        end

        % Calculate stride length and stride time
        stride_length_grounded = abs(this_y_grounded(1) - this_y_grounded(end)) ./ cos(incline * pi / 180);
        stride_time_grounded = stride_times(i_col) * (10 / size(y, 1));

        % Speeds = stride length / stride_time
        this_ground_speed = stride_length_grounded / stride_time_grounded;
        ground_speeds(i_col) = this_ground_speed;
    end
end
