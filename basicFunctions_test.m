clear;
close all;

% Load in Data
directory = "/Users/kefuller/Fuller_Locolab_Winter2026/";
dataBase = load(directory + "locolab_files/Normalized.mat").Normalized;
data = dataBase.AB02.Walk.s1x2.i0;

% Plot everything
threshold = 25;
v_treadmill = -1.2;
marker = "LHEE";
incline = 0;

addpath(directory + 'plotting&testing_functions/');
plot_forces(data, "AB02.Walk.s1x2.i0", threshold, true, directory);
plot_strides(data, marker, "AB02.Walk.s1x2.i0", threshold, true, directory);
plot_corrected_strides(data, marker, v_treadmill, "AB02.Walk.s1x2.i0", threshold, true, directory);

display_cadences(data, marker, directory);
display_stride_lengths(data, threshold, v_treadmill, marker, incline, directory);
rmpath(directory + 'plotting&testing_functions/');