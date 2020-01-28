% This function calculate the hot carrier generation rate at 0 K
function [TR_matrix, Total_hc_DOS, hc_DOS] = hc_generation(L, Ep, Efield, Material)
    % L is the dimension of metallic cube, Ep is the photon energy, Efield
    % is the electric field inside metallic cube
    % load physical parameters
    physical_parameters()
    charge = evalin('base', 'charge');
    RPlanck = evalin('base', 'RPlanck');
    mass = evalin('base', 'mass');
    kb = evalin('base', 'kb');
    dpr_gold = evalin('base', 'dpr_gold');
    den_gold = evalin('base', 'den_gold');
    Ef_gold = evalin('base', 'Ef_gold');
    
    if Material == 1
        den = den_gold;
        Ef = Ef_gold;
    end
    % Prefactor to simplify calculation
    pre_A = (RPlanck * pi) ^ 2 / (2 * mass * L ^ 2);
    % Calculate calibrated Ef
    [Total_DOS, Static_DOS, Ef_Cal] = Calibrate_Ef(L, Material);
    % get initial states and possible final states
    safe_n = ceil(((Ef_Cal * charge + Ep) / pre_A) ^ 0.5) + 1;
    DOS_f = energy_level(safe_n);
    DOS_i = energy_level(safe_n);
    %re-modify DOS_f
    DOS_f = [DOS_f, zeros(length(DOS_f), 1)];
    
    % Calculate hot carrier generation
    TR_matrix = zeros(safe_n, safe_n);
    for index_f = 1:length(DOS_f)
        for index_i = 1:length(DOS_i)
            if DOS_f(index_f, 2) == DOS_i(index_i, 2) && DOS_f(index_f, 3) == DOS_i(index_i, 3) && rem(abs(DOS_f(index_f, 1) - DOS_i(index_i, 1)), 2) ~= 0
                % Many prefactors to facilitate calculation
                %pre_B is the FD of initial states - FD of final states
                pre_B = (DOS_i(index_i, 4) * pre_A / charge <= Ef_Cal) - (DOS_f(index_f, 4) * pre_A / charge < Ef_Cal);
                pre_C = 16 * (charge * L * Efield / pi ^ 2) ^ 2;
                pre_D = (DOS_f(index_f, 1) / (DOS_f(index_f, 1) ^ 2 - DOS_i(index_i, 1) ^ 2)) ^ 2;;
                pre_E = (1 - cos(pi * (DOS_f(index_f, 1) + DOS_i(index_i, 1)))) / (DOS_f(index_f, 1) + DOS_i(index_i, 1));
                pre_F = (1 - cos(pi * (DOS_f(index_f, 1) - DOS_i(index_i, 1)))) / (DOS_f(index_f, 1) - DOS_i(index_i, 1));
                pre_G = ((Ep - pre_A * (DOS_f(index_f, 1) ^ 2 - DOS_i(index_i, 1) ^ 2)) ^ 2 + dpr_gold ^ 2) ^ -1;
                pre_H = ((Ep + pre_A * (DOS_f(index_f, 1) ^ 2 - DOS_i(index_i, 1) ^ 2)) ^ 2 + dpr_gold ^ 2) ^ -1;
                DOS_f(index_f, 5) = DOS_f(index_f, 5) + pre_C * pre_B * pre_D * (pre_E + pre_F) ^ 2 * (pre_G + pre_H);
                TR_matrix(DOS_f(index_f, 1), DOS_i(index_i)) = TR_matrix(DOS_f(index_f, 1), DOS_i(index_i)) + pre_C * pre_B * pre_D * (pre_E + pre_F) ^ 2 * (pre_G + pre_H);
            end
        end
    end
    hc_DOS = DOS_f;
    % Merge electrons at same total energy state
    index_A = 0;
    for index_B = 1:length(hc_DOS)
        if index_B == 1
            index_A = index_A + 1;
            Total_hc_DOS(index_A, :) = [hc_DOS(index_B, 4), hc_DOS(index_B, 5)];
        else
            if ismember(hc_DOS(index_B, 4), Total_hc_DOS(:, 1)) == 0
                index_A = index_A + 1;
                Total_hc_DOS(index_A, :) = [hc_DOS(index_B, 4), hc_DOS(index_B, 5)];
            else
                myindex = find(Total_hc_DOS(:, 1) == hc_DOS(index_B, 4));
                Total_hc_DOS(myindex, 2) = Total_hc_DOS(myindex, 2) + hc_DOS(index_B, 5);   
            end
        end
    end
end