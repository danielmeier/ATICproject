
% ----------------  nominal design -----------------------

P_nom = P([Ie;Iy],[Iw;Iu]);    % select [e;y] <- [w;u]

P_nom = minreal(P_nom);   % remove unobservable/uncontrollable
                                    % states.
				     
[K_nom,Gnom,gamma,info] = hinfsyn(P_nom,nmeas,nctrl,...
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