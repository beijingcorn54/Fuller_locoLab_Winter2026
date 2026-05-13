% Sorts a large data set into a matrix with strides that are exclusively of
% a particular cadence, normalized stride length, or ground speed bucket
function [sorted_data] = sort_a_vector(data, upper_bound, lower_bound, sorting_type)
    sorted_data = [];
    if sorting_type == "c"
        row = 1;
    elseif sorting_type == "nsl"
        row = 2;
    elseif sorting_type == "s"
        row = 3;
    end

    for i_col = 1 : size(data, 2)

        data_to_append = data(:, i_col);
        sorting_measurement = data_to_append(row);        
    
        valid_entry =  ~isnan(sorting_measurement);
        within_upper_bound = sorting_measurement < upper_bound;
        within_lower_bound = (sorting_measurement > lower_bound) || (sorting_measurement == lower_bound);
        
       
        if valid_entry && within_upper_bound && within_lower_bound
            sorted_data = [sorted_data, data_to_append];
        end
    end
end
