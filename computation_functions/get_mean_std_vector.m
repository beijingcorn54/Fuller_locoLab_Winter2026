function [mean_std_vector] = get_mean_std_vector(data)
    if ~isempty(data(4 : end))
        % Interpolate Data
        interpolated_data = get_interpolated_data(data);
    
        % Find mean, standard deviation, and number of trials/steps
        % represented in the matrix
        mean_std_vector = [];
    
        for i_row = 1 : size(interpolated_data, 1)        
            mean_std_vector = [mean_std_vector; [mean(interpolated_data(i_row, :)), std(interpolated_data(i_row, :)), size(interpolated_data, 2)]];
        end

    else
        mean_std_vector = [];
    end
end