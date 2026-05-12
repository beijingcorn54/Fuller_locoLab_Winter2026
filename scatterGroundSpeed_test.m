clear;
close all;

% Load in Data
directory = "/Users/kefuller/Fuller_Locolab/";
dataBase = load(directory + "locolab_files/Normalized.mat").Normalized;

% Initial Variables
subjects = ["AB01", "AB02", "AB03", "AB04", "AB05", "AB06", "AB07", "AB08", "AB09", "AB10"];
speeds = ["s0x8", -0.8; "s1", -1; "s1x2", -1.2];
inclines = ["i10", 10; "i5", 5; "i0", 0; "in5", -5; "in10", -10];

force_threshold = 25;

% Extract Data
test_zoom = true;
test_noZoom = true;
table_labels = strings(1, 15);
table_expectedVals = zeros(1, 15);
table_rmsDev = zeros(1, 15);

    %  Speed 0x8
    for i_incline = 1 : 5
        incline_val = str2double(inclines(i_incline, 2));
        incline_type = inclines(i_incline, 1);
        expected_speed = 0.8 ./ cos(incline_val * pi /180);
    
        for i_sub = 1 : 10
            data = dataBase.(subjects(i_sub)).Walk.s0x8.(incline_type);
            addpath(directory + 'computation_functions/');
            ground_speed = calculate_ground_speeds(data, force_threshold, incline_val, directory);
        end
    
        label = "Speed s0x8, " +  "Incline " + incline_type;
        addpath(directory + 'plotting&testing_functions/');
        rmsDev = plot_ground_speeds(ground_speed, label, test_zoom, expected_speed);
    
        if test_zoom && test_noZoom
            addpath(directory + 'plotting&testing_functions/');
            plot_ground_speeds(ground_speed, label, ~test_zoom, expected_speed);
        end
    
        table_index = i_incline;
        table_labels(table_index) = label;
        table_expectedVals(table_index) = expected_speed;
        table_rmsDev(table_index) = rmsDev;
    end
    
    %  Speed 1
    for i_incline = 1 : 5
        incline_val = str2double(inclines(i_incline, 2));
        incline_type = inclines(i_incline, 1);
        expected_speed = 1 ./ cos(incline_val * pi /180);
    
        for i_sub = 1 : 10
            data = dataBase.(subjects(i_sub)).Walk.s1.(incline_type);
            addpath(directory + 'computation_functions/');
            ground_speed = calculate_ground_speeds(data, force_threshold, incline_val, directory);
        end
    
        label = "Speed s1, " +  "Incline " + incline_type;
        addpath(directory + 'plotting&testing_functions/');
        rmsDev = plot_ground_speeds(ground_speed, label, test_zoom, expected_speed);
    
        if test_zoom && test_noZoom
            addpath(directory + 'plotting&testing_functions/');
            plot_ground_speeds(ground_speed, label, ~test_zoom, expected_speed);
        end
    
        table_index = 5 + i_incline;
        table_labels(table_index) = label;
        table_expectedVals(table_index) = expected_speed;
        table_rmsDev(table_index) = rmsDev;
    end
    
    %  Speed 1x2
    for i_incline = 1 : 5
        incline_val = str2double(inclines(i_incline, 2));
        incline_type = inclines(i_incline, 1);
        expected_speed = 1.2 ./ cos(incline_val * pi /180);
    
        for i_sub = 1 : 10
            data = dataBase.(subjects(i_sub)).Walk.s1x2.(incline_type);
            addpath(directory + 'computation_functions/');
            ground_speed = calculate_ground_speeds(data, force_threshold, incline_val, directory);
        end
    
        label = "Speed s1x2, " +  "Incline " + incline_type;
        addpath(directory + 'plotting&testing_functions/');
        rmsDev = plot_ground_speeds(ground_speed, label, test_zoom, expected_speed);
    
        if test_zoom && test_noZoom
            addpath(directory + 'plotting&testing_functions/');
            plot_ground_speeds(ground_speed, label, ~test_zoom, expected_speed);
        end
    
        table_index = 10 + i_incline;
        table_labels(table_index) = label;
        table_expectedVals(table_index) = expected_speed;
        table_rmsDev(table_index) = rmsDev;
    end

% Make Table
T = table(table_labels', table_expectedVals', table_rmsDev', ...
    'VariableNames', {'Data Type', 'Expected Speeds', 'RMS Deviation'});
