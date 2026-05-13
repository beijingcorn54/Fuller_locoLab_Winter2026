clear;
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

%% Call Functions

% Incline -10
incline_vector = inclines(1, :);
addpath(directory + 'computation_functions/');
[in10_ankle, in10_knee] = get_formatted_ankle_knee_data(dataBase, directory, subjects, speeds, legLengths, incline_vector, force_threshold);

graphTitle = "Ankle Torque";
plot_sorted_data(in10_ankle, -10, directory, graphTitle);
graphTitle = "Knee Torque";
plot_sorted_data(in10_knee, -10, directory, graphTitle);

% Incline -5
incline_vector = inclines(2, :);
addpath(directory + 'computation_functions/');
[in5_ankle, in5_knee] = get_formatted_ankle_knee_data(dataBase, directory, subjects, speeds, legLengths, incline_vector, force_threshold);

graphTitle = "Ankle Torque";
plot_sorted_data(in5_ankle, -5, directory, graphTitle);
graphTitle = "Knee Torque";
plot_sorted_data(in5_knee, -5, directory, graphTitle);

% Incline 0
incline_vector = inclines(3, :);
addpath(directory + 'computation_functions/');
[i0_ankle, i0_knee] = get_formatted_ankle_knee_data(dataBase, directory, subjects, speeds, legLengths, incline_vector, force_threshold);

graphTitle = "Ankle Torque";
plot_sorted_data(i0_ankle, 0, directory, graphTitle);
graphTitle = "Knee Torque";
plot_sorted_data(i0_knee, 0, directory, graphTitle);

% Incline 5
incline_vector = inclines(4, :);
addpath(directory + 'computation_functions/');
[i5_ankle, i5_knee] = get_formatted_ankle_knee_data(dataBase, directory, subjects, speeds, legLengths, incline_vector, force_threshold);

graphTitle = "Ankle Torque";
plot_sorted_data(i5_ankle, 5, directory, graphTitle);
graphTitle = "Knee Torque";
plot_sorted_data(i5_knee, 5, directory, graphTitle);

% Incline 10
incline_vector = inclines(5, :);
addpath(directory + 'computation_functions/');
[i10_ankle, i10_knee] = get_formatted_ankle_knee_data(dataBase, directory, subjects, speeds, legLengths, incline_vector, force_threshold);

graphTitle = "Ankle Torque";
plot_sorted_data(i10_ankle, 10, directory, graphTitle);
graphTitle = "Knee Torque";
plot_sorted_data(i10_knee, 10, directory, graphTitle);

%% Helper Functions

function plot_sorted_data(joint_data, incline, directory, graphTitle)
% 1. Sorts data into vectors by cadence and normalized stride length
    % uses sort_a_vector function
    % eliminates zero/invalid entries

% 2. Produces a 2-column matrix with:
%   mean vector (column 1)
%   standard deviation vector (column 2)

sorting_code = "c";
cadence{2, 4} = 0;
addpath(directory + 'computation_functions/');
cadence(1, :) =  {get_mean_std_vector(sort_a_vector(joint_data, 40, 30, sorting_code)), ...
                  get_mean_std_vector(sort_a_vector(joint_data, 50, 40, sorting_code)), ...
                  get_mean_std_vector(sort_a_vector(joint_data, 60, 50, sorting_code)), ...
                  get_mean_std_vector(sort_a_vector(joint_data, 70, 60, sorting_code))};
cadence(2, :) = {"30 - 40", "40 - 50", "50 - 60", "60 - 70"};

sorting_code = "nsl";
norm_SL{2, 6} = 0;
addpath(directory + 'computation_functions/');
norm_SL(1, :) =   {get_mean_std_vector(sort_a_vector(joint_data, 0.9, 0.7, sorting_code)), ...
                   get_mean_std_vector(sort_a_vector(joint_data, 1.1, 0.9, sorting_code)), ...
                   get_mean_std_vector(sort_a_vector(joint_data, 1.3, 1.1, sorting_code)), ...
                   get_mean_std_vector(sort_a_vector(joint_data, 1.5, 1.3, sorting_code)), ...
                   get_mean_std_vector(sort_a_vector(joint_data, 1.7, 1.5, sorting_code)), ...
                   get_mean_std_vector(sort_a_vector(joint_data, 1.9, 1.7, sorting_code))};
norm_SL(2, :) = {"0.7 - 0.9", "0.9 - 1.1", "1.1 - 1.3", "1.3 - 1.5", "1.5 - 1.7", "1.7 - 1.9"};

sorting_code = "s";
ground_speed{2, 3} = 0;
addpath(directory + 'computation_functions/');
ground_speed(1, :) =  {get_mean_std_vector(sort_a_vector(joint_data, 0.9, 0.7, sorting_code)), ...
                       get_mean_std_vector(sort_a_vector(joint_data, 1.1, 0.9, sorting_code)), ...
                       get_mean_std_vector(sort_a_vector(joint_data, 1.3, 1.1, sorting_code))};
ground_speed(2, :) = {"0.7 - 0.9", "0.9 - 1.1", "1.1 - 1.3"};


% 3. Plot the vectors
    colors = ['r' 'g' 'w' 'c' 'm' 'y'];
    figure;
    tiledlayout(3, 1);  % 2 rows, 2 columns
    
    % --- Plot 1: Cadence ---
    nexttile;
    hold on;
    legend_entries = {};

    for bucket_number = 1 : 4
        if ~isempty(cadence{1, bucket_number}) % && (ankle_cadence{1, bucket_number}(3,3) > 100)
            vector_size = size(cadence{1, bucket_number}, 1) - 2;
            x = linspace(0, 100, vector_size);
            y = cadence{1, bucket_number}(3 : end, 1)';
            error = cadence{1, bucket_number}(3 : end, 2)';
            plotShaded(x, [y + error; y; y - error], colors(bucket_number), '-', 1);
            legend_entries{end + 1} = cadence{2, bucket_number} + ", " + cadence{1, bucket_number}(3, 3) + " T";
        end
    end
    
    title(graphTitle + " vs Cadence (steps per minute)");
    xlabel('Gait Percentage');
    ylabel('Torque');
    legend(legend_entries,'location','best');
    grid on;
    hold off;
    
    % --- Plot 2: Normalized Stride Length ---
    nexttile;
    hold on;
    legend_entries = {};

    for bucket_number = 1 : 6
        if ~isempty(norm_SL{1, bucket_number})
            vector_size = size(norm_SL{1, bucket_number}, 1) - 2;
            x = linspace(0, 100, vector_size);
            y = norm_SL{1, bucket_number}(3 : end, 1)';
            error = norm_SL{1, bucket_number}(3 : end, 2)';
            plotShaded(x, [y + error; y; y - error], colors(bucket_number), '-', 1);
            legend_entries{end + 1} = norm_SL{2, bucket_number} + ", " + norm_SL{1, bucket_number}(3, 3) + " T";
        end
    end

    title(graphTitle + " vs Normalized Stride Length");
    xlabel('Gait Percentage');
    ylabel('Torque');
    legend(legend_entries, 'location','best');
    grid on;
    hold off;
    
    % --- Plot 3: Ground Speed ---
    nexttile;
    hold on;
    legend_entries = {};

    for bucket_number = 1 : 3
        if ~isempty(ground_speed{1, bucket_number})
            vector_size = size(ground_speed{1, bucket_number}, 1) - 2;
            x = linspace(0, 100, vector_size);
            y = ground_speed{1, bucket_number}(3 : end, 1)';
            error = ground_speed{1, bucket_number}(3 : end, 2)';
            plotShaded(x, [y + error; y; y - error], colors(bucket_number), '-', 1);
            legend_entries{end + 1} = ground_speed{2, bucket_number} + ", " + ground_speed{1, bucket_number}(3, 3) + " T";
        end
    end
    
    title(graphTitle + " vs Ground Speed (m/s)");
    xlabel('Gait Percentage');
    ylabel('Torque');
    legend(legend_entries, 'location','best');
    grid on;
    hold off;
    
    % --- Title ---
    sgtitle(graphTitle + ", Incline " + incline, 'FontSize', 16, 'FontWeight', 'bold');
   
end