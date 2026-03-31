function [y_corrected] = correct_strides(y, data, threshold, v_treadmill, marker, directory)    
    % 1. Establish initial y-position and other variables
    y_corrected = y;
    
    addpath(directory + 'computation_functions/'); 
    cadences = find_cadence(data, marker);
    size_vector = size(y);
    [HS, TO] = find_HS_TO(data, threshold, directory);
    rmpath(directory + 'computation_functions/');

    % 2. Make corrections for each trial
    for trials = 1 : size_vector(2)
        % i. Get variables for single trial
        this_y = y(:, trials);
        this_y_corrected = this_y;
        this_cadence = cadences(trials);
        this_y_size_vector = size(this_y_corrected);
        this_HS = HS(trials);
        this_TO = TO(trials);
    
        % ii. Calculate infintesimal corrective displacement
        stride_time = 60 / this_cadence;
        dt = stride_time / this_y_size_vector(1);
        dx = v_treadmill * dt;

        % iii. Apply corrections
        for i = 1 : this_y_size_vector(1)
            treadmill_correction = dx * (i - 1);
            this_y_corrected(i) = this_y(i) - treadmill_correction;
     
            %this_y_corrected(i) = this_y(i) + abs(this_y_corrected(this_TO) - this_y(this_TO));
        end
  
        % v. Update larger vector
        y_corrected(:, trials) = this_y_corrected;
    end
end