clc
clear all
close all

% add packages
addpath(genpath('C:/Users/daniel/Documents/GitHub/ATICproject/MATLAB/packages'))

%% Load parameters
run('parameters')
omega = logspace(-4,3,250);
global K_sim;

%% Linearize normalized car plant

% Linearize Plant
run('linearize_normalized_plant_P_car')

% Perturbation weights
run('define_weights')

% Linearize Plant with weights
run('linearize_pertubated_plant_model_car')

%% Controller design

run('design_K_nom')
[h2_nom,h2_nom_inf,muinfo0,Grob_f,muRP,Gclp_nom_inf]  = analyze_controller(P_nom,K_nom,nctrl,nmeas,omega,'Nominal Design',P,Iw,Ie,Iz,Iv,P_car,gamma);

%run('design_K_LMI')
%analyze_controller(P_h2lmi,K_h2lmi,nctrl,nmeas,omega,'H2 LMI',P,Iw,Ie,Iz,Iv,P_car,gamma_2lmi)

run('design_K_H2Syn')
[h2_syn ,h2_syn_inf,muinfo0,Grob_f,muRP,Gclp_nom] = analyze_controller(P_h2syn,K_h2syn,nctrl,nmeas,omega,'H2 Syn',P,Iw,Ie,Iz,Iv,P_car,gamma_2syn);

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

[h2_syn ,h2_syn_inf,muinfo0,Grob_f,muRP,Gclp_nom_DK] = analyze_controller(Pmu1design,Kmu1,nctrl,nmeas,omega,'D-K H2 Syn',P,Iw,Ie,Iz,Iv,P_car,gamma1);



%% Comparison

tmax = 10;
dt = 0.001;
t = [0:dt:tmax]';

%   Make the step begin at 10 seconds.
ustep = 0.2*(t>= 1.0);
%ustep = 1*sin(12.1*t);

dstep = 0.5*(t>= 2.0 & t<= 3.0);
%dstep = 0.1*sin(12.1*t);

noise = randn(size(t))/50;

[yh1step_Hinf,t1] = lsim(Gclp_nom_inf(:,1:3),[noise,ustep,dstep],t);    % response to h1 step command
[yh1step_H2,t1] = lsim(Gclp_nom(:,1:3),[noise,ustep,dstep],t);    % response to h1 step command
[yh1step_DK,t1] = lsim(Gclp_nom_DK(:,1:3),[noise,ustep,dstep],t);    % response to h1 step command


max(yh1step_Hinf(:,1))

figure
subplot(2,1,1)
plot(t1,yh1step_Hinf(:,1),t1,yh1step_H2(:,1),t,yh1step_DK(:,1),t,ustep,'m--')
grid
%axis([0,tmax,-ref/4,5*ref/4])
legend('\rho_{Hinf}','\rho_{H2}','\rho_{DK}','\rho_r_e_f','location','SouthEast')
xlabel('Time [sec]')
ylabel('Outputs')
title('Nominal Step Response')

subplot(2,1,2)
plot(t1,yh1step_Hinf(:,2),t1,yh1step_H2(:,2),t,yh1step_DK(:,2))
grid
legend('\alpha_{Hinf}','\alpha_{H2}','\alpha_{DK}','Location','SouthEast')
xlabel('Time [sec]')
ylabel('Actuation')



