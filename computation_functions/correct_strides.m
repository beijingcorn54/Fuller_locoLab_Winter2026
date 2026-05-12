function [y_corrected] = correct_strides(data, v_treadmill)    
    % 1. Establish initial y-position and other variables
    y = [squeeze(data.markers.LHEE(:, 2, :)), squeeze(data.markers.RHEE(:, 2, :))];
    cadences = find_cadence(data);
    y_corrected = y;

    % 2. Make corrections for each step
    for i_col = 1 : size(y, 2)

        % i. Get variables for single step
        this_y = y(:, i_col);
        this_y_corrected = this_y;
        this_cadence = cadences(i_col);
    
        % ii. Calculate infintesimal corrective displacement
        stride_time = 60 / this_cadence; % 60 sec * (# min / 1 step)
        dt = stride_time / size(this_y, 1);
        dx = v_treadmill * dt;

        % iii. Apply corrections
        for i_row = 1 : size(this_y, 1)
            treadmill_correction = dx * (i_row - 1);
            this_y_corrected(i_row) = this_y(i_row) - treadmill_correction;
        end
  
        % v. Update larger vector
        y_corrected(:, i_col) = this_y_corrected;
    end
end