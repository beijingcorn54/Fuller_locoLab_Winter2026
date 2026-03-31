function plot_forces(data, graphTitle, threshold, test, directory)
    % Extract Data
    addpath(directory + 'computation_functions/');
    [HS, TO] = find_HS_TO(data, threshold, directory);
    rmpath(directory + 'computation_functions/');
    
    z_force = -squeeze(data.forceplates.Force(:, 3, :));

    addpath(directory + 'helper_functions/');
    trials = getTrials(z_force);
    rmpath(directory + 'helper_functions/');
    
    % Compute x-axis range
    z_force_size_vector = size(z_force);
    z_force_x_axis = 1 : z_force_size_vector(1);

    % Plot One Trial of Forces
    figure;
    for i = 1: trials
        hold on;
        scatter(z_force_x_axis, z_force(:, i));

        scatter(z_force_x_axis(HS(i)), z_force(HS(i), i), 'red', 'o', 'LineWidth', 2);
        text(z_force_x_axis(HS(i)), z_force(HS(i), i), ['\leftarrow Point' ' Heel-Strike']);
            
        scatter(z_force_x_axis(TO(i)), z_force(TO(i), i), 'red', 'o', 'LineWidth', 2);
        text(z_force_x_axis(TO(i)), z_force(TO(i), i), ['\leftarrow Point' ' Toe-Off']);

        grid on;
        xlabel('X-AXIS (unknownUnits)');
        ylabel('FORCE (N)');
        xlim([-10, z_force_x_axis(end) + 10]);
        ylim([-50, 900]);
        title(graphTitle + " FORCE PLOT OF ALL TRIALS");
        hold off;
    end

    % TEST: PLOT ALL INDIVIDUAL TRIALS
    if test
        for i = 1: trials
            figure;
            scatter(z_force_x_axis, z_force(:, i));
            hold on;
            scatter(z_force_x_axis(HS(i)), z_force(HS(i), i), 'red', 'o', 'LineWidth', 2);
            text(z_force_x_axis(HS(i)), z_force(HS(i), i), ['\leftarrow Point' ' Heel-Strike']);
            
            scatter(z_force_x_axis(TO(i)), z_force(TO(i), i), 'red', 'o', 'LineWidth', 2);
            text(z_force_x_axis(TO(i)), z_force(TO(i), i), ['\leftarrow Point' ' Toe-Off']);
            
            grid on;
            xlabel('X-AXIS (unknownUnits)');
            ylabel('FORCE (N)');
            title(graphTitle + " SINGLE FORCE PLOT OF TRIAL " + i);
            xlim([-10, z_force_x_axis(end) + 10]);
            ylim([-50, 900]);
            hold off;
        end
    end
end
