function plot_strides(data, graphTitle, force_threshold, test, directory)
    x = [squeeze(data.markers.LHEE(:, 1, :)), squeeze(data.markers.RHEE(:, 1, :))];
    y = [squeeze(data.markers.LHEE(:, 2, :)), squeeze(data.markers.RHEE(:, 2, :))];
    z = [squeeze(data.markers.LHEE(:, 3, :)), squeeze(data.markers.RHEE(:, 3, :))];

    addpath(directory + 'computation_functions/');
    [HS, TO] = find_HS_TO(data, force_threshold);
    rmpath(directory + 'computation_functions/');

    % Plot One Trial of Stride Trajectories
    figure;
    x_axis = [-0.68, -0.4];
    y_axis = [0.5, 1.5];
    z_axis = [-0.05, 0.35];

    for i = 1 : size(x, 2)
        hold on;
        scatter3(x(:, i), y(:, i), z(:, i));

        scatter3(x(HS(i), i), y(HS(i), i), z(HS(i), i), 'red', 'o', 'LineWidth', 2);
        text(x(HS(i), i), y(HS(i), i), z(HS(i), i), ['\leftarrow Point' ' Heel-Strike']);
            
        scatter3(x(TO(i), i), y(TO(i), i), z(TO(i), i), 'red', 'o', 'LineWidth', 2);
        text(x(TO(i), i), y(TO(i), i), z(TO(i), i), ['\leftarrow Point' ' Toe-Off']);

        xlabel("x-axis");
        xlim(x_axis);
        ylabel("y-axis");
        ylim(y_axis);
        zlabel("z-axis");
        zlim(z_axis);

        grid on;
        title(graphTitle + " STRIDE TRAJECTORY PLOT OF ALL TRIALS");
        hold off;
    end

    % TEST: PLOT ALL INDIVIDUAL TRIALS
    if test
        for i = 1 : size(x, 2)
            figure;
            hold on;
            scatter3(x(:, i), y(:, i), z(:, i));
    
            scatter3(x(HS(i), i), y(HS(i), i), z(HS(i), i), 'red', 'o', 'LineWidth', 2);
            text(x(HS(i), i), y(HS(i), i), z(HS(i), i), ['\leftarrow Point' ' Heel-Strike']);
                
            scatter3(x(TO(i), i), y(TO(i), i), z(TO(i), i), 'red', 'o', 'LineWidth', 2);
            text(x(TO(i), i), y(TO(i), i), z(TO(i), i), ['\leftarrow Point' ' Toe-Off']);
    
            xlabel("x-axis");
            xlim(x_axis);
            ylabel("y-axis");
            ylim(y_axis);
            zlabel("z-axis");
            zlim(z_axis);

            grid on;
            title(graphTitle + " STRIDE TRAJECTORY PLOT TRIAL " + i);
            hold off;
        end
    end
end
