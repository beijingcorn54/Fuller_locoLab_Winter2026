% Sorts a large data set into a matrix with strides that are exclusively of particular buckets:
% 1. Cadence
% 2. Normalized stride length
% 3. Calculated Speed
% 4. Recorded Speed

% Keeps those measurements ingrained in the data

function [sorted_data] = sort_a_vector(data, upper_bound, lower_bound, sorting_row)
    sorted_data = [];
    for i_col = 1 : size(data, 2)

        data_to_append = data(:, i_col);
        sorting_measurement = data_to_append(sorting_row);        
    
        valid_entry = ~isnan(data_to_append(10)); % Hardcoded, assumed that no more than 10 measurements need to be labled within the data
        within_upper_bound = (sorting_measurement < upper_bound);
        within_lower_bound = (sorting_measurement > lower_bound) || (sorting_measurement == lower_bound);
        
       
        if valid_entry && within_upper_bound && within_lower_bound
            sorted_data = [sorted_data, data_to_append];
        end
    end
end
