%Pnom = P_test
%K = K_2lmi

function [closed_loop_2norm,closed_loop_infnorm,muinfo0,Grob_f,muRP,Gclp_nom ] = analyze_controller(P,K,nctrl,nmeas,omega,name,P_pert,Iw,Ie,Iz,Iv,P_car,gamma)

SUBPLOT = 0;



% Generalized feedback interconnection of two models 
Gnom = lft(P,K,nctrl,nmeas);

% Calculate Eigenvalues
open_loop_poles = pole(P)
closed_loop_poles = pole(Gnom)

% Compute closed loop H2 gain
closed_loop_2norm = norm(Gnom,2)
closed_loop_infnorm = norm(Gnom,inf)


% Check the singular values of the weighted closed-loop.  This will
% tell us the frequency ranges where the performance is closest to 
% the specified limits.

% Create frequency-response data model
Gnom_f = frd(Gnom,omega);
% Singular value decomposition
svdGnom_f = svd(Gnom_f);


hFig = figure
set(hFig, 'Position', [300 -100 1400 800])

if SUBPLOT
    subplot(2,2,1)
else
    figure
end
semilogx(svdGnom_f)
grid on
xlabel('Frequency [rad/sec]')
title(['Weighted closed-loop singular values: ', name])

%subplot(2,2,2)
% 
% Grob    = lft(P_car,K,nctrl,nmeas);
% step(Grob,0.2);


if SUBPLOT
    subplot(2,2,3)
else
    figure
end
RS_blk = [2,2];
NP_blk = [length(Iw),length(Ie)];
RP_blk = [RS_blk;NP_blk];


%     ------------------  robust analysis -------------------------

%    We now look at the whether or not our control system is 
%    robustly stable, and whether or not is still meets the
%    performance objectives.

%    Create the robust closed-loop interconnnection using the
%    nominal design above.

Grob = lft(P_pert,K);
size(Grob)
Grob_f = frd(Grob,omega);
muRS = mussv(Grob_f(Iz,Iv),RS_blk);
%muNP = mussv(Grob_f(Ie,Iw),NP_blk);   % this is really max(svd())
muNP = svd(Grob_f(Ie,Iw));
[muRP,muinfo0] = mussv(Grob_f,RP_blk);

%  plot the mu upper bounds

semilogx(muRS(1),'r-',muNP(1),'g-',muRP(1),'b-')
grid
legend('RS','NP','RP','location','NorthWest')
xlabel('Frequency [rad/sec]')
title(['Robustness Analysis, \gamma = ',num2str(gamma,3)])





%subplot(2,2,[2,4])




%  Set up an unweighted simulation to examine this.

global K_sim

K_sim = K;      % set controller for simulink block

[Aclp,Bclp,Cclp,Dclp] = linmod('model_car_unweighted');
Gclp = ss(Aclp,Bclp,Cclp,Dclp);

%  compare the nominal closed-loop transfer functions


% outp / inp
Gclp_nom = Gclp(3:4,[3:5]);
Gclp_nom = minreal(Gclp_nom);    % remove perturbation weight states.

%  Check stability (always wise!)

clp_eig = eig(Gclp_nom);
fprintf('Max real part unweighted closed loop eig = %g',...
          max(real(clp_eig)));
if max(real(clp_eig)) > -eps,
  fprintf('  UNSTABLE !\n\n');
else
  fprintf('  (stable)\n\n');
end
% 
% %   Now look at the typical closed-loop responses.
% 
% Gclp_nom_f = frd(Gclp_nom,omega);
% 
% figure(3)
% subplot(2,1,1)
% loglog(abs(Gclp_nom_f(1,1)),abs(Gclp_nom_f(1,2)),...
%        abs(Gclp_nom_f(2,1)),abs(Gclp_nom_f(2,2)));
% axis([min(omega),max(omega),1e-5,10])
% grid
% legend('h1 <- h1cmd','h1 <- t1cmd','t1 <- h1cmd','t1 <- t1cmd')
% xlabel('Frequency [rad/sec]')
% ylabel('Magnitude')
% title('Nominal command responses')
% 
% subplot(2,1,2)
% semilogx(r2d*unwrap(angle(Gclp_nom_f(1,1))),r2d*unwrap(angle(Gclp_nom_f(1,2))),...
%        r2d*unwrap(angle(Gclp_nom_f(2,1))),r2d*unwrap(angle(Gclp_nom_f(2,2))))
% grid
% xlabel('Frequency [rad/sec]')
% ylabel('Phase [deg]')
% 
% %   Noise responses
% 
% figure(4)
% subplot(1,1,1)
% loglog(abs(Gclp_nom_f(1,3)),abs(Gclp_nom_f(1,4)),...
%        abs(Gclp_nom_f(2,3)),abs(Gclp_nom_f(2,4)));
% %axis([min(omega),max(omega),1e-5,10])
% grid
% legend('h1 <- h1 noise','h1 <- t1 noise','t1 <- h1 noise','t1 <- t1 noise')
% xlabel('Frequency [rad/sec]')
% ylabel('Magnitude')
% title('Nominal noise responses')
% 
% 
% %   Disturbance responses
% 
% figure(5)
% subplot(1,1,1)
% loglog(abs(Gclp_nom_f(1,5)),abs(Gclp_nom_f(1,6)),...
%        abs(Gclp_nom_f(2,6)),abs(Gclp_nom_f(2,6)));
% %axis([min(omega),max(omega),1e-5,10])
% grid
% legend('h1 <- h1 dist.','h1 <- t1 dist.','t1 <- h1 dist.','t1 <- t1 dist.')
% xlabel('Frequency [rad/sec]')
% ylabel('Magnitude')
% title('Nominal disturbance responses')

%   Examine the step responses.   The valid height range is
%   0.15 < h1 < 0.75, and we are limited to about +/- 0.5 on
%   each of the actuators.  The operating point is close to
%   the middle of the height range.
%
%   Under these scalings it seems like a step of 0.2 is a

%   reasonable command.

tmax = 5;
dt = 0.01;
t = [0:dt:tmax]';

%   Make the step begin at 10 seconds.

ref = 0.2;
ustep = ref*(t>= 1);

[yh1step,t1] = lsim(Gclp_nom(:,2),ustep,t);    % response to h1 step command

%figure

if SUBPLOT
    subplot(2,2,2)
else
    figure
end
plot(t1,yh1step(:,1),t,ustep,'m--')
grid
axis([0,tmax,-ref/4,5*ref/4])
legend('\rho','\rho_r_e_f','location','SouthEast')
xlabel('Time [sec]')
ylabel('Outputs')
title('Nominal h1 step response')

if SUBPLOT
    subplot(2,2,4)
else
    figure
end
plot(t1,yh1step(:,2))
grid
legend('\alpha','Location','SouthEast')
xlabel('Time [sec]')
ylabel('Actuation')




% 
% %   t1 step command
% 
% [yt1step,t1] = lsim(Gclp_nom(:,2),ustep,t);  % response to t1 step command
% 
% figure(7)
% subplot(2,1,1)
% plot(t1,yt1step(:,1:2),t,ustep,'m--')
% grid
% axis([0,tmax,-ref/4,5*ref/4])
% legend('h1','t1','t1 ref')
% xlabel('Time [sec]')
% ylabel('Outputs')
% title('Nominal t1 step response')
% 
% subplot(2,1,2)
% plot(t1,yt1step(:,3:4))
% grid
% legend('fh','fc')
% xlabel('Time [sec]')
% ylabel('Actuation')
% 
% %   Disturbance response:  make a small step in level and temperature.
% %   at two different times.
% 
% hdist = 0.1;
% tdist = -0.05;
% udist = [hdist*(t>=10).*(t<=30),tdist*(t>=5).*(t<=15)];;
% 
% [ydiststep,t1] = lsim(Gclp_nom(:,[5,6]),udist,t);
% 
% figure(8)
% subplot(2,1,1)
% plot(t1,ydiststep(:,1:2),t,udist(:,1),'m--',t,udist(:,2),'y--')
% grid
% axis([0,tmax,-0.2,0.2])
% legend('h1','t1','h1 dist','t1 dist.')
% xlabel('Time [sec]')
% ylabel('Outputs')
% title('Nominal h1 & t1 disturbance response')
% 
% subplot(2,1,2)
% plot(t1,ydiststep(:,3:4))
% grid
% legend('fh','fc')
% xlabel('Time [sec]')
% ylabel('Actuation')
% 
% % Check the singular values of the weighted closed-loop.  This will
% % tell us the frequency ranges where the performance is closest to 
% % the specified limits.
% 
% Gnom_f = frd(Gnom,omega);
% svdGnom_f = svd(Gnom_f);
% 
% figure(9)
% subplot(1,1,1)
% semilogx(svdGnom_f)
% grid
% xlabel('Frequency [rad/sec]')
% title('Weighted closed-loop singular values')
% 
% %  It can also be useful to look at the frequency response of the 
% %  system as a matrix at the frequency where the singular value
% %  peak (or peaks) occur.   This tells us which inputs (columns)
% %  or outputs (rows) are dominating the objective calculation.
% 
% svddata = frdata(svdGnom_f);                   % extract data
% maxsvd = max(svddata);                      % find max svd(omega)
% maxidx = find(maxsvd == max(maxsvd));       % find index for max over omega
% 
% fprintf('Max_w svd(Gnom(jw)) occurs at w = %g [rad/sec]\n',...
%           omega(maxidx));
% fprintf('\nGnom(j%g) = \n',omega(maxidx));
% Gnom_fdata = frdata(Gnom_f);
% fmt = get(0,'format');
% format('short','e');
% disp(abs(Gnom_fdata(:,:,maxidx)))
% format(fmt)
% 
% 


end