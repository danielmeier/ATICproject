clc
clear all
close all

% add packages
addpath(genpath('C:/Users/daniel/Documents/GitHub/ATICproject/MATLAB/packages'))

%% Load parameters
run('parameters')
omega = logspace(-4,3,250);

%% Linearize normalized car plant

% Linearize Plant
run('linearize_normalized_plant_P_car')

% Perturbation weights
run('define_weights')

% Linearize Plant with weights
run('linearize_pertubated_plant_model_car')

%% Controller design

run('design_K_nom')
analyze_controller(P_nom,K_nom,nctrl,nmeas,omega,'Nominal Design')

run('design_K_LMI')
analyze_controller(P_h2lmi,K_h2lmi,nctrl,nmeas,omega,'H2 LMI')

run('design_K_H2Syn')
analyze_controller(P_h2syn,K_h2syn,nctrl,nmeas,omega,'H2 Syn')







