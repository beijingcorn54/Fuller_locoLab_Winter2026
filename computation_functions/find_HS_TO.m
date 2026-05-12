% Produces HS/TO indecies from all trials of a specified person/incline/speed 
function [HS_vector, TO_vector] = find_HS_TO(data, force_threshold)
    % Extract Data
    z_force = -squeeze(data.forceplates.Force(:, 3, :));

    % Initialize HS and TO vectors
    HS_vector = zeros(1, size(z_force, 2));
    TO_vector = HS_vector;

    %% Produce HS and TO vectors
    for i_col = 1 : size(z_force, 2)
        this_HS = 1;
        this_TO = 150;

        upper_threshold = 1000000;
        lower_threshold = 1000000;

        for i_row = 1 : 120
            this_datum = z_force(i_row, i_col);

            if (i_row < 30) && ...
                (abs(this_datum - force_threshold) < abs(lower_threshold - force_threshold))
                lower_threshold = this_datum;
                this_HS = i_row;
            end

            if (i_row > 30) && ...
                (abs(this_datum - force_threshold) < abs(upper_threshold - force_threshold))
                upper_threshold = this_datum;
                this_TO = i_row;
            end

        end

        % Append to HS and TO vectors
        HS_vector(i_col) = this_HS;
        TO_vector(i_col) = this_TO;
    end
end
