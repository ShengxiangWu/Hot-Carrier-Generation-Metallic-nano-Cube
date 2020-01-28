% This function calculates the static density of states of plasmonic metal
% cubes at 0 K and the calibrated fermi energy
function [Total_DOS, Static_DOS, Ef_Cal] = Calibrate_Ef(L, Material)
    % L is the dimensiton of metallic cube
    % Load physical parameters
    physical_parameters()
    RPlanck = evalin('base', 'RPlanck');
    mass = evalin('base', 'mass');
    den_gold = evalin('base', 'den_gold');
    NA = evalin('base', 'NA');
    m_gold = evalin('base', 'm_gold');
    Ef_gold = evalin('base', 'Ef_gold');
    charge = evalin('base', 'charge');
    
    % Material supports gold, silver and copper
    if Material == 1
        den = den_gold;
        Ef = Ef_gold;
    end
    % Calculate the number of free electrons
    num_e = ceil(L ^ 3 * den * 1000 / m_gold * NA);
    % Prefactor to simplify calculation
    pre_A = (RPlanck * pi) ^ 2 / (2 * mass * L ^ 2);
    % Calculate the upper bound of principle quantum number
    % the '1' here is trying to capture all states, otherwise an error
    % might occur (infinte loop)
    safe_n = ceil((Ef / pre_A) ^ 0.5) + 1;
    % Calling function energy+level
    DOS = energy_level(safe_n);
    % Filling electrons in states
    index = 1;
    while num_e > 0 
        Static_DOS(index, :) = [DOS(index, :), 2];
        num_e = num_e - 2;
        index = index + 1;
    end
    % Then we got size-dependet calibrated EF
    Ef_Cal = Static_DOS(length(Static_DOS), 4) * pre_A / charge;
    % Merge electrons at same total energy state
    index_A = 0;
    for index_B = 1:length(Static_DOS)
        if index_B == 1
            index_A = index_A + 1;
            Total_DOS(index_A, :) = [Static_DOS(index_B, 4), Static_DOS(index_B, 5)];
        else
            if ismember(Static_DOS(index_B, 4), Total_DOS(:, 1)) == 0
                index_A = index_A + 1;
                Total_DOS(index_A, :) = [Static_DOS(index_B, 4), Static_DOS(index_B, 5)];
            else
                myindex = find(Total_DOS(:, 1) == Static_DOS(index_B, 4));
                Total_DOS(myindex, 2) = Total_DOS(myindex, 2) + Static_DOS(index_B, 5);   
            end
        end
    end
end