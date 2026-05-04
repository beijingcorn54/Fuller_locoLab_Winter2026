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

%% Extract Data
test_speedxincline = true;
test_speed = true;
test_incline = true;
test_histogram = true;

% Blank Variable declaration
s0x8_nSL = 0;
s0x8_SL = 0;
s0x8_C = 0;

s1_nSL = 0;
s1_SL = 0;
s1_C = 0;

s1x2_nSL = 0;
s1x2_SL = 0;
s1x2_C = 0;

i10_nSL = 0;
i10_SL = 0;
i10_C = 0;

i5_nSL = 0;
i5_SL = 0;
i5_C = 0;

i0_nSL = 0;
i0_SL = 0;
i0_C = 0;

in5_nSL = 0;
in5_SL = 0;
in5_C = 0;

in10_nSL = 0;
in10_SL = 0;
in10_C = 0;

% Data extraction
for i_incline = 1 : 5
    incline_nSL = 0;
    incline_SL = 0;
    incline_C = 0;

    for i_speed = 1 : 3

        nSL = 0;
        SL = 0;
        C = 0;

        for i_subj = 1 : 10
            speed_val = str2double(speeds(i_speed, 2));
            incline_val = str2double(inclines(i_incline, 2));
            
            data = dataBase.(subjects(i_subj)).Walk.(speeds(i_speed, 1)).(inclines(i_incline, 1));
            
            addpath('/Users/kefuller/Documents/MATLAB/saltmines_MATLAB/computation_functions/');
            new_nSL = find_normalized_strideLengths(data, threshold, speed_val, marker, incline_val, legLengths(i_subj), directory);
            
            addpath('/Users/kefuller/Documents/MATLAB/saltmines_MATLAB/computation_functions/'); 
            new_SL = find_strideLengths(data, threshold, speed_val, marker, incline_val, directory);
            
            addpath('/Users/kefuller/Documents/MATLAB/saltmines_MATLAB/computation_functions/');
            new_C = find_cadence(data, marker);
            rmpath('/Users/kefuller/Documents/MATLAB/saltmines_MATLAB/computation_functions/');
    
            nSL = [nSL, new_nSL];
            SL = [SL, new_SL];
            C = [C, new_C];
        end
        nSL = nSL(2 : end);
        SL = SL(2 : end);
        C = C(2 : end);

        % Speed data formatting
        if i_speed == 1
            s0x8_nSL = [s0x8_nSL, nSL];
            s0x8_SL = [s0x8_SL, SL];
            s0x8_C = [s0x8_C, C];
        
        elseif i_speed == 2
            s1_nSL = [s1_nSL, nSL];
            s1_SL = [s1_SL, SL];
            s1_C = [s1_C, C];

        elseif i_speed == 3
            s1x2_nSL = [s1x2_nSL, nSL];
            s1x2_SL = [s1x2_SL, SL];
            s1x2_C = [s1x2_C, C];

        end

        % Incline data formatting
        incline_nSL = [incline_nSL, nSL];
        incline_SL = [incline_SL, SL];
        incline_C = [incline_C, C];

        % Plot incline.speed graphs
        if test_speedxincline
            plot_stride_v_cadence(SL, C, "Incline and Speed: " + inclines(i_incline, 1) + "." + speeds(i_speed, 1), 1);
            plot_stride_v_cadence(SL, C, "Incline and Speed: " + inclines(i_incline, 1) + "." + speeds(i_speed, 1), 2);
        end
    end

    % Incline data formatting
    incline_nSL = incline_nSL(2 : end);
    incline_SL = incline_SL(2 : end);
    incline_C = incline_C(2 : end);

    if i_incline == 1
        i10_nSL = incline_nSL;
        i10_SL = incline_SL;
        i10_C = incline_C;
    elseif i_incline == 2
        i5_nSL = incline_nSL;
        i5_SL = incline_SL;
        i5_C = incline_C;
    elseif i_incline == 3
        i0_nSL = incline_nSL;
        i0_SL = incline_SL;
        i0_C = incline_C;
    elseif i_incline == 4
        in5_nSL = incline_nSL;
        in5_SL = incline_SL;
        in5_C = incline_C;
    else
        in10_nSL = incline_nSL;
        in10_SL = incline_SL;
        in10_C = incline_C;
    end

    % Plot incline graphs
    plot_stride_v_cadence(incline_SL, incline_C, "Incline: " + inclines(i_incline, 1), 1);
    plot_stride_v_cadence(incline_nSL, incline_C, "Incline: " + inclines(i_incline, 1), 2);
end

%% Plot Everything

% Plot speed graphs
if test_speed
    plot_stride_v_cadence(s0x8_SL, s0x8_C, "Speed: " + speeds(1, 1), 1);
    plot_stride_v_cadence(s0x8_nSL, s0x8_C, "Speed: " + speeds(1, 1), 2);
    
    plot_stride_v_cadence(s1_SL, s1_C, "Speed: " + speeds(2, 1), 1);
    plot_stride_v_cadence(s1_nSL, s1_C, "Speed: " + speeds(2, 1), 2);
    
    plot_stride_v_cadence(s1x2_SL, s1x2_C, "Speed: " + speeds(3, 1), 1);
    plot_stride_v_cadence(s1x2_nSL, s1x2_C, "Speed: " + speeds(3, 1), 2);
end

% Plot incline graphs
if test_incline
    plot_stride_v_cadence(i10_SL, i10_C, "Incline: " + inclines(1, 1), 1);
    plot_stride_v_cadence(i10_nSL, i10_C, "Incline: " + inclines(1, 1), 2);
    
    plot_stride_v_cadence(i5_SL, i5_C, "Incline: " + inclines(2, 1), 1);
    plot_stride_v_cadence(i5_nSL, i5_C, "Incline: " + inclines(2, 1), 2);
    
    plot_stride_v_cadence(i0_SL, i0_C, "Incline: " + inclines(3, 1), 1);
    plot_stride_v_cadence(i0_nSL, i0_C, "Incline: " + inclines(3, 1), 2);
    
    plot_stride_v_cadence(in5_SL, in5_C, "Incline: " + inclines(4, 1), 1);
    plot_stride_v_cadence(in5_nSL, in5_C, "Incline: " + inclines(4, 1), 2);
    
    plot_stride_v_cadence(in10_SL, in10_C, "Incline: " + inclines(5, 1), 1);
    plot_stride_v_cadence(in10_nSL, in10_C, "Incline: " + inclines(5, 1), 2);
end

% Plot all Data for histogram
all_nSL = 0;
all_SL = 0;
all_C = 0;

all_nSL = [all_nSL, s0x8_nSL];
all_nSL = [all_nSL, s1_nSL];
all_nSL = [all_nSL, s1x2_nSL];
all_nSL = all_nSL(2 : end);

all_SL = [all_SL, s0x8_SL];
all_SL = [all_SL, s1_SL];
all_SL = [all_SL, s1x2_SL];
all_SL = all_SL(2 : end);

all_C = [all_C, s0x8_C];
all_C = [all_C, s1_C];
all_C = [all_C, s1x2_C];
all_C = all_C(2 : end);

bins = 30;
if test_histogram
    plot_histogram(all_SL, bins, 1);
    plot_histogram(all_nSL, bins, 2);
    plot_histogram(all_C, bins, 3);
end

function plot_histogram(data, bins, type)
    figure;
    histogram(data, bins);

    hold on;
    grid on;
    ylabel('Frequency');
    if type == 1
        title('All Normalized Stride Lengths');
        xlabel("Normalized Stride Length");
    elseif type == 2
        title('All Stride Lengths');
        xlabel("Stride Length (m)");
    else
        title('All Cadences');
        xlabel("Cadence (steps per minute)");
    end
    hold off;
end
function plot_stride_v_cadence(x_sl, y_cadence, graphTitle, graphType)
    figure;
    scatter(x_sl, y_cadence, 'pentagram', 'red');

    hold on;
    grid on;
    ylabel("Cadence (steps per minute)");

    if graphType == 1
        title(graphTitle + " Cadence vs Stride Length");
        xlabel("Stride Length (m)");
        xlim([0.7, 1.8]);
        ylim([35, 70]);

        % Fit line
        p = polyfit(x_sl, y_cadence, 1);
        y_fit = polyval(p, x_sl);
        plot(x_sl, y_fit, '-', 'LineWidth', 2);

        % Display equation
        m = p(1);
        b = p(2);
        eqn = sprintf('y = %.4fx + %.4f', m, b);
        subtitle("Line of best fit: " + eqn);

    elseif graphType == 2
        title(graphTitle + " Cadence vs Normalized Stride Length");
        xlabel("Normalized Stride Length");
    end
    hold off;
end