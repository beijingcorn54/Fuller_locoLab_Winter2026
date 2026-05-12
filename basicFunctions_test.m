clear;
close all;

% Load in Data
directory = "/Users/kefuller/Fuller_Locolab/";
dataBase = load(directory + "locolab_files/Normalized.mat").Normalized;
data = dataBase.AB02.Walk.s1x2.i0;
legLength = 0.921;

% Plot everything
force_threshold = 25;
v_treadmill = -1.2;
incline = 0;
graphTitle = "AB02.Walk.s1x2.i0";
test = true;

addpath(directory + 'plotting&testing_functions/');
%plot_forces(data, graphTitle, force_threshold, true, directory);
%plot_strides(data, graphTitle, force_threshold, test, directory);
%plot_corrected_strides(data, v_treadmill, graphTitle, force_threshold, test, directory);

%display_cadences(data, directory);
%display_stride_lengths(data, v_treadmill, incline, legLength, directory);
rmpath(directory + 'plotting&testing_functions/');
