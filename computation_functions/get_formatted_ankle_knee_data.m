% For each speed and subject, this data is:
    % Separate ankle and knee data
    % Cadence, Normalized Stride Length, Calculated Speed, and Recorded Speed data included in the first 4 rows of the vector
    % Stance phase only

function [ankle_torque_processed, knee_torque_processed, ankle_angle_processed, knee_angle_processed] = get_formatted_ankle_knee_data(dataBase, directory, subjects, speeds, legLengths, incline_vector, force_threshold)
ankle_torque_processed = [];
knee_torque_processed = [];
ankle_angle_processed = [];
knee_angle_processed = [];

    for i_speed = 1 : 3
        for i_subject = 1 : 10
    
            % Data Extraction: Saggital data only
            data = dataBase.(subjects(i_subject)).Walk.(speeds(i_speed, 1)).(incline_vector(1));
            ankle_torque = squeeze(data.jointMoments.AnkleMoment(:, 1, :));
            knee_torque = squeeze(data.jointMoments.KneeMoment(:, 1, :));
            ankle_angle = squeeze(data.jointAngles.AnkleAngles(:, 1, :));
            knee_angle = squeeze(data.jointAngles.KneeAngles(:, 1, :));
    
            % 1a. Find HS and TO indecies
            addpath(directory + 'computation_functions/');
            [HS, TO] = find_HS_TO(data, force_threshold);
            rmpath(directory + 'computation_functions/');
    
            % 1b. Isolate stance phase data by NaN-ing out the swing phase data
            for i_col = 1 : size(HS, 2)
                this_HS = HS(i_col);
                this_TO = TO(i_col);
    
                % NaN pre-HS points
                if this_HS ~= 1
                    for i_row = 1 : this_HS - 1
                        ankle_torque(i_row, i_col) = NaN;
                        knee_torque(i_row, i_col) = NaN;
                        ankle_angle(i_row, i_col) = NaN;
                        knee_angle(i_row, i_col) = NaN;
                    end
                end
    
                % NaN post-TO points
                if this_TO ~= 150
                    for i_row = this_TO + 1 : 150
                        ankle_torque(i_row, i_col) = NaN;
                        knee_torque(i_row, i_col) = NaN;
                        ankle_angle(i_row, i_col) = NaN;
                        knee_angle(i_row, i_col) = NaN;
                    end
                end
            end
                
            % 2a. Get Cadence and Normalized stride length data
            v_treadmill = str2double(speeds(i_speed, 2));
            incline_val = str2double(incline_vector(2));

            addpath(directory + 'computation_functions/');
            [stride_lengths, norm_stride_lengths] = find_strideLengths(data, v_treadmill, incline_val, legLengths(i_subject));
            cadences = find_cadence(data);

            % 2b. Include Speed, Cadence and Normalized stride length data
            calculated_speeds = stride_lengths .* cadences ./ 60;
            treadmill_speed = -v_treadmill * ones(1, size(calculated_speeds, 2));
            
            ankle_torque_processed = [ankle_torque_processed, [cadences; norm_stride_lengths; calculated_speeds; treadmill_speed; ankle_torque]];
            knee_torque_processed = [knee_torque_processed, [cadences; norm_stride_lengths; calculated_speeds; treadmill_speed; knee_torque]];
            ankle_angle_processed = [ankle_angle_processed, [cadences; norm_stride_lengths; calculated_speeds; treadmill_speed; ankle_angle]];
            knee_angle_processed = [knee_angle_processed, [cadences; norm_stride_lengths; calculated_speeds; treadmill_speed; knee_angle]];
        end
    end
end
