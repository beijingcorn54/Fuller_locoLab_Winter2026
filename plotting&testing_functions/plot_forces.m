function plot_forces(data, graphTitle, force_threshold, test, directory)
    % Extract Data
    addpath(directory + 'computation_functions/');
    [HS, TO] = find_HS_TO(data, force_threshold);
    rmpath(directory + 'computation_functions/');
    
    z_force = -squeeze(data.forceplates.Force(:, 3, :));

    % Compute x-axis range
    z_force_x_axis = 1 : size(z_force, 1);

    % Plot One Trial of Forces
    figure;
    for i_col = 1: size(z_force, 2)
        hold on;
        scatter(z_force_x_axis, z_force(:, i_col));

        scatter(z_force_x_axis(HS(i_col)), z_force(HS(i_col), i_col), 'red', 'o', 'LineWidth', 2);
        text(z_force_x_axis(HS(i_col)), z_force(HS(i_col), i_col), ['\leftarrow Point' ' Heel-Strike']);
            
        scatter(z_force_x_axis(TO(i_col)), z_force(TO(i_col), i_col), 'red', 'o', 'LineWidth', 2);
        text(z_force_x_axis(TO(i_col)), z_force(TO(i_col), i_col), ['\leftarrow Point' ' Toe-Off']);

        plot(1 : 150, ones(1, 150) * 25);

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
        for i_col = 1: size(z_force, 2)
            figure;
            scatter(z_force_x_axis, z_force(:, i_col));
            hold on;
            scatter(z_force_x_axis(HS(i_col)), z_force(HS(i_col), i_col), 'red', 'o', 'LineWidth', 2);
            text(z_force_x_axis(HS(i_col)), z_force(HS(i_col), i_col), ['\leftarrow Point' ' Heel-Strike']);
            
            scatter(z_force_x_axis(TO(i_col)), z_force(TO(i_col), i_col), 'red', 'o', 'LineWidth', 2);
            text(z_force_x_axis(TO(i_col)), z_force(TO(i_col), i_col), ['\leftarrow Point' ' Toe-Off']);

            plot(1 : 150, ones(1, 150) * 25);
            
            grid on;
            xlabel('X-AXIS (unknownUnits)');
            ylabel('FORCE (N)');
            title(graphTitle + " SINGLE FORCE PLOT OF TRIAL " + i_col);
            xlim([-10, z_force_x_axis(end) + 10]);
            ylim([-50, 900]);
            hold off;
        end
    end
end
