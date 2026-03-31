function [min_index] = findMin_index(start_i, end_i, z_force, threshold)
% Finds the minimum value, used for find_HS_TO(data, threshold)
    min_val = 1000;
    for i = start_i : end_i
        diff = abs(threshold - abs(z_force(i)));
        if diff < min_val
            min_val = diff;
            min_index = i;
        end
    end
end