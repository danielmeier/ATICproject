%% Simulation parameters

m_car = 1.2; % [kg]
v_R = 1; % [m/s]
g = 9.81; %[m/s^2]
l_w = 0.30; % [m]
w_z = 1.0;
w_w = 40;
%w_z = 1.5;
%w_w = 250;

h_CG = 0.050;
l_p = sqrt(0.115^2 + h_CG^2); %0.25; % [m]


alphaF_offset = -3/360*2*pi;
alphaR_offset = -3/360*2*pi;



% Find operation point
phi_geom = asin(h_CG/l_p);

phi_roll_operating = pi/2-phi_geom;
phi_roll_operating_degree = phi_roll_operating/2/pi*360;


% Determine Angle Mapping
clear alphaF alphaR beta_F beta_R
alphaF = [-20/360*2*pi : 1/360*2*pi : 20/360*2*pi];
alphaR = 0;
rho = phi_roll_operating;
for ii = 1:size(alphaF,2)
    [beta_F(ii), beta_R(ii)] = calculate_angles(alphaF_offset + alphaF(ii),alphaR_offset+alphaR,rho);
end

% Fit linear model
pf_mapping_1st_FR = polyfit(alphaF,beta_F,1);
pf_mapping_1st_RR = mean(beta_R);

clear alphaF alphaR rho ii beta_F beta_R linearization