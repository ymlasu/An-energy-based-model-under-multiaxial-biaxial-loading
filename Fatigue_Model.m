function [F_life] = Fatigue_Model(energy_uni_lmt, energy_dis_lmt, Poisson, Faxial, Baxial, U_dis, U_dil)

% k = ((1 - 2 * Poisson) * energy_dis_lmt) / (3*energy_dis_lmt - (2 + 2 * Poisson) * energy_uni_lmt);
% energy_dil_lmt = k * energy_uni_lmt;
% s = energy_uni_lmt / energy_dis_lmt; 
% U_eqv = (s * U_dis + U_dil / k);
% 
% if 3*energy_dis_lmt - (2 + 2 * Poisson) * energy_uni_lmt < 0
%     disp('fatigue limit error')
%     U_eqv = (s * U_dis) / k;
% 
% end


s = energy_uni_lmt / energy_dis_lmt;
k = 1 / 3 / (1-2*Poisson) * (501/561)^2; % 276/434
% k = 0.5;
if U_dis > (2+2*Poisson) * U_dil / (1-2*Poisson)
    U_uni = 3 * U_dil / (1-2*Poisson);
    U_dis = U_dis - (2+2*Poisson) * U_dil / (1-2*Poisson);
    U_dil = 0;
else
    U_uni = 3 * U_dis / (2+2*Poisson);
    U_dil = U_dil - (1-2*Poisson) * U_dis / (2+2*Poisson);
    U_dis = 0;
end

U_eqv = s*U_dis + U_uni + k*U_dil;
%===========Mean stress correction==========

%===========================================

F_life = 10 ^ ((log10(U_eqv) - log10(Faxial)) / (Baxial));

end