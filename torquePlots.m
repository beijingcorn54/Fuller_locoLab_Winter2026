clear;
close all;

% Load in Data

directory = "/Users/kefuller/Fuller_Locolab_Winter2026/";
dataBase = load(directory + "locolab_files/Normalized.mat").Normalized;

% Variables
subjects = ["AB01", "AB02", "AB03", "AB04", "AB05", "AB06", "AB07", "AB08", "AB09", "AB10"];
legLengths = [0.951, 0.921, 0.99, 0.96, 0.766, 0.918, 0.859, 0.991, 0.940, 0.815];
speeds = ["s0x8", -0.8; "s1", -1; "s1x2", -1.2];
inclines = ["i10", 10; "i5", 5; "i0", 0; "in5", -5; "in10", -10];

threshold = 25;
marker = "LHEE";

plot_sorted_torques(1, dataBase, speeds, inclines, subjects, legLengths, marker, threshold, directory)
plot_sorted_torques(2, dataBase, speeds, inclines, subjects, legLengths, marker, threshold, directory)
plot_sorted_torques(3, dataBase, speeds, inclines, subjects, legLengths, marker, threshold, directory)
plot_sorted_torques(4, dataBase, speeds, inclines, subjects, legLengths, marker, threshold, directory)
plot_sorted_torques(5, dataBase, speeds, inclines, subjects, legLengths, marker, threshold, directory)

function plot_sorted_torques(i_incline, dataBase, speeds, inclines, subjects, legLengths, marker, threshold, directory)
% Establish variables based on bin sizes of cadence and normalized stride lengths
    % Normalized Stride Length Buckets: 0.7 - 1.9
    % Cadence Buckets: 35 - 70
initialization_vector = zeros(450, 1);
kneeTorque_c40 = initialization_vector;
kneeTorque_c45 = initialization_vector;
kneeTorque_c50 = initialization_vector;
kneeTorque_c55 = initialization_vector;
kneeTorque_c60 = initialization_vector;
kneeTorque_c65 = initialization_vector;
kneeTorque_c70 = initialization_vector;
kneeTorque_nsl0x9 = initialization_vector;
kneeTorque_nsl1x1 = initialization_vector;
kneeTorque_nsl1x3 = initialization_vector;
kneeTorque_nsl1x5 = initialization_vector;
kneeTorque_nsl1x7 = initialization_vector;
kneeTorque_nsl1x9 = initialization_vector;

ankleTorque_c40 = initialization_vector;
ankleTorque_c45 = initialization_vector;
ankleTorque_c50 = initialization_vector;
ankleTorque_c55 = initialization_vector;
ankleTorque_c60 = initialization_vector;
ankleTorque_c65 = initialization_vector;
ankleTorque_c70 = initialization_vector;
ankleTorque_nsl0x9 = initialization_vector;
ankleTorque_nsl1x1 = initialization_vector;
ankleTorque_nsl1x3 = initialization_vector;
ankleTorque_nsl1x5 = initialization_vector;
ankleTorque_nsl1x7 = initialization_vector;
ankleTorque_nsl1x9 = initialization_vector;

% Extract Data
for i_speed = 1 : 3
    for i_subject = 1 : 10
        data = dataBase.(subjects(i_subject)).Walk.(speeds(i_speed, 1)).(inclines(i_incline, 1));
        data_kneeTorque = data.jointMoments.KneeMoment;
        data_ankleTorque = data.jointMoments.AnkleMoment;
        
        % Extract cadence and normalized stride length data
        incline_val = str2double(inclines(i_incline, 2));
        speed_val = str2double(speeds(i_speed, 2));
        
        addpath(directory + 'computation_functions/');
        cadences = find_cadence(data, marker);
        addpath(directory + 'computation_functions/');
        n_stride_lengths = find_normalized_strideLengths(data, threshold, speed_val, marker, incline_val, legLengths(i_subject), directory);  
        
        % Extract knee and ankle torques
        cadences_size = size(cadences);
        left_trials = 1 : cadences_size(2);
        this_x_kneeTorque = squeeze(data_kneeTorque(:, 1, left_trials));
        this_y_kneeTorque = squeeze(data_kneeTorque(:, 2, left_trials));
        this_z_kneeTorque = squeeze(data_kneeTorque(:, 3, left_trials));
        this_x_ankleTorque = squeeze(data_ankleTorque(:, 1, left_trials));
        this_y_ankleTorque = squeeze(data_ankleTorque(:, 2, left_trials));
        this_z_ankleTorque = squeeze(data_ankleTorque(:, 3, left_trials));
        
        for i = left_trials
            % Sorting torque vectors by cadence
            if cadences(i) <= 40
                kneeTorque_c40 = [kneeTorque_c40, [this_x_kneeTorque; this_y_kneeTorque; this_z_kneeTorque]];
                ankleTorque_c40 = [ankleTorque_c40, [this_x_ankleTorque; this_y_ankleTorque; this_z_ankleTorque]];
            elseif cadences(i) <= 45
                kneeTorque_c45 = [kneeTorque_c45, [this_x_kneeTorque; this_y_kneeTorque; this_z_kneeTorque]];
                ankleTorque_c45 = [ankleTorque_c45, [this_x_ankleTorque; this_y_ankleTorque; this_z_ankleTorque]];
            elseif cadences(i) <= 50
                kneeTorque_c50 = [kneeTorque_c50, [this_x_kneeTorque; this_y_kneeTorque; this_z_kneeTorque]];
                ankleTorque_c50 = [ankleTorque_c50, [this_x_ankleTorque; this_y_ankleTorque; this_z_ankleTorque]];
            elseif cadences(i) <= 55
                kneeTorque_c55 = [kneeTorque_c55, [this_x_kneeTorque; this_y_kneeTorque; this_z_kneeTorque]];
                ankleTorque_c55 = [ankleTorque_c55, [this_x_ankleTorque; this_y_ankleTorque; this_z_ankleTorque]];
            elseif cadences(i) <= 60
                kneeTorque_c60 = [kneeTorque_c60, [this_x_kneeTorque; this_y_kneeTorque; this_z_kneeTorque]];
                ankleTorque_c60 = [ankleTorque_c60, [this_x_ankleTorque; this_y_ankleTorque; this_z_ankleTorque]];
            elseif cadences(i) <= 65
                kneeTorque_c65 = [kneeTorque_c65, [this_x_kneeTorque; this_y_kneeTorque; this_z_kneeTorque]];
                ankleTorque_c65 = [ankleTorque_c65, [this_x_ankleTorque; this_y_ankleTorque; this_z_ankleTorque]];
            else
                kneeTorque_c70 = [kneeTorque_c70, [this_x_kneeTorque; this_y_kneeTorque; this_z_kneeTorque]];
                ankleTorque_c70 = [ankleTorque_c70, [this_x_ankleTorque; this_y_ankleTorque; this_z_ankleTorque]];
            end
        
            % Sorting torque vectors by normalized stride length
            if n_stride_lengths(i) <= 0.9
                kneeTorque_nsl0x9 = [kneeTorque_nsl0x9, [this_x_kneeTorque; this_y_kneeTorque; this_z_kneeTorque]];
                ankleTorque_nsl0x9 = [ankleTorque_nsl0x9, [this_x_ankleTorque; this_y_ankleTorque; this_z_ankleTorque]];
            elseif n_stride_lengths(i) <= 1.1
                kneeTorque_nsl1x1 = [kneeTorque_nsl1x1, [this_x_kneeTorque; this_y_kneeTorque; this_z_kneeTorque]];
                ankleTorque_nsl1x1 = [ankleTorque_nsl1x1, [this_x_ankleTorque; this_y_ankleTorque; this_z_ankleTorque]];
            elseif n_stride_lengths(i) <= 1.3
                kneeTorque_nsl1x3 = [kneeTorque_nsl1x3, [this_x_kneeTorque; this_y_kneeTorque; this_z_kneeTorque]];
                ankleTorque_nsl1x3 = [ankleTorque_nsl1x3, [this_x_ankleTorque; this_y_ankleTorque; this_z_ankleTorque]];
            elseif n_stride_lengths(i) <= 1.5
                kneeTorque_nsl1x5 = [kneeTorque_nsl1x5, [this_x_kneeTorque; this_y_kneeTorque; this_z_kneeTorque]];
                ankleTorque_nsl1x5 = [ankleTorque_nsl1x5, [this_x_ankleTorque; this_y_ankleTorque; this_z_ankleTorque]];
            elseif n_stride_lengths(i) <= 1.7
                kneeTorque_nsl1x7 = [kneeTorque_nsl1x7, [this_x_kneeTorque; this_y_kneeTorque; this_z_kneeTorque]];
                ankleTorque_nsl1x7 = [ankleTorque_nsl1x7, [this_x_ankleTorque; this_y_ankleTorque; this_z_ankleTorque]];
            else
                kneeTorque_nsl1x9 = [kneeTorque_nsl1x9, [this_x_kneeTorque; this_y_kneeTorque; this_z_kneeTorque]];
                ankleTorque_nsl1x9 = [ankleTorque_nsl1x9, [this_x_ankleTorque; this_y_ankleTorque; this_z_ankleTorque]];
        
            end
        end
    end
end

% Resize vectors: Averaging and Standard Deviations
vector_size = 450;
kneeTorque_c40 = vector_averager(kneeTorque_c40(:, (2 : end)), vector_size);
kneeTorque_c45 = vector_averager(kneeTorque_c45(:, (2 : end)), vector_size);
kneeTorque_c50 = vector_averager(kneeTorque_c50(:, (2 : end)), vector_size);
kneeTorque_c55 = vector_averager(kneeTorque_c55(:, (2 : end)), vector_size);
kneeTorque_c60 = vector_averager(kneeTorque_c60(:, (2 : end)), vector_size);
kneeTorque_c65 = vector_averager(kneeTorque_c65(:, (2 : end)), vector_size);
kneeTorque_c70 = vector_averager(kneeTorque_c70(:, (2 : end)), vector_size);
ankleTorque_c40 = vector_averager(ankleTorque_c40(:, (2 : end)), vector_size);
ankleTorque_c45 = vector_averager(ankleTorque_c45(:, (2 : end)), vector_size);
ankleTorque_c50 = vector_averager(ankleTorque_c50(:, (2 : end)), vector_size);
ankleTorque_c55 = vector_averager(ankleTorque_c55(:, (2 : end)), vector_size);
ankleTorque_c60 = vector_averager(ankleTorque_c60(:, (2 : end)), vector_size);
ankleTorque_c65 = vector_averager(ankleTorque_c65(:, (2 : end)), vector_size);
ankleTorque_c70 = vector_averager(ankleTorque_c70(:, (2 : end)), vector_size);

kneeTorque_nsl0x9 = vector_averager(kneeTorque_nsl0x9(:, (2 : end)), vector_size);
kneeTorque_nsl1x1 = vector_averager(kneeTorque_nsl1x1(:, (2 : end)), vector_size);
kneeTorque_nsl1x3 = vector_averager(kneeTorque_nsl1x3(:, (2 : end)), vector_size);
kneeTorque_nsl1x5 = vector_averager(kneeTorque_nsl1x5(:, (2 : end)), vector_size);
kneeTorque_nsl1x7 = vector_averager(kneeTorque_nsl1x7(:, (2 : end)), vector_size);
kneeTorque_nsl1x9 = vector_averager(kneeTorque_nsl1x9(:, (2 : end)), vector_size);
ankleTorque_nsl0x9 = vector_averager(ankleTorque_nsl0x9(:, (2 : end)), vector_size);
ankleTorque_nsl1x1 = vector_averager(ankleTorque_nsl1x1(:, (2 : end)), vector_size);
ankleTorque_nsl1x3 = vector_averager(ankleTorque_nsl1x3(:, (2 : end)), vector_size);
ankleTorque_nsl1x5 = vector_averager(ankleTorque_nsl1x5(:, (2 : end)), vector_size);
ankleTorque_nsl1x7 = vector_averager(ankleTorque_nsl1x7(:, (2 : end)), vector_size);
ankleTorque_nsl1x9 = vector_averager(ankleTorque_nsl1x9(:, (2 : end)), vector_size);

% Call Plotting Helper Function
cadence_torque_scatterplot(kneeTorque_c40, kneeTorque_c45, kneeTorque_c50, kneeTorque_c55, ...
    kneeTorque_c60, kneeTorque_c65, kneeTorque_c70, 1, inclines(i_incline, 1), "Knee");
cadence_torque_scatterplot(ankleTorque_c40, ankleTorque_c45, ankleTorque_c50, ankleTorque_c55, ...
    ankleTorque_c60, ankleTorque_c65, ankleTorque_c70, 1, inclines(i_incline, 1), "Ankle");

normStride_torque_scatterplot(kneeTorque_nsl0x9, kneeTorque_nsl1x1, kneeTorque_nsl1x3, ...
    kneeTorque_nsl1x5, kneeTorque_nsl1x7, kneeTorque_nsl1x9, 1, inclines(i_incline, 1), "Knee");
normStride_torque_scatterplot(ankleTorque_nsl0x9, ankleTorque_nsl1x1, ankleTorque_nsl1x3, ...
    ankleTorque_nsl1x5, ankleTorque_nsl1x7, ankleTorque_nsl1x9, 1, inclines(i_incline, 1), "Ankle");
end

% LEGEND NEEDS WORK
function cadence_torque_scatterplot(c40, c45, c50, c55, c60, c65, c70, dimension, incline, torqueType)
    legend_labels = [];
    range = 1 : 450;
    x_axis = 1 : 450;
    dimension_label = "XYZ";
    if dimension == 1
        range = 1 : 95;
        x_axis = 1 : 95;
        dimension_label = "X";
    elseif dimension == 2
        range = 151 : 300;
        x_axis = 1 : 150;
        dimension_label = "Y";
    elseif dimension == 3
        range = 301 : 450;
        x_axis = 1 : 150;
        dimension_label = "Z";
    end

    figure();
    title("Incline " + incline + " Cadence, " + dimension_label + " Dimensional " + torqueType + " Torque");
    hold on;
    if mean(c40) >= -1000
        legend_labels = [legend_labels, "35 - 40 steps/min", "", ""];
        plotting_helper(x_axis, c40(range, 1), c40(range, 2), dimension_label);
    end
    if mean(c45) >= -1000
        legend_labels = [legend_labels, "40 - 45 steps/min", "", ""];
        plotting_helper(x_axis, c45(range, 1), c45(range, 2), dimension_label);
    end
    if mean(c50) >= -1000
        legend_labels = [legend_labels, "45 - 50 steps/min", "", ""];
        plotting_helper(x_axis, c50(range, 1), c50(range, 2), dimension_label);
    end
    if mean(c55) >= -1000
        legend_labels = [legend_labels, "50 - 55 steps/min", "", ""];
        plotting_helper(x_axis, c55(range, 1), c55(range, 2), dimension_label);
    end
    if mean(c60) >= -1000
        legend_labels = [legend_labels, "55 - 60 steps/min", "", ""];
        plotting_helper(x_axis, c60(range, 1), c60(range, 2), dimension_label);
    end
    if mean(c65) >= -1000
        legend_labels = [legend_labels, "60 - 65 steps/min", "", ""];
        plotting_helper(x_axis, c65(range, 1), c65(range, 2), dimension_label);
    end
    if mean(c70) >= -1000
        legend_labels = [legend_labels, "65 - 70 steps/min", "", ""];
        plotting_helper(x_axis, c70(range, 1), c70(range, 2), dimension_label);
    end
    legend(legend_labels);
end

% LEGEND NEEDS WORK
function normStride_torque_scatterplot(n0x9, n1x1, n1x3, n1x5, n1x7, n1x9, dimension, incline, torqueType)
    legend_labels = [];
    range = 1 : 450;
    x_axis = 1 : 450;
    dimension_label = "XYZ";
    if dimension == 1
        range = 1 : 95;
        x_axis = 1 : 95;
        dimension_label = "X";
    elseif dimension == 2
        range = 151 : 300;
        x_axis = 1 : 150;
        dimension_label = "Y";
    elseif dimension == 3
        range = 301 : 450;
        x_axis = 1 : 150;
        dimension_label = "Z";
    end

    figure();
    title("Incline " + incline + " Normalized Stride Length, " + dimension_label + " Dimensional " + torqueType + " Torque");
    hold on;
    if mean(n0x9) >= -1000
        legend_labels = [legend_labels, "0.7 - 0.9", "", ""];
        plotting_helper(x_axis, n0x9(range, 1), n0x9(range, 2), dimension_label);
    end
    if mean(n1x1) >= -1000
        legend_labels = [legend_labels, "0.9 - 1.1", "", ""];
        plotting_helper(x_axis, n1x1(range, 1), n1x1(range, 2), dimension_label);
    end
    if mean(n1x3) >= -1000
        legend_labels = [legend_labels, "1.1 - 1.3", "", ""];
        plotting_helper(x_axis, n1x3(range, 1), n1x3(range, 2), dimension_label);
    end
    if mean(n1x5) >= -1000
        legend_labels = [legend_labels, "1.3 - 1.5", "", ""];
        plotting_helper(x_axis, n1x5(range, 1), n1x5(range, 2), dimension_label);
    end
    if mean(n1x7) >= -1000
        legend_labels = [legend_labels, "1.5 - 1.7", "", ""];
        plotting_helper(x_axis, n1x7(range, 1), n1x7(range, 2), dimension_label);
    end
    if mean(n1x9) >= -1000
        legend_labels = [legend_labels, "1.7 - 1.9", "", ""];
        plotting_helper(x_axis, n1x9(range, 1), n1x9(range, 2), dimension_label);
    end
    legend(legend_labels);
end

%% Helper functions
function plotting_helper(x, y, error_vector, dimension_label)
    if dimension_label == "XYZ"
        plot3(y(1 : 150), y(151 : 300), y(301 : 450));
        xlabel("x torque (N * m / kg)");
        ylabel("y torque (N * m / kg)");
        zlabel("z torque (N * m / kg)");
    else
        upper_error = y + error_vector;
        lower_error = y - error_vector;
    
        plot(x, y, 'LineWidth', 2);
        hold on;
        %plot(x, upper_error, '--', 'LineWidth', 1.2);
        %plot(x, lower_error, '--', 'LineWidth', 1.2);
        xlabel("Normalized Gait Percentage");
        ylabel(dimension_label + " Torque (N * m / kg)");
    end
    grid on;
end

function [vector] = vector_averager(x, output_size)
    vector = zeros(output_size, 2);
    for i = 1 : output_size
        if isempty(x)
            vector(i, :) = [-10000, -10000];
        else
            vector(i, 1) = mean(x(i, :));
            vector(i, 2) = std(x(i, :));
        end
    end
end