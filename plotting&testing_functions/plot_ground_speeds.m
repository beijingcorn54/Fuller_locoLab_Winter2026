function [rms_dev] = plot_ground_speeds(y, dataName, zoom, expected_speed)
    figure;

    % Plot
    y_size = size(y);
    x = 1 : y_size(2);
    scatter(x, y, 'yellow');

    hold on;

    % Normal Labels
    xlabel("Trial #");
    ylabel("Calculated Speed, (m/s)");

    zoom_label = " ZOOMED IN";
    if ~zoom
        ylim([0.5, 1.5]);
        zoom_label = "";
    end
    title(dataName + zoom_label + " Ground Speed (when foot is on treadmill)");
    grid on;

    % Compute deviation from constant value
    rms_dev = sqrt(mean((y - expected_speed).^2));
    subtitle("RMS Devaition: " + rms_dev + ", Expected Speed: " + expected_speed);
    
    % Plot horizontal line at expected value
    yline(expected_speed, '--', 'LineWidth', 2);
    
    hold off;
end