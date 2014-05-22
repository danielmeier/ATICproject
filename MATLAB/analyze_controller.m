%Pnom = P_test
%K = K_2lmi

function [] = analyze_controller(P,K,nctrl,nmeas,omega,name)

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
semilogx(svdGnom_f)
grid on
xlabel('Frequency [rad/sec]')
title(['Weighted closed-loop singular values: ', name])

end