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

% Call Functions
incline_vector = inclines(1, :);
addpath(directory + 'computation_functions/');
[in10_ankle, in10_knee, ignore1, ignore2] = get_formatted_ankle_knee_data(dataBase, directory, subjects, speeds, legLengths, incline_vector, force_threshold);
plot_sorted_data(in10_ankle, in10_knee, -10, directory);

incline_vector = inclines(2, :);
addpath(directory + 'computation_functions/');
[in5_ankle, in5_knee, ignore3, ignore4] = get_formatted_ankle_knee_data(dataBase, directory, subjects, speeds, legLengths, incline_vector, force_threshold);
    % in5_ankle at column 782 is completely NaN in the original data. It is NOT
    % a fault of the code.
plot_sorted_data(in5_ankle, in5_knee, -5, directory);

incline_vector = inclines(3, :);
addpath(directory + 'computation_functions/');
[i0_ankle, i0_knee, ignore5, ignore6] = get_formatted_ankle_knee_data(dataBase, directory, subjects, speeds, legLengths, incline_vector, force_threshold);
plot_sorted_data(i0_ankle, i0_knee, 0, directory);

incline_vector = inclines(4, :);
addpath(directory + 'computation_functions/');
[i5_ankle, i5_knee, ignore7, ignore8] = get_formatted_ankle_knee_data(dataBase, directory, subjects, speeds, legLengths, incline_vector, force_threshold);
plot_sorted_data(i5_ankle, i5_knee, 5, directory);

incline_vector = inclines(5, :);
addpath(directory + 'computation_functions/');
[i10_ankle, i10_knee, ignore9, ignore10] = get_formatted_ankle_knee_data(dataBase, directory, subjects, speeds, legLengths, incline_vector, force_threshold);
plot_sorted_data(i10_ankle, i10_knee, 10, directory);

%% Helper Functions

function plot_sorted_data(ankle_data, knee_data, incline, directory)
% 1. Sorts data into vectors by cadence and normalized stride length
    % uses sort_a_vector function
    % eliminates zero/invalid entries

% 2. Produces a 2-column matrix with:
%   mean vector (column 1)
%   standard deviation vector (column 2)

sorting_code = "c";
ankle_cadence{2, 4} = 0;

addpath(directory + 'computation_functions/');
ankle_cadence(1, :) =  {get_mean_std_vector(sort_a_vector(ankle_data, 40, 30, sorting_code)), ...
                        get_mean_std_vector(sort_a_vector(ankle_data, 50, 40, sorting_code)), ...
                        get_mean_std_vector(sort_a_vector(ankle_data, 60, 50, sorting_code)), ...
                        get_mean_std_vector(sort_a_vector(ankle_data, 70, 60, sorting_code))};
ankle_cadence(2, :) = {"30 - 40", "40 - 50", "50 - 60", "60 - 70"};


knee_cadence{2, 4} = 0;
addpath(directory + 'computation_functions/');
knee_cadence(1, :) =   {get_mean_std_vector(sort_a_vector(knee_data, 40, 30, sorting_code)), ...
                        get_mean_std_vector(sort_a_vector(knee_data, 50, 40, sorting_code)), ...
                        get_mean_std_vector(sort_a_vector(knee_data, 60, 50, sorting_code)), ...
                        get_mean_std_vector(sort_a_vector(knee_data, 70, 60, sorting_code))};
knee_cadence(2, :) = {"30 - 40", "40 - 50", "50 - 60", "60 - 70"};


sorting_code = "nsl";
ankle_normalizedStrideLength{2, 6} = 0;
addpath(directory + 'computation_functions/');
ankle_normalizedStrideLength(1, :) =   {get_mean_std_vector(sort_a_vector(ankle_data, 0.9, 0.7, sorting_code)), ...
                                        get_mean_std_vector(sort_a_vector(ankle_data, 1.1, 0.9, sorting_code)), ...
                                        get_mean_std_vector(sort_a_vector(ankle_data, 1.3, 1.1, sorting_code)), ...
                                        get_mean_std_vector(sort_a_vector(ankle_data, 1.5, 1.3, sorting_code)), ...
                                        get_mean_std_vector(sort_a_vector(ankle_data, 1.7, 1.5, sorting_code)), ...
                                        get_mean_std_vector(sort_a_vector(ankle_data, 1.9, 1.7, sorting_code))};
ankle_normalizedStrideLength(2, :) = {"0.7 - 0.9", "0.9 - 1.1", "1.1 - 1.3", "1.3 - 1.5", "1.5 - 1.7", "1.7 - 1.9"};

knee_normalizedStrideLength{2, 6} = 0;
addpath(directory + 'computation_functions/');
knee_normalizedStrideLength(1, :) =    {get_mean_std_vector(sort_a_vector(knee_data, 0.9, 0.7, sorting_code)), ...
                                        get_mean_std_vector(sort_a_vector(knee_data, 1.1, 0.9, sorting_code)), ...
                                        get_mean_std_vector(sort_a_vector(knee_data, 1.3, 1.1, sorting_code)), ...
                                        get_mean_std_vector(sort_a_vector(knee_data, 1.5, 1.3, sorting_code)), ...
                                        get_mean_std_vector(sort_a_vector(knee_data, 1.7, 1.5, sorting_code)), ...
                                        get_mean_std_vector(sort_a_vector(knee_data, 1.9, 1.7, sorting_code))};
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

            addpath(directory + 'plotting&testing_functions/');
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

            addpath(directory + 'plotting&testing_functions/');
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

            addpath(directory + 'plotting&testing_functions/');
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

            addpath(directory + 'plotting&testing_functions/');
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
