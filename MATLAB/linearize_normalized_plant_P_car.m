[A_P,B_P,C_P,D_P] = linmod('P_car',[0,0,0,0],0);
P_car = ss(A_P,B_P,C_P,D_P);

figure
P_car_f = frd(P_car,omega);

subplot(2,2,[1 3])
step(P_car,0.2);

subplot(2,2,2)           
loglog(abs(P_car_f(1,1)));
axis([min(omega),max(omega),1e-5,10])
grid
legend('rho <- alpha')
xlabel('Frequency [rad/sec]')
ylabel('Magnitude')

r2d = 180/pi;

subplot(2,2,4)
semilogx(r2d*unwrap(angle(P_car_f(1,1))))
grid
xlabel('Frequency [rad/sec]')
ylabel('Phase [deg]')
title('Nominal model')