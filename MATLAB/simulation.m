clc
clear all
close all

% add packages
addpath(genpath('C:/Users/daniel/Documents/GitHub/ATICproject/MATLAB/packages'))

%% Load parameters
run('parameters')
omega = logspace(-4,3,250);
global K_sim;

K_sim = 1

%% Linearize normalized car plant

% Linearize Plant
run('linearize_normalized_plant_P_car')

% Perturbation weights
run('define_weights')

% Linearize Plant with weights
run('linearize_pertubated_plant_model_car')

%% Controller design

run('design_K_nom')
[h2_nom,h2_nom_inf]  = analyze_controller(P_nom,K_nom,nctrl,nmeas,omega,'Nominal Design',P,Iw,Ie,Iz,Iv,P_car,gamma)

%run('design_K_LMI')
%analyze_controller(P_h2lmi,K_h2lmi,nctrl,nmeas,omega,'H2 LMI',P,Iw,Ie,Iz,Iv,P_car,gamma_2lmi)

run('design_K_H2Syn')
[h2_syn ,h2_syn_inf,muinfo0,Grob_f,muRP] = analyze_controller(P_h2syn,K_h2syn,nctrl,nmeas,omega,'H2 Syn',P,Iw,Ie,Iz,Iv,P_car,gamma_2syn)

% h2_nom - h2_syn
% h2_nom_inf - h2_syn_inf

% K-iteration

run DK_iter

[Kmu1,Gmu1,gamma1,info1] = hinfsyn(Pmu1design,nmeas,nctrl);
if isempty(Kmu1),
  error('hinfsyn failed to run');
end
Kmu1 = minreal(Kmu1);
G_mu1= lft(P_nom,Kmu1);
norm(G_mu1,Inf)

[h2_syn ,h2_syn_inf,muinfo0,Grob_f,muRP] = analyze_controller(Pmu1design,Kmu1,nctrl,nmeas,omega,'D-K H2 Syn',P,Iw,Ie,Iz,Iv,P_car,gamma1)



