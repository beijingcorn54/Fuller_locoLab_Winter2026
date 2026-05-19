function [mean_std_vector] = get_mean_std_vector(data)
    mean_std_vector = [];

    if ~isempty(data(5 : end)) % Hardcoded based on the number of ingrained measurements
        % Interpolate Data
        interpolated_data = get_interpolated_data(data);
    
        % Find mean, standard deviation, and number of trials/steps represented in the matrix
        mean_std_vector = [];
    
        for i_row = 1 : size(interpolated_data, 1)        
            mean_std_vector = [mean_std_vector; [mean(interpolated_data(i_row, :)), std(interpolated_data(i_row, :)), size(interpolated_data, 2)]];
        end

        % Remove the ingrained measurements from the dataset
        mean_std_vector = mean_std_vector(5 : end, :); % Hardcoded based on the number of ingrained measurements
    end
end
