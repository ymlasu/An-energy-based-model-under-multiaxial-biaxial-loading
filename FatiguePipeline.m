%% Sample Code

% File path
addpath('C:\MicroSD path\Dropbox (ASU)\Fatigue\Biaxial fatigue\')

% Material properties
Properties = %read material property data
Poisson = 
Faxial = 
Baxial =
Loading = %read loading input data
F_life = [];
for i = 1:length(Loading)
    sigma = 
    tor = 
    epsilon = 
    gama = 
    phase = 
    [U_dis, U_dil, epsilon_dil] = Energy_decompose(sigma, tor, epsilon, gama, phase);
    F_life(end+1) = Fatigue_Model(energy_uni_lmt, energy_dis_lmt, Poisson, Faxial, Baxial, U_dis, U_dil);
end
