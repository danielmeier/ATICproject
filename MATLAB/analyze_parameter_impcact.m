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

for i=1:100

%m_car = 1.2 + 0.2*randn; % [kg]
v_R = 1 + 0.2*randn; % [m/s]

[A_P,B_P,C_P,D_P] = linmod('P_car',[0,0,0,0],0);
P_car = ss(A_P,B_P,C_P,D_P);

P_car_f = frd(P_car,omega);

%res(i) = P_car_f;


res.abs(i) = abs(P_car_f(1,1));
res.angle(i) = angle(P_car_f(1,1));

disp(num2str(i))

end



figure
      
%subplot(2,1,1)
loglog(res.abs);
axis([min(omega),max(omega),1e-5,10])
grid
legend('rho <- alpha')
xlabel('Frequency [rad/sec]')
ylabel('Magnitude')
%title('Nominal model')
grid on

r2d = 180/pi;

figure

%subplot(2,1,2)
semilogx(r2d*unwrap(res.angle))
grid
xlabel('Frequency [rad/sec]')
ylabel('Phase [deg]')