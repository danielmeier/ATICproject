clc

figure
subplot(1,2,1)
plot(simout.time,simout.signals.values(:,1:2));
title('Step input on rho');
legend('rho_a_c_t','rho_r_e_f');
xlabel('Time [s]')
grid on

subplot(1,2,2)
plot(simout.time,simout.signals.values(:,3));
title('Steering angle');
legend('alpha');
xlabel('Time [s]')
grid on