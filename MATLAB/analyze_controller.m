%Pnom = P_test
%K = K_2lmi

function [] = analyze_controller(P,K,nctrl,nmeas,omega,name,P_pert,Iw,Ie,Iz,Iv,P_car)

% Generalized feedback interconnection of two models 
Gnom = lft(P,K,nctrl,nmeas);

% Calculate Eigenvalues
open_loop_poles = pole(P)
closed_loop_poles = pole(Gnom)

% Compute closed loop H2 gain
closed_loop_norm = norm(Gnom,2)


% Check the singular values of the weighted closed-loop.  This will
% tell us the frequency ranges where the performance is closest to 
% the specified limits.

% Create frequency-response data model
Gnom_f = frd(Gnom,omega);
% Singular value decomposition
svdGnom_f = svd(Gnom_f);


figure

subplot(2,2,1)
semilogx(svdGnom_f)
grid on
xlabel('Frequency [rad/sec]')
title(['Weighted closed-loop singular values: ', name])

subplot(2,2,2)

Grob    = lft(P_car,K,nctrl,nmeas);
step(Grob,0.2);


subplot(2,2,3)
RS_blk = [1,1];
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
legend('RS','NP','RP')
xlabel('Frequency [rad/sec]')
title('Robustness analysis')




end