% This function list all possible energy of states including three principle
% quantum numbers and total energy
function DOS = energy_level(safe_n)
    % safe_n is a precalculated upper bound of nx (or ny, nz)
    index = 1;
    for nx = 1:safe_n
        ny_upper = floor((safe_n ^ 2 - nx ^ 2) ^ 0.5);
        for ny = 1:ny_upper
            nz_upper = floor((safe_n ^ 2 - nx ^ 2 - ny ^ 2) ^ 0.5);
            for nz = 1:nz_upper
                DOS(index, :) = [nx, ny, nz, nx ^ 2 + ny ^ 2 + nz ^ 2];
                index = index + 1;
            end
        end
    end
    DOS = sortrows(DOS, [4 1]);
end