clear;
close all;

% Variables
threshold = 25;
marker = "LHEE";
subjects = ["AB01", "AB02", "AB03", "AB04", "AB05", "AB06", "AB07", "AB08", "AB09", "AB10"];
legLengths = [0.951, 0.921, 0.99, 0.96, 0.766, 0.918, 0.859, 0.991, 0.940, 0.815];
speeds = ["s0x8", -0.8; "s1", -1; "s1x2", -1.2];
inclines = ["i10", 10; "i5", 5; "i0", 0; "in5", -5; "in10", -10];

% Load in Data
directory = "/Users/kefuller/Fuller_Locolab/";
dataBase = load(directory + "locolab_files/Normalized.mat").Normalized;

% Call Functions
incline_vector = inclines(1, :);
[in10_ankle, in10_knee] = get_formatted_ankle_knee_data(dataBase, directory, subjects, speeds, legLengths, incline_vector, threshold, marker);
plot_sorted_data(in10_ankle, in10_knee, -10);

incline_vector = inclines(2, :);
[in5_ankle, in5_knee] = get_formatted_ankle_knee_data(dataBase, directory, subjects, speeds, legLengths, incline_vector, threshold, marker);
plot_sorted_data(in5_ankle, in5_knee, -5);

incline_vector = inclines(3, :);
[i0_ankle, i0_knee] = get_formatted_ankle_knee_data(dataBase, directory, subjects, speeds, legLengths, incline_vector, threshold, marker);
plot_sorted_data(i0_ankle, i0_knee, 0);

incline_vector = inclines(4, :);
[i5_ankle, i5_knee] = get_formatted_ankle_knee_data(dataBase, directory, subjects, speeds, legLengths, incline_vector, threshold, marker);
plot_sorted_data(i5_ankle, i5_knee, 5);

incline_vector = inclines(5, :);
[i10_ankle, i10_knee] = get_formatted_ankle_knee_data(dataBase, directory, subjects, speeds, legLengths, incline_vector, threshold, marker);
plot_sorted_data(i10_ankle, i10_knee, 10);

%% Helper Functions

function [incline_ankle, incline_knee] = get_formatted_ankle_knee_data(dataBase, directory, subjects, speeds, legLengths, incline_vector, threshold, marker)
% For each speed and subject, this data is:
    % Separate ankle and knee data
    % Cadence and Normalized Stride length data included in the first two rows of the vector
    % Left leg only
    % Stand phase only


incline_ankle = [];
incline_knee = [];

    for i_speed = 1 : 3
        for i_subject = 1 : 10
    
            % Data Extraction
            data = dataBase.(subjects(i_subject)).Walk.(speeds(i_speed, 1)).(incline_vector(1));
            ankle_data_raw = data.jointMoments.AnkleMoment;
            knee_data_raw = data.jointMoments.KneeMoment;
    
            % 1. Y data only: Resizing occurs
            ankle_data = squeeze(ankle_data_raw(:, 2, :));
            knee_data = squeeze(knee_data_raw(:, 2, :));
    
            % 2a. Find indexes of left leg strides
            right_leg_index = 0;
            stride_details = data.events.StrideDetails;
            strideDetails_size_vector = size(stride_details);
            for i = 1 : strideDetails_size_vector(1)
                if stride_details(i, 4) == 2 %% 2 is the right leg indicator
                    right_leg_index = i;
                    break;
                end
            end
    
            % 2b. Isolate only left leg strides by zero-ing out the right strides
            ak_size_vector = size(ankle_data);
    
            for i = right_leg_index : ak_size_vector(2)
                ankle_data(:, i) = 0;
                knee_data(:, i) = 0;
            end
    
            % 3a. Find HS and TO indecies
            addpath(directory + 'computation_functions/');
            [HS, TO] = find_HS_TO(data, threshold, directory);
            rmpath(directory + 'computation_functions/');
    
            % 3b. Isolate stance phase data by zero-ing out the swing phase data
            HS_TO_size_vector = size(HS);
            for i_col = 1 : HS_TO_size_vector(2)
                this_HS = HS(i_col);
                this_TO = TO(i_col);
    
                % Zero pre-HS points
                if this_HS ~= 1
                    for i_row = 1 : this_HS - 1
                        ankle_data(i_row, i_col) = 0;
                        knee_data(i_row, i_col) = 0;
                    end
                end
    
                % Zero post-TO points
                if this_TO ~= 150
                    for i_row = this_TO + 1 : 150
                        ankle_data(i_row, i_col) = 0;
                        knee_data(i_row, i_col) = 0;
                    end
                end
            end
                
            % 4a. Get Cadence and Normalized stride length data
            addpath(directory + 'computation_functions/');
            cadences = find_cadence(data, marker);
            rmpath(directory + 'computation_functions/');
    
            v_treadmill = str2double(speeds(i_speed, 2));
            incline_val = str2double(incline_vector(2));
            addpath(directory + 'computation_functions/');
            norm_stride_lengths = find_normalized_strideLengths(data, threshold, v_treadmill, marker, incline_val, legLengths(i_subject), directory);
    
            % 4b. Include Cadence and Normalized stride length data
            ankle_data_to_append = [zeros(2, ak_size_vector(2)); ankle_data];
            knee_data_to_append = [zeros(2, ak_size_vector(2)); knee_data];
    
            cadence_SL_size_vector = size(cadences);
            for i_col = 1 : cadence_SL_size_vector(2)
                ankle_data_to_append(1 : 2, i_col) = [cadences(i_col); norm_stride_lengths(i_col)];
                knee_data_to_append(1 : 2, i_col) = [cadences(i_col); norm_stride_lengths(i_col)];
            end
            
            incline_ankle = [incline_ankle, ankle_data_to_append];
            incline_knee = [incline_knee, knee_data_to_append];
        end
    end
end

function [sorted_data] = sort_a_vector(data, upper_bound, lower_bound, sorting_cadence)
    sorted_data = [];
    row = 2 - sorting_cadence;

    data_size_vector = size(data);
    for i_col = 1 : data_size_vector(2)

        data_to_append = data(:, i_col);
        sorting_measurement = data_to_append(row);        
    
        valid_entry =  sorting_measurement ~= 0;
        within_upper_bound = sorting_measurement < upper_bound;
        within_lower_bound = (sorting_measurement > lower_bound) || (sorting_measurement == lower_bound);
        
       
        if valid_entry && within_upper_bound && within_lower_bound
            sorted_data = [sorted_data, data_to_append];
        end
    end
end

function [mean_std_vector] = get_mean_std_vector(data)
    mean_std_vector = [];
    
    size_vector = size(data);
    for i_row = 1 : size_vector(1)
        valid_data_row = [];
    
        for i_col = 1 : size_vector(2)
            this_datum = data(i_row, i_col);
    
            if this_datum ~=0
                valid_data_row = [valid_data_row, this_datum];
            end
        end
        mean_std_vector = [mean_std_vector; [mean(valid_data_row ,2), std(valid_data_row, 0, 2)]];
    end
end

function plot_sorted_data(ankle_data, knee_data, incline)

% 1. Sorts data into vectors by cadence and normalized stride length
    % uses sort_a_vector function
    % eliminates zero/invalid entries

% 2. Produces a 2-column matrix with:
%   mean vector (column 1)
%   standard deviation vector (column 2)

    a_c40 = get_mean_std_vector(sort_a_vector(ankle_data, 40, 30, true));
    a_c50 = get_mean_std_vector(sort_a_vector(ankle_data, 50, 40, true));
    a_c60 = get_mean_std_vector(sort_a_vector(ankle_data, 60, 50, true));
    a_c70 = get_mean_std_vector(sort_a_vector(ankle_data, 70, 60, true));
    
    k_c40 = get_mean_std_vector(sort_a_vector(knee_data, 40, 30, true));
    k_c50 = get_mean_std_vector(sort_a_vector(knee_data, 50, 40, true));
    k_c60 = get_mean_std_vector(sort_a_vector(knee_data, 60, 50, true));
    k_c70 = get_mean_std_vector(sort_a_vector(knee_data, 70, 60, true));
    
    a_nsl0x9 = get_mean_std_vector(sort_a_vector(ankle_data, 0.9, 0.7, false));
    a_nsl1x1 = get_mean_std_vector(sort_a_vector(ankle_data, 1.1, 0.9, false));
    a_nsl1x3 = get_mean_std_vector(sort_a_vector(ankle_data, 1.3, 1.1, false));
    a_nsl1x5 = get_mean_std_vector(sort_a_vector(ankle_data, 1.5, 1.3, false));
    a_nsl1x7 = get_mean_std_vector(sort_a_vector(ankle_data, 1.7, 1.5, false));
    a_nsl1x9 = get_mean_std_vector(sort_a_vector(ankle_data, 1.9, 1.7, false));
    
    k_nsl0x9 = get_mean_std_vector(sort_a_vector(knee_data, 0.9, 0.7, false));
    k_nsl1x1 = get_mean_std_vector(sort_a_vector(knee_data, 1.1, 0.9, false));
    k_nsl1x3 = get_mean_std_vector(sort_a_vector(knee_data, 1.3, 1.1, false));
    k_nsl1x5 = get_mean_std_vector(sort_a_vector(knee_data, 1.5, 1.3, false));
    k_nsl1x7 = get_mean_std_vector(sort_a_vector(knee_data, 1.7, 1.5, false));
    k_nsl1x9 = get_mean_std_vector(sort_a_vector(knee_data, 1.9, 1.7, false));


% 3. Plot the vectors
    figure;
    tiledlayout(2,2);  % 2 rows, 2 columns
    
    % --- Plot 1 ---
    nexttile;
    hold on;

    legend_entries = {};
    
    size_vector = size(a_c40);
    if ~isempty(a_c40)
        plot(1 : (size_vector(1) - 2), a_c40(3 : end, 1));
        legend_entries{end+1} = '30 - 40';
    end

    size_vector = size(a_c50);
    if ~isempty(a_c50)
        plot(1 : (size_vector(1) - 2), a_c50(3 : end, 1));
        legend_entries{end+1} = '40 - 50';
    end

    size_vector = size(a_c60);
    if ~isempty(a_c60)
        plot(1 : (size_vector(1) - 2), a_c60(3 : end, 1));
        legend_entries{end+1} = '50 - 60';
    end

    size_vector = size(a_c70);
    if ~isempty(a_c70)
        plot(1 : (size_vector(1) - 2), a_c70(3 : end, 1));
        legend_entries{end+1} = '60 - 70';
    end
    
    title('Ankle Cadence (steps per minute)');
    xlabel('Gait Progression');
    ylabel('Torque');
    legend(legend_entries,'location','best');
    grid on;
    hold off;
    
    % --- Plot 2 ---
    nexttile;
    hold on;

    legend_entries = {};
    
    size_vector = size(k_c40);
    if ~isempty(k_c40)
        plot(1 : (size_vector(1) - 2), k_c40(3 : end, 1));
        legend_entries{end+1} = '30 - 40';
    end

    size_vector = size(k_c50);
    if ~isempty(k_c50)
        plot(1 : (size_vector(1) - 2), k_c50(3 : end, 1));
        legend_entries{end+1} = '40 - 50';
    end

    size_vector = size(k_c60);
    if ~isempty(k_c60)
        plot(1 : (size_vector(1) - 2), k_c60(3 : end, 1));
        legend_entries{end+1} = '50 - 60';
    end

    size_vector = size(k_c70);
    if ~isempty(k_c70)
        plot(1 : (size_vector(1) - 2), k_c70(3 : end, 1));
        legend_entries{end+1} = '60 - 70';
    end
    
    title('Knee Cadence (steps per minute)');
    xlabel('Gait Progression');
    ylabel('Torque');
    legend(legend_entries,'location','best');
    grid on;
    hold off;
    
    % --- Plot 3 ---
    nexttile;
    hold on;
    legend_entries = {};
    
    size_vector = size(a_nsl0x9);
    if ~isempty(a_nsl0x9)
        plot(1 : (size_vector(1) - 2), a_nsl0x9(3 : end, 1));
        legend_entries{end+1} = '0.7 - 0.9';
    end

    size_vector = size(a_nsl1x1);
    if ~isempty(a_nsl1x1)
        plot(1 : (size_vector(1) - 2), a_nsl1x1(3 : end, 1));
        legend_entries{end+1} = '0.9 - 1.1';
    end

    size_vector = size(a_nsl1x3);
    if ~isempty(a_nsl1x3)
        plot(1 : (size_vector(1) - 2), a_nsl1x3(3 : end, 1));
        legend_entries{end+1} = '1.1 - 1.3';
    end


    size_vector = size(a_nsl1x5);
    if ~isempty(a_nsl1x5)
        plot(1 : (size_vector(1) - 2), a_nsl1x5(3 : end, 1));
        legend_entries{end+1} = '1.3 - 1.5';
    end

    size_vector = size(a_nsl1x7);
    if ~isempty(a_nsl1x7)
        plot(1 : (size_vector(1) - 2), a_nsl1x7(3 : end, 1));
        legend_entries{end+1} = '1.5 - 1.7';
    end

    size_vector = size(a_nsl1x9);
    if ~isempty(a_nsl1x9)
        plot(1 : (size_vector(1) - 2), a_nsl1x9(3 : end, 1));
        legend_entries{end+1} = '1.7 - 1.9';
    end  
    
    title('Ankle Normalized Stride Length');
    xlabel('Gait Progression');
    ylabel('Torque');
    legend(legend_entries, 'location','best');
    grid on;
    hold off;
    
    % --- Plot 4 ---
    nexttile;
    hold on;
    legend_entries = {};
    
    size_vector = size(k_nsl0x9);
    if ~isempty(k_nsl0x9)
        plot(1 : (size_vector(1) - 2), k_nsl0x9(3 : end, 1));
        legend_entries{end+1} = '0.7 - 0.9';
    end

    size_vector = size(k_nsl1x1);
    if ~isempty(k_nsl1x1)
        plot(1 : (size_vector(1) - 2), k_nsl1x1(3 : end, 1));
        legend_entries{end+1} = '0.9 - 1.1';
    end

    size_vector = size(k_nsl1x3);
    if ~isempty(k_nsl1x3)
        plot(1 : (size_vector(1) - 2), k_nsl1x3(3 : end, 1));
        legend_entries{end+1} = '1.1 - 1.3';
    end


    size_vector = size(k_nsl1x5);
    if ~isempty(k_nsl1x5)
        plot(1 : (size_vector(1) - 2), k_nsl1x5(3 : end, 1));
        legend_entries{end+1} = '1.3 - 1.5';
    end

    size_vector = size(k_nsl1x7);
    if ~isempty(k_nsl1x7)
        plot(1 : (size_vector(1) - 2), k_nsl1x7(3 : end, 1));
        legend_entries{end+1} = '1.5 - 1.7';
    end

    size_vector = size(k_nsl1x9);
    if ~isempty(k_nsl1x9)
        plot(1 : (size_vector(1) - 2), k_nsl1x9(3 : end, 1));
        legend_entries{end+1} = '1.7 - 1.9';
    end  
    
    title('Knee Normalized Stride Length');
    xlabel('Gait Progression');
    ylabel('Torque');
    legend(legend_entries, 'location','best');
    grid on;
    hold off;
    
    % --- Title ---
    sgtitle("Stance Phase Joint Torques, Incline " + incline, 'FontSize', 16, 'FontWeight', 'bold');
   
end
