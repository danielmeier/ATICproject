% Output multiplicative perturbation weights
s = tf('s');
W_rho = ss(0.05);% 0.5*s/(1 + 0.25*s);


%   -------------- performance weights ----------------------

%  Noise weights
W_rhon = 0.05;  % 1=10 degrees > 0.05 equals 0.5 degrees
W_rhon = ss(W_rhon);      % convert to state-space

%   Disturbance weights
W_rhod = 2.5/(5*s+1);      % low frequency disturbance

%   Performance weights
W_rhoperf = 10/(10*s+1);

%  Actuator penalties
W_alphaperf = 0.04*(1+0.4*s)/(100+0.1*s);

% Calculate frequency response
W_rho_f = frd(W_rho,omega);
W_rhon_f = frd(W_rhon,omega);
W_rhod_f = frd(W_rhod,omega);
W_rhoperf_f = frd(W_rhoperf,omega);
W_alphaperf_f = frd(W_alphaperf,omega);

% Plot pertubations
figure
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
title('Perturbation and perfornace weights')
grid off