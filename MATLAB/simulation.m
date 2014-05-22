clc
clear all
close all

% add packages
addpath(genpath('C:/Users/daniel/Documents/GitHub/ATICproject/MATLAB/packages'))

%% Load parameters
run('parameters')
omega = logspace(-4,3,250);
global K_sim

%% Linearize normalized car plant

% Linearize Plant
run('linearize_normalized_plant_P_car')

% Perturbation weights
run('define_weights')

% Linearize Plant with weights
run('linearize_pertubated_plant_model_car')

%% Controller design

run('design_K_nom')
[h2_nom,h2_nom_inf]  = analyze_controller(P_nom,K_nom,nctrl,nmeas,omega,'Nominal Design',P,Iw,Ie,Iz,Iv,P_car)

run('design_K_LMI')
analyze_controller(P_h2lmi,K_h2lmi,nctrl,nmeas,omega,'H2 LMI',P,Iw,Ie,Iz,Iv,P_car)

run('design_K_H2Syn')
[h2_syn ,h2_syn_inf] = analyze_controller(P_h2syn,K_h2syn,nctrl,nmeas,omega,'H2 Syn',P,Iw,Ie,Iz,Iv,P_car)

h2_nom - h2_syn

h2_nom_inf - h2_syn_inf



