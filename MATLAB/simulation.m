clc
clear all
close all

% add packages
addpath(genpath('C:/Users/daniel/Documents/GitHub/ATICproject/MATLAB/packages'))

% remove MATLAB directory due to compatibility problems with yalimp
% rmpath('C:/Users/daniel/Documents/MATLAB')


%% Load parameters
run('parameters')

%% Linearize normalized car plant
sys_P_car = 'P_car';

sys_P_car = linmod('P_car',[0,0,0,0],0);
%sys_P_car.StateName
%sys_P_car.OperPoint.x
A_P = sys_P_car.a;
B_P = sys_P_car.b;
C_P = sys_P_car.c;
D_P = sys_P_car.d;
P_car = ss(A_P,B_P,C_P,D_P);
%[a,t] = step(P_car,0.2);

omega = logspace(-4,3,250);
P_car_f = frd(P_car,omega);

figure(1)
subplot(2,1,1)           
loglog(abs(P_car_f(1,1)));
axis([min(omega),max(omega),1e-5,10])
grid
legend('rho <- alpha')
xlabel('Frequency [rad/sec]')
ylabel('Magnitude')

r2d = 180/pi;

subplot(2,1,2)
semilogx(r2d*unwrap(angle(P_car_f(1,1))))
grid
xlabel('Frequency [rad/sec]')
ylabel('Phase [deg]')
title('Nominal model')


%% Perturbation weights

% Output multiplicative perturbation weights
s = tf('s');
W_rho = 0.5*s/(1 + 0.25*s);             % height response


%   -------------- performance weights ----------------------

%  Noise weights
W_rhon = 0.01;
W_rhon = ss(W_rhon);      % convert to state-space

%   Disturbance weights
W_rhod = 2.5/(500*s+1);      % low frequency disturbance

%   Performance weights
W_rhoperf = 20/(600*s+1);

%  Actuator penalties
W_alphaperf = 0.04*(1+40*s)/(1+0.1*s);

% Calculate frequency response
W_rho_f = frd(W_rho,omega);
W_rhon_f = frd(W_rhon,omega);
W_rhod_f = frd(W_rhod,omega);
W_rhoperf_f = frd(W_rhoperf,omega);
W_alphaperf_f = frd(W_alphaperf,omega);

% Plot pertubations
figure(2)
subplot(1,1,1)
loglog(abs(W_rho_f),'-.',...
    abs(W_rhon_f),'-.',...
    abs(W_rhod_f),'-.',...
    abs(W_rhoperf_f),'-.',...
    abs(W_alphaperf_f),'-.')
grid
legend('W_{rho}','W_{noise}','W_{disturbances}','W_{rho,perf}','W_{alpha,perf}')
xlabel('Frequency [rad/sec]')
ylabel('Magnitude')
title('Perturbation weights')

%     ---------------- interconnection structure ------------

%    The interconnection structure has the following i/o
%    connections.   The numbers corrrespond to the port
%    numbers on the simulink block diagram.  The letters
%    correspond to:
%                            ________
%                            |       |
%      Delta inputs:  z  <---|       |<--- v:  Delta output
%                            |       |
%      cost/errors:   e  <---|   P   |<--- w:  exogenous inputs
%                            |       |
%      measurements:  y  <---|       |<--- u:  control actuation
%                            |_______|
%
%
%                       Outputs     Inputs
%
%    Delta1 (rho)         z1          v1
%
%    rho tracking err     e2          w2  rho noise
%    alpha act penalty    e3          w3  rho reference
%                                     w4  rho disturbance
%
%    rho reference        y4          u5  alpha command
%    rho measurement      y5
%
%    The controller will have 1 input and 1 output.  Note
%    the positive feedback is assumed in the implementation
%    of the controller.

[A_P,B_P,C_P,D_P] = linmod('model_car');
P = ss(A_P,B_P,C_P,D_P);

%    Create indices for each block.

Iz = [1:1]';
Iv = [1:1]';
Ie = [2:3]';
Iw = [2:4]';
Iy = [5:5]';
Iu = [5:5]';

%    define dimensions for each

nz = length(Iz);
nv = length(Iv);
ne = length(Ie);
nw = length(Iw);
nmeas = length(Iy);
nctrl = length(Iu);

%    Define block structures for each problem.  See the 
%    mussv documentation for the format.

RS_blk = [1,1;
          1,1;
	  1,1;
	  1,1];
NP_blk = [6,4];
RP_blk = [RS_blk;NP_blk];

%     ----------------  nominal design -----------------------

Pnomdesign = P([Ie;Iy],[Iw;Iu]);    % select [e;y] <- [w;u]

Pnomdesign = minreal(Pnomdesign);   % remove unobservable/uncontrollable
                                    % states.
				     
[Knom,Gnom,gamma,info] = hinfsyn(Pnomdesign,nmeas,nctrl,...
                         'METHOD','ric',...   % Riccati solution
			 'DISPLAY','on',...   % verbose
			 'TOLGAM',0.1);       % gamma tolerance
			    
%  Check this design and see if we are happy with this as the best
%  possible nominal performance.  At this stage we should retune
%  the weights depending of frequency responses, step response,
%  etc.

clp_eig = eig(Gnom);
fprintf('Max real part weighted closed loop eig = %g',...
          max(real(clp_eig)));
if max(real(clp_eig)) > -eps,
  fprintf('  UNSTABLE !\n\n');
else
  fprintf('  (stable)\n\n');
end

L_s = tf(Knom) * tf(P_car);
T_s = L_s / (1+L_s);

figure
h = sigmaplot(T_s);
grid on
% gamma = sqrt(eta)

eta = gamma^2








break;



%% Linearize System

for i=1:1

% Define system
sys_plant = 'model';

% Linearize around operating point
sys_struct = linmod(sys_plant,[0,0,0,0],0);
sys_struct.StateName
sys_struct.OperPoint.x

A_P = sys_struct.a;
B_P = sys_struct.b;
C_P = sys_struct.c;
D_P = sys_struct.d;

P = ss(A_P,B_P,C_P,D_P);
[a(:,i),t] = step(P,0.2);
end

figure
plot(t,a(:,1))
hold on
plot(t,a(:,11),'LineWidth',5)
title('Set of pertubations')
xlabel('Time [s]')
ylabel('Pendulum angle \rho [rad]')

obsv(A_P,C_P)
rank(ctrb(P))
ctrb(P)

figure
bode(P)
grid on





break;

%sim('steering',10)
% 
% load_system(sys);
% 
% paramNameValStruct.StopTime       = '2';  
% simOut = sim(sys,paramNameValStruct)
% 
% 
% sys_plant = 'model/Plant';
% 
% sim(sys)
% 
% %Trans = tf(P);
% figure
% subplot(1,2,1)
% plot(forces.Time,forces.Data(:,1))
% subplot(1,2,2)
% plot(forces.Time,forces.Data(:,1))
% 
% figure
% plot(tho)


%findop(sys)









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

figure
bode(P)
grid on




sim('model',3)

%Trans = tf(P);
figure
subplot(2,2,1)
plot(alpha.Time,alpha.Data(:,1),alpha_des.Time,alpha_des.Data(:,1))
title('alpha_d_e_s vs alpha')
legend(['sys';'ref'])
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
