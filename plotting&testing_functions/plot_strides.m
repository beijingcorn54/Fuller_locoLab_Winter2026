function plot_strides(data, marker, graphTitle, threshold, test, directory)
    x = data.markers.(marker)(:, 1, :);
    y = data.markers.(marker)(:, 2, :);
    z = data.markers.(marker)(:, 3, :);

    addpath(directory + 'computation_functions/');
    [HS, TO] = find_HS_TO(data, threshold, directory);
    rmpath(directory + 'computation_functions/');

    size_vector = size(x);

    % Plot One Trial of Stride Trajectories
    figure;
    x_axis = [-0.68, -0.57];
    y_axis = [0.5, 1.5];
    z_axis = [-0.05, 0.35];

    for i = 1: size_vector(3)
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
        for i = 1: size_vector(3)
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
