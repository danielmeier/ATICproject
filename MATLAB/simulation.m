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
analyze_controller(Pnomdesign,Knom,nctrl,nmeas,omega,'Nominal Design')

disp('Designing H2 Controller, solving LMI...')
run('design_K_LMI')
analyze_controller(Pnomdesign,K_2lmi,nctrl,nmeas,omega,'LMI')

run('design_K_H2Syn')
analyze_controller(Pnomdesign,K_2syn,nctrl,nmeas,omega,'Syn')







