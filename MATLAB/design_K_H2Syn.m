A   = A_P;
Bw  = B_P(:,Iw);
Bu  = B_P(:,Iu);
Ce  = C_P(Ie,:);
Cy  = C_P(Iy,:);
Dew = D_P(Ie,Iw);
Dyw = D_P(Iy,Iw);
Deu = D_P(Ie,Iu);
Dyu = D_P(Iy,Iu);

% H2_controller using h2syn()
P_h2syn  = ss(A,[Bw,Bu], [Ce;Cy],[Dew, Deu;Dyw,Dyu]); 

[K_h2syn, Gnom_2syn, gamma_2syn, info_2syn] = h2syn(P_h2syn, nmeas, nctrl);

