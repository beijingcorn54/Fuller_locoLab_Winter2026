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

bins = 20;

%% Extract Data
% Incline 10
norm_SL_i10 = 0;
SL_i10 = 0;
C_i10 = 0;
incline_val = 10;
incline_type = "i10";
for i_speed = 1 : 3
    for i_subj = 1 : 10
        v_treadmill = str2double(speeds(i_speed, 2));
        
        data = dataBase.(subjects(i_subj)).Walk.(speeds(i_speed, 1)).i10;
        
        addpath(directory + 'computation_functions/');
        norm_SL = find_normalized_strideLengths(data, threshold, v_treadmill, marker, incline_val, legLengths(i_subj), directory);
        
        addpath(directory + 'computation_functions/'); 
        SL = find_strideLengths(data, threshold, v_treadmill, marker, incline_val, directory);
        
        addpath(directory + 'computation_functions/');
        C = find_cadence(data, marker);
        rmpath(directory + 'computation_functions/');

        norm_SL_i10 = [norm_SL_i10, norm_SL];
        SL_i10 = [SL_i10, SL];
        C_i10 = [C_i10, C];
    end
end

norm_SL_i10 = norm_SL_i10(2 : end);
SL_i10 = SL_i10(2 : end);
C_i10 = C_i10(2 : end);

% Incline 5
norm_SL_i5 = 0;
SL_i5 = 0;
C_i5 = 0;
incline_val = 5;
for i_speed = 1 : 3
    for i_subj = 1 : 10
        v_treadmill = str2double(speeds(i_speed, 2));
        
        data = dataBase.(subjects(i_subj)).Walk.(speeds(i_speed, 1)).i5;
        
        addpath(directory + 'computation_functions/');
        norm_SL = find_normalized_strideLengths(data, threshold, v_treadmill, marker, incline_val, legLengths(i_subj), directory);
        
        addpath(directory + 'computation_functions/'); 
        SL = find_strideLengths(data, threshold, v_treadmill, marker, incline_val, directory);
        
        addpath(directory + 'computation_functions/');
        C = find_cadence(data, marker);
        rmpath(directory + 'computation_functions/');

        norm_SL_i5 = [norm_SL_i5, norm_SL];
        SL_i5 = [SL_i5, SL];
        C_i5 = [C_i5, C];
    end
end

norm_SL_i5 = norm_SL_i5(2 : end);
SL_i5 = SL_i5(2 : end);
C_i5 = C_i5(2 : end);

% Incline 0
norm_SL_i0 = 0;
SL_i0 = 0;
C_i0 = 0;
incline_val = 0;
for i_speed = 1 : 3
    for i_subj = 1 : 10
        v_treadmill = str2double(speeds(i_speed, 2));
        
        data = dataBase.(subjects(i_subj)).Walk.(speeds(i_speed, 1)).i0;
        
        addpath(directory + 'computation_functions/');
        norm_SL = find_normalized_strideLengths(data, threshold, v_treadmill, marker, incline_val, legLengths(i_subj), directory);
        
        addpath(directory + 'computation_functions/'); 
        SL = find_strideLengths(data, threshold, v_treadmill, marker, incline_val, directory);
        
        addpath(directory + 'computation_functions/');
        C = find_cadence(data, marker);
        rmpath(directory + 'computation_functions/');

        norm_SL_i0 = [norm_SL_i0, norm_SL];
        SL_i0 = [SL_i0, SL];
        C_i0 = [C_i0, C];
    end
end

norm_SL_i0 = norm_SL_i0(2 : end);
SL_i0 = SL_i0(2 : end);
C_i0 = C_i0(2 : end);

% Incline -5
norm_SL_in5 = 0;
SL_in5 = 0;
C_in5 = 0;
incline_val = -5;
for i_speed = 1 : 3
    for i_subj = 1 : 10
        v_treadmill = str2double(speeds(i_speed, 2));
        
        data = dataBase.(subjects(i_subj)).Walk.(speeds(i_speed, 1)).in5;
        
        addpath(directory + 'computation_functions/');
        norm_SL = find_normalized_strideLengths(data, threshold, v_treadmill, marker, incline_val, legLengths(i_subj), directory);
        
        addpath(directory + 'computation_functions/'); 
        SL = find_strideLengths(data, threshold, v_treadmill, marker, incline_val, directory);
        
        addpath(directory + 'computation_functions/');
        C = find_cadence(data, marker);
        rmpath(directory + 'computation_functions/');

        norm_SL_in5 = [norm_SL_in5, norm_SL];
        SL_in5 = [SL_in5, SL];
        C_in5 = [C_in5, C];
    end
end

norm_SL_in5 = norm_SL_in5(2 : end);
SL_in5 = SL_in5(2 : end);
C_in5 = C_in5(2 : end);

% Incline -10
norm_SL_in10 = 0;
SL_in10 = 0;
C_in10 = 0;
incline_val = -10;
for i_speed = 1 : 3
    for i_subj = 1 : 10
        v_treadmill = str2double(speeds(i_speed, 2));
        
        data = dataBase.(subjects(i_subj)).Walk.(speeds(i_speed, 1)).in10;
        
        addpath(directory + 'computation_functions/');
        norm_SL = find_normalized_strideLengths(data, threshold, v_treadmill, marker, incline_val, legLengths(i_subj), directory);
        
        addpath(directory + 'computation_functions/'); 
        SL = find_strideLengths(data, threshold, v_treadmill, marker, incline_val, directory);
        
        addpath(directory + 'computation_functions/');
        C = find_cadence(data, marker);
        rmpath(directory + 'computation_functions/');

        norm_SL_in10 = [norm_SL_in10, norm_SL];
        SL_in10 = [SL_in10, SL];
        C_in10 = [C_in10, C];
    end
end

norm_SL_in10 = norm_SL_in10(2 : end);
SL_in10 = SL_in10(2 : end);
C_in10 = C_in10(2 : end);



%% Plot Histograms

% Normalized Stride Lengths
plotHistogram("i10", norm_SL_i10, bins, 1);
plotHistogram("i5", norm_SL_i5, bins, 1);
plotHistogram("i0", norm_SL_i0, bins, 1);
plotHistogram("in5", norm_SL_in5, bins, 1);
plotHistogram("in10", norm_SL_in10, bins, 1);

% Stride Lengths
plotHistogram("i10", SL_i10, bins, 2);
plotHistogram("i5", SL_i5, bins, 2);
plotHistogram("i0", SL_i0, bins, 2);
plotHistogram("in5", SL_in5, bins, 2);
plotHistogram("in10", SL_in10, bins, 2);

% Cadence: Steps per minute
plotHistogram("i10", C_i10, bins, 3);
plotHistogram("i5", C_i5, bins, 3);
plotHistogram("i0", C_i0, bins, 3);
plotHistogram("in5", C_in5, bins, 3);
plotHistogram("in10", C_in10, bins, 3);


% Speeds = stride length * cadence  / 60
plotHistogram("i10", SL_i10 .* C_i10 ./ 60, bins, 4);
plotHistogram("i5", SL_i5 .* C_i5 ./ 60, bins, 4);
plotHistogram("i0", SL_i0 .* C_i0 ./ 60, bins, 4);
plotHistogram("in5", SL_in5 .* C_in5 ./ 60, bins, 4);
plotHistogram("in10", SL_in10 .* C_in10 ./ 60, bins, 4);


%% Plot Helper Function
function plotHistogram(inclineType, data, bins, graphType)
    figure;
    histogram(data, bins)
    ylabel('Frequency');

    if graphType == 1
       title("Normalized Stride Length, Incline " + inclineType + ", No acceleration");
       xlabel("Normalized Stride Length");
       ylim([0, 150]);
    end
    if graphType == 2
       title("Stride Length, Incline " + inclineType + ", No acceleration");
       xlabel("Stride Length (meters)");
       ylim([0, 150]);
    end
    if graphType == 3
       title("Cadence, Incline " + inclineType + ", No acceleration");
       xlabel("Cadence (steps per minute)");
       ylim([0, 150]);
    end
    if graphType == 4
       title("Speeds, Incline " + inclineType + ", No acceleration");
       xlabel("Stride Velocity (m / s)");
       ylim([0, 150]);
    end

end
