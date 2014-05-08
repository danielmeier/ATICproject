clc
clear all
close all

%% Load parameters
run('parameters')

%% Analyze all attitudes

alphaF = -20/360*2*pi : 1/360*2*pi : 20/360*2*pi;
alphaR = 0;
rho = 0 : 1/360*2*pi : 90/360*2*pi;

for ii = 1:size(alphaF,2)
    for jj = 1:size(rho,2)
        [beta_F(ii,jj), beta_R(ii,jj)] = calculate_angles(alphaF_offset+alphaF(ii),alphaR_offset+alphaR,rho(jj));
    end
end

figure
subplot(1,2,1)
surf(rho',alphaF',beta_F)
colorbar
title('Front wheel angle of attack [rad]')
xlabel('Vehicle Roll Angle [rad]')
ylabel('Steering Angle [rad]')
subplot(1,2,2)
contour(rho',alphaF',beta_F,30)
colorbar
title('Front wheel angle of attack [rad]')
xlabel('Vehicle Roll Angle [rad]')
ylabel('Steering Angle [rad]')

%% Analyze operating point
clear beta_F beta_R alphaF alphaR rho

alphaF = -20/360*2*pi : 1/360*2*pi : 20/360*2*pi;
alphaR = 0;
rho = [...
    phi_roll_operating-20/360*2*pi,...
    phi_roll_operating-10/360*2*pi,...
    phi_roll_operating,...
    phi_roll_operating+10/360*2*pi,...
    phi_roll_operating+20/360*2*pi,...
    ];

for ii = 1:size(alphaF,2)
    for jj = 1:size(rho,2)
        [beta_F(ii,jj), beta_R(ii,jj)] = calculate_angles(alphaF_offset+alphaF(ii),alphaR_offset+alphaR,rho(jj));
    end
end

figure
subplot(1,2,1)
plot(alphaF',beta_F')
title('Wheel angle of attack [rad]')
xlabel('Steering Angle alpha_F [rad]')
ylabel('Effective angle beta_F [rad]')
legend([...
    '\rho = \rho_0 - 20°';...
    '\rho = \rho_0 - 10°';...
    '\rho = \rho_0      ';...
    '\rho = \rho_0 + 10°';...
    '\rho = \rho_0 + 20°';...
    ])
subplot(1,2,2)
plot(alphaF',beta_R')
title('Wheel angle of attack [rad]')
xlabel('Steering Angle alpha_R [rad]')
ylabel('Effective angle beta_R [rad]')
legend([...
    '\rho = \rho_0 - 20°';...
    '\rho = \rho_0 - 10°';...
    '\rho = \rho_0      ';...
    '\rho = \rho_0 + 10°';...
    '\rho = \rho_0 + 20°';...
    ])

break