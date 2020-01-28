# Hot-Carrier-Generation-Metallic-nano-Cube
# All the code is written in MATLAB
energy_level.m is used to generate all interested energy states. The input is the upper bound of principle quantum number, the output "DOS" is a matrix consist of all possible states which satisfy nx <= n_safe and ny ^ 2 <= n_safe ^ 2 - nx ^ 2 and nz ^ 2 <= n_safe ^ 2 - nx ^ 2 - ny ^ 2. And the matrix is firstly sorted based on the total energy of the states and then the quantum number in x direction.

