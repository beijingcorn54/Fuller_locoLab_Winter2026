function display_cadences(data, directory)
    addpath(directory + 'computation_functions/'); 
    cadences = find_cadence(data);
    rmpath(directory + 'computation_functions/'); 
    
    cadences_size_vector = size(cadences);
    for i = 1 : cadences_size_vector(2)
        disp("Cadence, Trial #" + i + ": " + cadences(i));
    end
end
