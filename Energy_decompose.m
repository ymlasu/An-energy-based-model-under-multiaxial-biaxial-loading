function [U_dis, U_dil, U_dil_mean] = Energy_decompose(sigma, mean_sigma, tor, mean_tor, epsilon, gama, phase, E, G)
    epsilon_dis = zeros(6,1);
    epsilon_dil = 0; sigma_dil = 0;
    U_dis = 0; U_dil = 0; U_dil_mean = 0;
    for t = 1:1080
        sigma1 = sigma(1)*sin((t-phase(1))*pi/180) + mean_sigma(1);
        sigma2 = sigma(2)*sin((t-phase(2))*pi/180) + mean_sigma(2);
        sigma3 = sigma(3)*sin((t-phase(3))*pi/180) + mean_sigma(3);
        tor1 = tor(1)*sin((t-phase(4))*pi/180) + mean_tor(1);
        tor2 = tor(2)*sin((t-phase(5))*pi/180) + mean_tor(2);
        tor3 = tor(3)*sin((t-phase(6))*pi/180) + mean_tor(3);
        epsilon1 = epsilon(1)*sin((t-phase(1))*pi/180) + mean_sigma(1)/E;
        epsilon2 = epsilon(2)*sin((t-phase(2))*pi/180) + mean_sigma(2)/E;
        epsilon3 = epsilon(3)*sin((t-phase(3))*pi/180) + mean_sigma(3)/E;
        gama1 = gama(1)*sin((t-phase(4))*pi/180) + mean_tor(1)/G;
        gama2 = gama(2)*sin((t-phase(5))*pi/180) + mean_tor(2)/G;
        gama3 = gama(3)*sin((t-phase(6))*pi/180) + mean_tor(3)/G;
        
        if t < phase(1)
            sigma1 = 0; epsilon1 = 0;
        end
        if t < phase(2)
            sigma2 = 0; epsilon2 = 0;
        end
        if t < phase(3)
            sigma3 = 0; epsilon3 = 0;
        end
        if t < phase(4)
            tor1 = 0; gama1 = 0;
        end
        if t < phase(5)
            tor2 = 0; gama2 = 0;
        end
        if t < phase(6)
            tor3 = 0; gama3 = 0;
        end
        
        sigma_dil(end+1) = (sigma1 + sigma2 + sigma3) / 3;
        epsilon_dil(end+1) = (epsilon1 + epsilon2 + epsilon3) / 3;
        sigma_dis = [sigma1 - sigma_dil(t+1);
                     sigma2 - sigma_dil(t+1);
                     sigma3 - sigma_dil(t+1);
                                   tor1;
                                   tor2;
                                   tor3];
        epsilon_dis(1:6,end+1) = [(epsilon1 - epsilon_dil(t+1));
                                 (epsilon2 - epsilon_dil(t+1));
                                (epsilon3 - epsilon_dil(t+1));
                                                        gama1;
                                                        gama2;
                                                        gama3];
        
        del_epsilon_dis = epsilon_dis(1:6, t+1) - epsilon_dis(1:6, t);
        del_epsilon_dil = epsilon_dil(t+1) - epsilon_dil(t);
        del_energy_dil = 3 * ((sign(sigma_dil(t+1)) * sign(del_epsilon_dil) + 1) / 2) * (sigma_dil(t+1) * del_epsilon_dil);
        del_energy_dis = sum(((sign(sigma_dis) .* sign(del_epsilon_dis) + 1) / 2) .* (sigma_dis .* del_epsilon_dis));
        
        U_dil(end+1) = del_energy_dil + U_dil(end);
        U_dis(end+1) = del_energy_dis + U_dis(end);
        
        U_dil_mean(end+1) = sign(epsilon_dil(t+1)) * 1.5 * abs(sigma_dil(t+1) * epsilon_dil(t+1));
    end
end