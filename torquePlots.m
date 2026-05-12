clear; % Fixing in5
close all;

% Variables
force_threshold = 25;
subjects = ["AB01", "AB02", "AB03", "AB04", "AB05", "AB06", "AB07", "AB08", "AB09", "AB10"];
legLengths = [0.951, 0.921, 0.99, 0.96, 0.766, 0.918, 0.859, 0.991, 0.940, 0.815];
speeds = ["s0x8", -0.8; "s1", -1; "s1x2", -1.2];
inclines = ["i10", 10; "i5", 5; "i0", 0; "in5", -5; "in10", -10];

% Load in Data
directory = "/Users/kefuller/Fuller_Locolab/";
dataBase = load(directory + "locolab_files/Normalized.mat").Normalized;

% Call Functions
incline_vector = inclines(1, :);
[in10_ankle, in10_knee] = get_formatted_ankle_knee_data(dataBase, directory, subjects, speeds, legLengths, incline_vector, force_threshold);
plot_sorted_data(in10_ankle, in10_knee, -10);

incline_vector = inclines(2, :);
[in5_ankle, in5_knee] = get_formatted_ankle_knee_data(dataBase, directory, subjects, speeds, legLengths, incline_vector, force_threshold);
    % in5_ankle at column 782 is completely NaN in the original data. It is NOT
    % a fault of the code.
plot_sorted_data(in5_ankle, in5_knee, -5);

incline_vector = inclines(3, :);
[i0_ankle, i0_knee] = get_formatted_ankle_knee_data(dataBase, directory, subjects, speeds, legLengths, incline_vector, force_threshold);
plot_sorted_data(i0_ankle, i0_knee, 0);

incline_vector = inclines(4, :);
[i5_ankle, i5_knee] = get_formatted_ankle_knee_data(dataBase, directory, subjects, speeds, legLengths, incline_vector, force_threshold);
plot_sorted_data(i5_ankle, i5_knee, 5);

incline_vector = inclines(5, :);
[i10_ankle, i10_knee] = get_formatted_ankle_knee_data(dataBase, directory, subjects, speeds, legLengths, incline_vector, force_threshold);
plot_sorted_data(i10_ankle, i10_knee, 10);

%% Helper Functions
function [incline_ankle, incline_knee] = get_formatted_ankle_knee_data(dataBase, directory, subjects, speeds, legLengths, incline_vector, force_threshold)
% For each speed and subject, this data is:
    % Separate ankle and knee data
    % Cadence and Normalized Stride length data included in the first two rows of the vector
    % Stand phase only

incline_ankle = [];
incline_knee = [];

    for i_speed = 1 : 3
        for i_subject = 1 : 10
    
            % Data Extraction: Saggital data only
            data = dataBase.(subjects(i_subject)).Walk.(speeds(i_speed, 1)).(incline_vector(1));
            ankle_data = squeeze(data.jointMoments.AnkleMoment(:, 1, :));
            knee_data = squeeze(data.jointMoments.KneeMoment(:, 1, :));
    
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
                        ankle_data(i_row, i_col) = NaN;
                        knee_data(i_row, i_col) = NaN;
                    end
                end
    
                % NaN post-TO points
                if this_TO ~= 150
                    for i_row = this_TO + 1 : 150
                        ankle_data(i_row, i_col) = NaN;
                        knee_data(i_row, i_col) = NaN;
                    end
                end
            end
                
            % 2a. Get Cadence and Normalized stride length data
            v_treadmill = str2double(speeds(i_speed, 2));
            incline_val = str2double(incline_vector(2));

            addpath(directory + 'computation_functions/');
            [Ignore_SL, norm_stride_lengths] = find_strideLengths(data, v_treadmill, incline_val, legLengths(i_subject));
            cadences = find_cadence(data);

            % 2b. Include Cadence and Normalized stride length data
            incline_ankle = [incline_ankle, [cadences; norm_stride_lengths; ankle_data]];
            incline_knee = [incline_knee, [cadences; norm_stride_lengths; knee_data]];
        end
    end
end

function [sorted_data] = sort_a_vector(data, upper_bound, lower_bound, sorting_cadence)
    sorted_data = [];
    row = 2 - sorting_cadence;

    for i_col = 1 : size(data, 2)

        data_to_append = data(:, i_col);
        sorting_measurement = data_to_append(row);        
    
        valid_entry =  ~isnan(sorting_measurement);
        within_upper_bound = sorting_measurement < upper_bound;
        within_lower_bound = (sorting_measurement > lower_bound) || (sorting_measurement == lower_bound);
        
       
        if valid_entry && within_upper_bound && within_lower_bound
            sorted_data = [sorted_data, data_to_append];
        end
    end
end

function [interpolated_data] = get_interpolated_data(data)
    % Stack the data
    stacked_data{1, size(data, 2)} = [];
    
     for i_col = 1 : size(data, 2)
         stacked_column = [];
    
          for i_row = 1 : size(data, 1)
              this_datum = data(i_row, i_col);
    
              if ~isnan(this_datum)
                  stacked_column = [stacked_column; this_datum];
              end
          end
    
          stacked_data{i_col} = stacked_column;
     end
    
    % Find maximum length of data
    max_data_length = 0;
    for i_col = 1 : size(stacked_data, 2)
        this_data_length = size(stacked_data{i_col}, 1) - 2;
        
        if this_data_length > max_data_length
            max_data_length = this_data_length;
        end
    end
    
    % Interpolate data
    interpolated_data = [];
    for i_col = 1 : size(stacked_data, 2)
        if ~isnan(stacked_data{i_col}(3 : end))
            this_length = size(stacked_data{i_col}, 1) - 2;
        
            x = 1 : this_length;
            y = stacked_data{i_col}(3 : end);
        
            interpolate_x = linspace(1, this_length, max_data_length);
            interpolate_y = interp1(x, y, interpolate_x)';
    
            interpolated_data = [interpolated_data, [stacked_data{i_col}(1 : 2); interpolate_y]];
        end
    end
end

function [mean_std_vector] = get_mean_std_vector(data)
    if ~isempty(data(4 : end))
        % Interpolate Data
        interpolated_data = get_interpolated_data(data);
    
        % Find mean, standard deviation, and number of trials/steps
        % represented in the matrix
        mean_std_vector = [];
    
        for i_row = 1 : size(interpolated_data, 1)        
            mean_std_vector = [mean_std_vector; [mean(interpolated_data(i_row, :)), std(interpolated_data(i_row, :)), size(interpolated_data, 2)]];
        end

    else
        mean_std_vector = [];
    end
end

function plot_sorted_data(ankle_data, knee_data, incline)
% 1. Sorts data into vectors by cadence and normalized stride length
    % uses sort_a_vector function
    % eliminates zero/invalid entries

% 2. Produces a 2-column matrix with:
%   mean vector (column 1)
%   standard deviation vector (column 2)

ankle_cadence{2, 4} = 0;
ankle_cadence(1, :) =  {get_mean_std_vector(sort_a_vector(ankle_data, 40, 30, true)), ...
                        get_mean_std_vector(sort_a_vector(ankle_data, 50, 40, true)), ...
                        get_mean_std_vector(sort_a_vector(ankle_data, 60, 50, true)), ...
                        get_mean_std_vector(sort_a_vector(ankle_data, 70, 60, true))};
ankle_cadence(2, :) = {"30 - 40", "40 - 50", "50 - 60", "60 - 70"};


knee_cadence{2, 4} = 0;
knee_cadence(1, :) =   {get_mean_std_vector(sort_a_vector(knee_data, 40, 30, true)), ...
                        get_mean_std_vector(sort_a_vector(knee_data, 50, 40, true)), ...
                        get_mean_std_vector(sort_a_vector(knee_data, 60, 50, true)), ...
                        get_mean_std_vector(sort_a_vector(knee_data, 70, 60, true))};
knee_cadence(2, :) = {"30 - 40", "40 - 50", "50 - 60", "60 - 70"};


ankle_normalizedStrideLength{2, 6} = 0;
ankle_normalizedStrideLength(1, :) =   {get_mean_std_vector(sort_a_vector(ankle_data, 0.9, 0.7, false)), ...
                                        get_mean_std_vector(sort_a_vector(ankle_data, 1.1, 0.9, false)), ...
                                        get_mean_std_vector(sort_a_vector(ankle_data, 1.3, 1.1, false)), ...
                                        get_mean_std_vector(sort_a_vector(ankle_data, 1.5, 1.3, false)), ...
                                        get_mean_std_vector(sort_a_vector(ankle_data, 1.7, 1.5, false)), ...
                                        get_mean_std_vector(sort_a_vector(ankle_data, 1.9, 1.7, false))};
ankle_normalizedStrideLength(2, :) = {"0.7 - 0.9", "0.9 - 1.1", "1.1 - 1.3", "1.3 - 1.5", "1.5 - 1.7", "1.7 - 1.9"};

knee_normalizedStrideLength{2, 6} = 0;
knee_normalizedStrideLength(1, :) =    {get_mean_std_vector(sort_a_vector(knee_data, 0.9, 0.7, false)), ...
                                        get_mean_std_vector(sort_a_vector(knee_data, 1.1, 0.9, false)), ...
                                        get_mean_std_vector(sort_a_vector(knee_data, 1.3, 1.1, false)), ...
                                        get_mean_std_vector(sort_a_vector(knee_data, 1.5, 1.3, false)), ...
                                        get_mean_std_vector(sort_a_vector(knee_data, 1.7, 1.5, false)), ...
                                        get_mean_std_vector(sort_a_vector(knee_data, 1.9, 1.7, false))};
knee_normalizedStrideLength(2, :) = {"0.7 - 0.9", "0.9 - 1.1", "1.1 - 1.3", "1.3 - 1.5", "1.5 - 1.7", "1.7 - 1.9"};


% 3. Plot the vectors
    colors = ['r' 'g' 'w' 'c' 'm' 'y'];
    figure;
    tiledlayout(2,2);  % 2 rows, 2 columns
    
    % --- Plot 1 ---
    nexttile;
    hold on;
    legend_entries = {};

    for bucket_number = 1 : 4
        if ~isempty(ankle_cadence{1, bucket_number}) % && (ankle_cadence{1, bucket_number}(3,3) > 100)
            vector_size = size(ankle_cadence{1, bucket_number}, 1) - 2;
            x = linspace(0, 100, vector_size);
            y = ankle_cadence{1, bucket_number}(3 : end, 1)';
            error = ankle_cadence{1, bucket_number}(3 : end, 2)';
            plotShaded(x, [y + error; y; y - error], colors(bucket_number), '-', 1);
            legend_entries{end + 1} = ankle_cadence{2, bucket_number} + ", " + ankle_cadence{1, bucket_number}(3, 3) + " T";
        end
    end
    
    title('Ankle Torque vs Cadence (steps per minute)');
    xlabel('Gait Percentage');
    ylabel('Torque');
    legend(legend_entries,'location','best');
    grid on;
    hold off;
    
    % --- Plot 2 ---
    nexttile;
    hold on;
    legend_entries = {};
    
    for bucket_number = 1 : 4
        if ~isempty(knee_cadence{1, bucket_number}) % && (knee_cadence{1, bucket_number}(3,3) > 100)
            vector_size = size(knee_cadence{1, bucket_number}, 1) - 2;
            x = linspace(0, 100, vector_size);
            y = knee_cadence{1, bucket_number}(3 : end, 1)';
            error = knee_cadence{1, bucket_number}(3 : end, 2)';
            plotShaded(x, [y + error; y; y - error], colors(bucket_number),'-', 1);
            legend_entries{end + 1} = knee_cadence{2, bucket_number} + ", " + knee_cadence{1, bucket_number}(3, 3) + " T";
        end
    end
    
    title('Knee Torque vs Cadence (steps per minute)');
    xlabel('Gait Percentage');
    ylabel('Torque');
    legend(legend_entries,'location','best');
    grid on;
    hold off;
    
    % --- Plot 3 ---
    nexttile;
    hold on;
    legend_entries = {};

    for bucket_number = 1 : 6
        if ~isempty(ankle_normalizedStrideLength{1, bucket_number}) % && (ankle_normalizedStrideLength{1, bucket_number}(3,3) > 100)
            vector_size = size(ankle_normalizedStrideLength{1, bucket_number}, 1) - 2;
            x = linspace(0, 100, vector_size);
            y = ankle_normalizedStrideLength{1, bucket_number}(3 : end, 1)';
            error = ankle_normalizedStrideLength{1, bucket_number}(3 : end, 2)';
            plotShaded(x, [y + error; y; y - error], colors(bucket_number), '-', 1);
            legend_entries{end + 1} = ankle_normalizedStrideLength{2, bucket_number} + ", " + ankle_normalizedStrideLength{1, bucket_number}(3, 3) + " T";
        end
    end

    title('Ankle Torque vs Normalized Stride Length');
    xlabel('Gait Percentage');
    ylabel('Torque');
    legend(legend_entries, 'location','best');
    grid on;
    hold off;
    
    % --- Plot 4 ---
    nexttile;
    hold on;
    legend_entries = {};

    for bucket_number = 1 : 6
        if ~isempty(knee_normalizedStrideLength{1, bucket_number}) % && (knee_normalizedStrideLength{1, bucket_number}(3,3) > 100)
            vector_size = size(knee_normalizedStrideLength{1, bucket_number}, 1) - 2;
            x = linspace(0, 100, vector_size);
            y = knee_normalizedStrideLength{1, bucket_number}(3 : end, 1)';
            error = knee_normalizedStrideLength{1, bucket_number}(3 : end, 2)';
            plotShaded(x, [y + error; y; y - error], colors(bucket_number), '-', 1);
            legend_entries{end + 1} = knee_normalizedStrideLength{2, bucket_number} + ", " + knee_normalizedStrideLength{1, bucket_number}(3, 3) + " T";
        end
    end
    
    title('Knee Torque vs Normalized Stride Length');
    xlabel('Gait Percentage');
    ylabel('Torque');
    legend(legend_entries, 'location','best');
    grid on;
    hold off;
    
    % --- Title ---
    sgtitle("Stance Phase Joint Torques, Incline " + incline, 'FontSize', 16, 'FontWeight', 'bold');
   
end
