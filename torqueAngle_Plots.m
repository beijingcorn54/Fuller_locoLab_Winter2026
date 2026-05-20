clear;
close all;

% Variables
force_threshold = 25;
subjects = ["AB01", "AB02", "AB03", "AB04", "AB05", "AB06", "AB07", "AB08", "AB09", "AB10"];
legLengths = [0.951, 0.921, 0.99, 0.96, 0.766, 0.918, 0.859, 0.991, 0.940, 0.815];
speeds = ["s0x8", -0.8; "s1", -1; "s1x2", -1.2];
inclines = ["i10", 10; "i5", 5; "i0", 0; "in5", -5; "in10", -10];
speed_filter = 1.2;

% Load in Data
directory = "/Users/kefuller/Fuller_Locolab/";
dataBase = load(directory + "locolab_files/Normalized.mat").Normalized;

% Develop data via function calls
incline_vector = inclines(5, :);
addpath(directory + 'computation_functions/');
[in10_A_t, in10_K_t, in10_A_a, in10_K_a] = get_formatted_ankle_knee_data(dataBase, directory, subjects, speeds, legLengths, incline_vector, force_threshold);

incline_vector = inclines(4, :);
addpath(directory + 'computation_functions/');
[in5_A_t, in5_K_t, in5_A_a, in5_K_a] = get_formatted_ankle_knee_data(dataBase, directory, subjects, speeds, legLengths, incline_vector, force_threshold);

incline_vector = inclines(3, :);
addpath(directory + 'computation_functions/');
[i0_A_t, i0_K_t, i0_A_a, i0_K_a] = get_formatted_ankle_knee_data(dataBase, directory, subjects, speeds, legLengths, incline_vector, force_threshold);

incline_vector = inclines(2, :);
addpath(directory + 'computation_functions/');
[i5_A_t, i5_K_t, i5_A_a, i5_K_a] = get_formatted_ankle_knee_data(dataBase, directory, subjects, speeds, legLengths, incline_vector, force_threshold);

incline_vector = inclines(1, :);
addpath(directory + 'computation_functions/');
[i10_A_t, i10_K_t, i10_A_a, i10_K_a] = get_formatted_ankle_knee_data(dataBase, directory, subjects, speeds, legLengths, incline_vector, force_threshold);

%% Plot based off metric and joint
% Ankle Torque
if true
    plot_sorted_data(in10_A_t, speed_filter, directory, -10, "Ankle", "Torque", "Unkown Units");
    plot_sorted_data(in5_A_t, speed_filter, directory, -5, "Ankle", "Torque", "Unkown Units");
    plot_sorted_data(i0_A_t, speed_filter, directory, 0, "Ankle", "Torque", "Unkown Units");
    plot_sorted_data(i5_A_t, speed_filter, directory, 5, "Ankle", "Torque", "Unkown Units");
    plot_sorted_data(i10_A_t, speed_filter, directory, 10, "Ankle", "Torque", "Unkown Units");
end

% Knee Torque
if true
    plot_sorted_data(in10_K_t, speed_filter, directory, -10, "Knee", "Torque", "Unkown Units");
    plot_sorted_data(in5_K_t, speed_filter, directory, -5, "Knee", "Torque", "Unkown Units");
    plot_sorted_data(i0_K_t, speed_filter, directory, 0, "Knee", "Torque", "Unkown Units");
    plot_sorted_data(i5_K_t, speed_filter, directory, 5, "Knee", "Torque", "Unkown Units");
    plot_sorted_data(i10_K_t, speed_filter, directory, 10, "Knee", "Torque", "Unkown Units");
end

% Ankle Angle
if true
    plot_sorted_data(in10_A_a, speed_filter, directory, -10, "Ankle", "Angle", "Unkown Units");
    plot_sorted_data(in5_A_a, speed_filter, directory, -5, "Ankle", "Angle", "Unkown Units");
    plot_sorted_data(i0_A_a, speed_filter, directory, 0, "Ankle", "Angle", "Unkown Units");
    plot_sorted_data(i5_A_a, speed_filter, directory, 5, "Ankle", "Angle", "Unkown Units");
    plot_sorted_data(i10_A_a, speed_filter, directory, 10, "Ankle", "Angle", "Unkown Units");
end

% Knee Angle
if true
    plot_sorted_data(in10_K_a, speed_filter, directory, -10, "Knee", "Angle", "Degrees");
    plot_sorted_data(in5_K_a, speed_filter, directory, -5, "Knee", "Angle", "Degrees");
    plot_sorted_data(i0_K_a, speed_filter, directory, 0, "Knee", "Angle", "Degrees");
    plot_sorted_data(i5_K_a, speed_filter, directory, 5, "Knee", "Angle", "Degrees");
    plot_sorted_data(i10_K_a, speed_filter, directory, 10, "Knee", "Angle", "Degrees");
end

%% Plot based off incline
% Incline -10
if false
    plot_sorted_data(in10_A_t, speed_filter, directory, -10, "Ankle", "Torque", "Unkown Units");
    plot_sorted_data(in10_A_a, speed_filter, directory, -10, "Ankle", "Angle", "Degrees");
    plot_sorted_data(in10_K_t, speed_filter, directory, -10, "Knee", "Torque", "Unkown Units");
    plot_sorted_data(in10_K_a, speed_filter, directory, -10, "Knee", "Angle", "Degrees");
end

% Incline -5
if false
    plot_sorted_data(in5_A_t, speed_filter, directory, -5, "Ankle", "Torque", "Unkown Units");
    plot_sorted_data(in5_A_a, speed_filter, directory, -5, "Ankle", "Angle", "Degrees");
    plot_sorted_data(in5_K_t, speed_filter, directory, -5, "Knee", "Torque", "Unkown Units");
    plot_sorted_data(in5_K_a, speed_filter, directory, -5, "Knee", "Angle", "Degrees");
end

% Incline 0
if false
    plot_sorted_data(i0_A_t, speed_filter, directory, 0, "Ankle", "Torque", "Unkown Units");
    plot_sorted_data(i0_A_a, speed_filter, directory, 0, "Ankle", "Angle", "Degrees");
    plot_sorted_data(i0_K_t, speed_filter, directory, 0, "Knee", "Torque", "Unkown Units");
    plot_sorted_data(i0_K_a, speed_filter, directory, 0, "Knee", "Angle", "Degrees");
end

% Incline 5
if false
    plot_sorted_data(i5_A_t, speed_filter, directory, 5, "Ankle", "Torque", "Unkown Units");
    plot_sorted_data(i5_A_a, speed_filter, directory, 5, "Ankle", "Angle", "Degrees");
    plot_sorted_data(i5_K_t, speed_filter, directory, 5, "Knee", "Torque", "Unkown Units");
    plot_sorted_data(i5_K_a, speed_filter, directory, 5, "Knee", "Angle", "Degrees");
end

% Incline 10
if false
    plot_sorted_data(i10_A_t, speed_filter, directory, 10, "Ankle", "Torque", "Unkown Units");
    plot_sorted_data(i10_A_a, speed_filter, directory, 10, "Ankle", "Angle", "Degrees");
    plot_sorted_data(i10_K_t, speed_filter, directory, 10, "Knee", "Torque", "Unkown Units");
    plot_sorted_data(i10_K_a, speed_filter, directory, 10, "Knee", "Angle", "Degrees");
end

%% Export to a PDF
if true
    figs = findall(groot, 'Type', 'figure');
    pdf_file_name = 'Torque and Angle Plots, 1.2 Speed.pdf';
    
    if isfile(pdf_file_name)
        delete(pdf_file_name)
    end
    
    for i = 1 : length(figs)
        if i == 1 % First page creates the PDF
            exportgraphics(figs(i), pdf_file_name,'ContentType', 'vector');
        else
            exportgraphics(figs(i), pdf_file_name, 'ContentType', 'vector', 'Append', true);
        end
    end
end

%% Helper Functions
function plot_sorted_data(joint_data, speed_filter, directory, incline, joint_type, metric, units)
% 1. Sorts data into vectors by cadence and normalized stride length
    % uses sort_a_vector function
    % eliminates zero/invalid entries

% 2. Produces a 2-column matrix with:
%   mean vector (column 1)
%   standard deviation vector (column 2)

% Sorting Codes:
    % 1: Sort by Cadence
    % 2: Sort by Normalized Stride Length
    % 3: Sort by Calculated Speeds
    % 4: Sort by Recorded Speeds

% Filtering process
if speed_filter
    if speed_filter == 0.8
        filtered_joint_data = sort_a_vector(joint_data, 0.9, 0.7, 4);
    elseif speed_filter == 1
        filtered_joint_data = sort_a_vector(joint_data, 1.1, 0.9, 4);
    elseif speed_filter == 1.2
        filtered_joint_data = sort_a_vector(joint_data, 1.3, 1.1, 4);
    end
else
    filtered_joint_data = joint_data;
end

% Cadence: 35 - 70
sorting_code = 1;
cadence{2, 5} = 0;
addpath(directory + 'computation_functions/');
cadence(1, :) =  {get_mean_std_vector(sort_a_vector(filtered_joint_data, 45, 35, sorting_code)), ...
                  get_mean_std_vector(sort_a_vector(filtered_joint_data, 50, 45, sorting_code)), ...
                  get_mean_std_vector(sort_a_vector(filtered_joint_data, 55, 50, sorting_code)), ...
                  get_mean_std_vector(sort_a_vector(filtered_joint_data, 60, 55, sorting_code)), ...
                  get_mean_std_vector(sort_a_vector(filtered_joint_data, 70, 60, sorting_code))};
cadence(2, :) = {"35 - 45", "45 - 50", "50 - 55", "55 - 60", "60 - 70"};

% Normalized Stride Length: 0.7 - 2
sorting_code = 2;
norm_SL{2, 5} = 0;
addpath(directory + 'computation_functions/');
norm_SL(1, :) =   {get_mean_std_vector(sort_a_vector(filtered_joint_data, 1, 0.7, sorting_code)), ...
                   get_mean_std_vector(sort_a_vector(filtered_joint_data, 1.15, 1, sorting_code)), ...
                   get_mean_std_vector(sort_a_vector(filtered_joint_data, 1.25, 1.15, sorting_code)), ...
                   get_mean_std_vector(sort_a_vector(filtered_joint_data, 1.4, 1.25, sorting_code)), ...
                   get_mean_std_vector(sort_a_vector(filtered_joint_data, 2, 1.4, sorting_code))};
norm_SL(2, :) = {"0.7 - 1", "1 - 1.15", "1.15 - 1.25", "1.25 - 1.4", "1.4 - 2"};

% Calculated Speeds: 0.66 - 1.35
sorting_code = 3;
calculated_speed{2, 7} = 0;
addpath(directory + 'computation_functions/');
calculated_speed(1, :) = {get_mean_std_vector(sort_a_vector(filtered_joint_data, 0.75, 0.66, sorting_code)), ...
                          get_mean_std_vector(sort_a_vector(filtered_joint_data, 0.85, 0.75, sorting_code)), ...
                          get_mean_std_vector(sort_a_vector(filtered_joint_data, 0.95, 0.85, sorting_code)), ...
                          get_mean_std_vector(sort_a_vector(filtered_joint_data, 1.05, 0.95, sorting_code)), ...
                          get_mean_std_vector(sort_a_vector(filtered_joint_data, 1.15, 1.05, sorting_code)), ...
                          get_mean_std_vector(sort_a_vector(filtered_joint_data, 1.25, 1.15, sorting_code)), ...
                          get_mean_std_vector(sort_a_vector(filtered_joint_data, 1.35, 1.25, sorting_code))};
calculated_speed(2, :) = {"0.66 - 0.75", "0.75 - 0.85", "0.85 - 0.95", "0.95 - 1.05", "1.05 - 1.15", "1.15 - 1.25", "1.25 - 1.35"};

% Recorded Speeds: 0.8, 1, 1.2
sorting_code = 4;
recorded_speed{2, 3} = 0;
addpath(directory + 'computation_functions/');
recorded_speed(1, :) = {get_mean_std_vector(sort_a_vector(filtered_joint_data, 0.9, 0.7, sorting_code)), ...
                        get_mean_std_vector(sort_a_vector(filtered_joint_data, 1.1, 0.9, sorting_code)), ...
                        get_mean_std_vector(sort_a_vector(filtered_joint_data, 1.3, 1.1, sorting_code))};
recorded_speed(2, :) = {"0.8", "1", "1.2"};


% 3. Plot the vectors
    colors = ['r' 'g' 'w' 'c' 'm' 'y' 'b'];
    figure;

    if speed_filter
        tiledlayout(1, 3);
    else
        tiledlayout(2, 2);
    end
    
    % --- Plot 1: Cadence ---
    nexttile;
    hold on;
    legend_entries = {};

    for bucket_number = 1 : 5
        if ~isempty(cadence{1, bucket_number}) && (cadence{1, bucket_number}(3,3) > 50)
            vector_size = size(cadence{1, bucket_number}, 1) - 2;
            x = linspace(0, 100, vector_size);
            y = cadence{1, bucket_number}(3 : end, 1)';
            error = cadence{1, bucket_number}(3 : end, 2)';

            addpath(directory + 'plotting&testing_functions/');
            plotShaded(x, [y + error; y; y - error], colors(bucket_number), '-', 1);
            legend_entries{end + 1} = cadence{2, bucket_number} + ", " + cadence{1, bucket_number}(3, 3) + " T";
        end
    end
    
    title(joint_type + " " + metric + " vs Cadence (steps per minute)");
    xlabel('Gait Percentage');
    ylabel(metric + " (" + units + ")");
    legend(legend_entries,'location','best');
    grid on;
    hold off;
    
    % --- Plot 2: Normalized Stride Length ---
    nexttile;
    hold on;
    legend_entries = {};

    for bucket_number = 1 : 5
        if ~isempty(norm_SL{1, bucket_number}) && (norm_SL{1, bucket_number}(3,3) > 50)
            vector_size = size(norm_SL{1, bucket_number}, 1) - 2;
            x = linspace(0, 100, vector_size);
            y = norm_SL{1, bucket_number}(3 : end, 1)';
            error = norm_SL{1, bucket_number}(3 : end, 2)';

            addpath(directory + 'plotting&testing_functions/');
            plotShaded(x, [y + error; y; y - error], colors(bucket_number), '-', 1);
            legend_entries{end + 1} = norm_SL{2, bucket_number} + ", " + norm_SL{1, bucket_number}(3, 3) + " T";
        end
    end

    title(joint_type + " " + metric + " vs Normalized Stride Length");
    xlabel('Gait Percentage');
    ylabel(metric + " (" + units + ")");
    legend(legend_entries, 'location','best');
    grid on;
    hold off;
    
    % --- Plot 3: Calculated Speed ---
    nexttile;
    hold on;
    legend_entries = {};

    for bucket_number = 1 : 7
        if ~isempty(calculated_speed{1, bucket_number}) % && (calculated_speed{1, bucket_number}(3,3) > 50)
            vector_size = size(calculated_speed{1, bucket_number}, 1) - 2;
            x = linspace(0, 100, vector_size);
            y = calculated_speed{1, bucket_number}(3 : end, 1)';
            error = calculated_speed{1, bucket_number}(3 : end, 2)';

            addpath(directory + 'plotting&testing_functions/');
            plotShaded(x, [y + error; y; y - error], colors(bucket_number), '-', 1);
            legend_entries{end + 1} = calculated_speed{2, bucket_number} + ", " + calculated_speed{1, bucket_number}(3, 3) + " T";
        end
    end
    
    title(joint_type + " " + metric + " vs Calculated Speed (m/s)");
    xlabel('Gait Percentage');
    ylabel(metric + " (" + units + ")");
    legend(legend_entries, 'location','best');
    grid on;
    hold off;

    % --- Plot 4: Recorded Speed ---
    if ~speed_filter
        nexttile;
        hold on;
        legend_entries = {};
    
        for bucket_number = 1 : 3
            if ~isempty(recorded_speed{1, bucket_number})
                vector_size = size(recorded_speed{1, bucket_number}, 1) - 2;
                x = linspace(0, 100, vector_size);
                y = recorded_speed{1, bucket_number}(3 : end, 1)';
                error = recorded_speed{1, bucket_number}(3 : end, 2)';
    
                addpath(directory + 'plotting&testing_functions/');
                plotShaded(x, [y + error; y; y - error], colors(bucket_number), '-', 1);
                legend_entries{end + 1} = recorded_speed{2, bucket_number} + ", " + recorded_speed{1, bucket_number}(3, 3) + " T";
            end
        end
        
        title(joint_type + " " + metric + " vs Recorded Speed (m/s)");
        xlabel('Gait Percentage');
        ylabel(metric + " (" + units + ")");
        legend(legend_entries,'location','best');
        grid on;
        hold off;
    end
    
    % --- Title ---
    if speed_filter
        sgtitle(joint_type + " " + metric + ", Speed " + speed_filter + " m/s, Incline " + incline, 'FontSize', 16, 'FontWeight', 'bold');
    else
        sgtitle(joint_type + " " + metric + ", All Speeds, Incline " + incline, 'FontSize', 16, 'FontWeight', 'bold');
    end
end
