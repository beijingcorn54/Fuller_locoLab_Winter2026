function [z_force] = getZForce(data)
    z_force = -squeeze(data.forceplates.Force(:, 3, :));
end