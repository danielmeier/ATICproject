clc
clear all
close all

%% Load parameters
run('parameters')

%% Define Model
sys = 'model';
sim('model',10)

%Trans = tf(P);
figure
subplot(2,2,1)
plot(alpha_des.Time,alpha_des.Data(:,1),alpha.Time,alpha.Data(:,1))
title('alpha_d_e_s vs alpha')
legend(['ref'; 'sys'])
subplot(2,2,2)
plot(rho_des.Time,rho_des.Data(:,1),rho.Time,rho.Data(:,1))
title('rho_d_e_s vs rho')
legend(['ref'; 'sys'])
subplot(2,2,3)
plot(forces.Time,forces.Data(:,1))
title('F_z')
subplot(2,2,4)
plot(forces.Time,forces.Data(:,2))
title('F_g')


%sim('steering',10)

load_system(sys);

paramNameValStruct.StopTime       = '2';  
simOut = sim(sys,paramNameValStruct)


sys_plant = 'model/Plant';

sim(sys)

%Trans = tf(P);
figure
subplot(1,2,1)
plot(forces.Time,forces.Data(:,1))
subplot(1,2,2)
plot(forces.Time,forces.Data(:,1))

figure
plot(tho)


%findop(sys)

%% Linearize System

% Define system
sys_plant = 'plant';

% Linearize around operating point
sys_struct = linmod(sys_plant,[pi/2,0,0,0],0);
sys_struct.StateName
sys_struct.OperPoint.x

A_P = sys_struct.a;
B_P = sys_struct.b;
C_P = sys_struct.c;
D_P = sys_struct.d;

P = ss(A_P,B_P,C_P,D_P);
step(P,1)









w_z = 1.5;
w_w = 250;


% Define system
sys_plant = 'steering';

% Linearize around operating point
sys_struct = linmod(sys_plant);
sys_struct.StateName
sys_struct.OperPoint.x

A_P = sys_struct.a;
B_P = sys_struct.b;
C_P = sys_struct.c;
D_P = sys_struct.d;

P = ss(A_P,B_P,C_P,D_P);
figure
step(P,0.2)


%K=[ 0 1/10000; 1/10000 0];
%M=lft(P,K);
% 
%Iz = [1:4]' % Create indices for each block.
% Iv = [1:4]�;
% Ie = [5:8]�;
% Iw = [5:10]�;
% Iy = [9:12]�;
% Iu = [11:12]�;
% Pnomdesign = P([Ie;Iy],[Iw;Iu]); % select [e;y] <- [w;u]
% Pnomdesign = minreal(Pnomdesign); % remove non-minimal states.
% [Knom,Gnom,gamma,info] = hinfsyn(Pnomdesign,nmeas,nctrl,...
% �METHOD�,�ric�,... % Riccati solution
% �TOLGAM�,0.1); % gamma tolerance