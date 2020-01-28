# Hot-Carrier-Generation-Metallic-nano-Cube
# All the code is written in MATLAB

physical_parameters.m lists all relevant physical variables that will be used in other calculations. 

energy_level.m is used to generate all interested energy states. The input is the upper bound of principle quantum number, the output "DOS" is a matrix consisting of all possible states which satisfy nx <= n_safe and ny ^ 2 <= n_safe ^ 2 - nx ^ 2 and nz ^ 2 <= n_safe ^ 2 - nx ^ 2 - ny ^ 2. And the matrix is firstly sorted based on the total energy of the states and then the quantum number in x direction.

Calibrate_Ef.m is used to visualize DOS for metallic nano-cubes at 0 K. The input includes "L", the dimension of cube and "Material", 1 for gold. The output "Total_DOS" consists of all filled states in terms of total energy (degeneracy is removed) and number of electrons. The output "Static_DOS" consists of all filled states in terms of three principle quantum numbers, total energy and number of electrons. The output "Ef_Cal" is the calibrated Fermi energy of a metallic nano-cube with specific size.

hc_generation.m is used to calculate the hot carrier generation in metallic nano-cubes. The input includes "L", the dimension of cube; the "Ep", incident photon energy; "Efield", the electric field inside metallic cubes, and "Material", 1 for gold. The output "TR_matrix" is the transition matrix showing the transition between initial sattes and final states. The output "Total_hc_DOS" is the hot carrier generation rate vs. electron energy. The output "hc_DOS" is the generation rate in terms of three quantum numbers.
