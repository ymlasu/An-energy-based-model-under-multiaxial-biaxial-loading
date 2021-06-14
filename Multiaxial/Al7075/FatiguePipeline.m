clear all
addpath('C:\Users\Desktop\Biaxial fatigue\')
E = 71700;  
G = 27500;
Poisson = 0.306;
Faxial = 29.358;
Baxial = -2.607;
Ftor = 24.291;
Btor = -2.394;
energy_uni_lmt = Faxial * 4^Baxial;
energy_dis_lmt = Ftor * 4^Btor;
% Loading = load('Loading.dat');
Loading = xlsread('7075',3)
F_life = [];
for i = 1:size(Loading,1)
    sigma = Loading(i,1:3);
    mean_sigma = Loading(i,4:6);
    tor = Loading(i,7:9);
    mean_tor = Loading(i,10:12);
    epsilon = Loading(i,13:15);
    gama = Loading(i,16:18);
    phase = Loading(i,19:end);
    
    [U_dis_spec, U_dil_spec, U_dil_mean] = Energy_decompose(sigma, mean_sigma, tor, mean_tor, epsilon, gama, phase, E, G);
    U_dis_spec = U_dis_spec(721:1080);
    U_dil_spec = U_dil_spec(721:1080);
    U_dil_mean = U_dil_mean(721:1080);
    
    [dis_peaks, dis_valleys, cycle_check] = find_PeaksAndValleys(U_dis_spec);
    U_dis = 0.5 * sum(dis_peaks - dis_valleys);
    [dil_peaks, dil_valleys, cycle_check] = find_PeaksAndValleys(U_dil_spec);
    U_dil = 0.5 * sum(dil_peaks - dil_valleys);
    
    F_life(end+1) = Fatigue_Model(energy_uni_lmt, energy_dis_lmt, Poisson, Faxial, Baxial, U_dis, U_dil);
%     F_life = F_life';
end
F_life = F_life';