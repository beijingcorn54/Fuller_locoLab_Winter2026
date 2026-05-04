% Produces HS/TO indecies from all trials of a specified person/incline/speed 
function [HS, TO] = find_HS_TO(data, threshold, directory)
    % Extract Data
    addpath(directory + 'helper_functions/');
    z_force = getZForce(data);
    num_trials = getTrials(z_force);

    HS = zeros(1, num_trials);
    TO = zeros(1, num_trials);

    % Produce HS and TO vectors
    for i = 1 : num_trials
        HS(i) = findMin_index(1, 75, z_force(:, i), threshold);
        TO(i) = findMin_index(76, 125, z_force(:, i), threshold);
    end
    rmpath(directory + 'helper_functions/');
end
