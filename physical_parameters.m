% This function generates multiple physical constants in work space
function physical_parameters()
    % charge per electron
    charge = 1.602 * 10^ -19;
    assignin('base', 'charge', charge)

    % mass per electron
    mass = 9.109 * 10 ^ -31;
    assignin('base', 'mass', mass)

    % Boltzmann Constant
    kb = 1.381 * 10 ^ -23;
    assignin('base', 'kb', kb)

    % Planck Constant
    Planck = 6.626 * 10 ^ -34;
    assignin('base', 'Planck', Planck)

    % Reduced Planck Constant
    RPlanck = Planck / (2 * pi);
    assignin('base', 'RPlanck', RPlanck)

    % Avogadro Constant
    NA = 6.022 * 10 ^ 23;
    assignin('base', 'NA', NA)

    % density of Gold, kg / m ^ 3
    den_gold = 1.93 * 10 ^ 4;
    % [1]
    assignin('base', 'den_gold', den_gold)

    % atomic mass of gold
    m_gold = 197;
    assignin('base', 'm_gold', m_gold)

    % speed of light
    c_light = 3 * 10 ^ 8;
    assignin('base', 'c_light', c_light)

    % Work function of gold
    work_gold = 5.3 * charge;
    % [2], value between 5.3 to 5.45 eV
    assignin('base', 'work_gold', work_gold)

    % Electron affinity of TiO2
    EA_TiO2 = 5 * charge;
    % [3], value between 4.8 to 5.1 eV
    assignin('base', 'EA_TiO2', EA_TiO2)
    
    % Fermi energy of gold
    Ef_gold = 5.5 * charge;
    % [4]
    assignin('base', 'Ef_gold', Ef_gold)
    
    % Plasmon damping rate of bulk gold
    dpr_gold = 0.072 * charge;
    % [5]
    assignin('base', 'dpr_gold', dpr_gold)

end
% 1. Ando, T.; Hirota, N.; Satoh, A.; Beaugnon, E., Experiment and Numerical Simulation of Interactions among Magnetic Dipoles Induced in Feeble Magnetic Substances under High Magnetic Fields. Journal of Magnetism and Magnetic Materials 2006, 303 (1), 39-48.
% 2. Sachtler, W. M. H.; Dorgelo, G. J. H.; Holscher, A. A., The Work Function of Gold. Surface Science 1966, 5 (2), 221-229.
% 3. Scanlon, D. O.; Dunnill, C. W.; Buckeridge, J.; Shevlin, S. A.; Logsdail, A. J.; Woodley, S. M.; Catlow, C. R. A.; Powell, M. J.; Palgrave, R. G.; Parkin, I. P.; Watson, G. W.; Keal, T. W.; Sherwood, P.; Walsh, A.; Sokol, A. A., Band Alignment of Rutile and Anatase Tio2. Nature Materials 2013, 12 (9), 798-801.
% 4. Govorov, A. O.; Zhang, H., Kinetic Density Functional Theory for Plasmonic Nanostructures: Breaking of the Plasmon Peak in the Quantum Regime and Generation of Hot Electrons. The Journal of Physical Chemistry C 2015, 119 (11), 6181-6194.
% 5. Kolwas, K.; Derkachova, A., Damping Rates of Surface Plasmons for Particles of Size from Nano- to Micrometers; Reduction of the Nonradiative Decay. Journal of Quantitative Spectroscopy and Radiative Transfer 2013, 114, 45-55.