
disp('Designing H2 Controller, solving LMI...')

% H2-Controller solving the LMI equations, using SPD
A   = A_P;
Bw  = B_P(:,Iw);
Bu  = B_P(:,Iu);
Ce  = C_P(Ie,:);
Cy  = C_P(Iy,:);
Dew = D_P(Ie,Iw);
Dyw = D_P(Iy,Iw);
Deu = D_P(Ie,Iu);
Dyu = D_P(Iy,Iu);

P_h2lmi  = ss(A,[Bw,Bu],[Ce;Cy],[Dew,Deu;Dyw,Dyu]);
n       = size(A,1);

cvx_begin sdp
    cvx_solver sedumi
    
    variable X(n,n) symmetric;
    variable Y(n,n) symmetric;
    variable W(length(Ie),length(Ie)) symmetric;
    variable Ah(n,n);
    variable Bh(n,length(Iy));
    variable Ch(length(Iu),n);
    variable eta_2lmi
    
    minimize eta_2lmi;
    subject to
        trace(W) < eta_2lmi;
              
        0.5*(...
        [W, Ce*X + Deu*Ch, Ce;
            X*Ce'+Ch'*Deu', X, eye(n,n);
            Ce', eye(n,n),Y]+...
        [W, Ce*X + Deu*Ch, Ce;
            X*Ce'+Ch'*Deu', X, eye(n,n);
            Ce', eye(n,n),Y]') > 0; % 0.5*(X+X') to make it symmetric (rounding errors...)
        
        0.5*(...
        [A*X+Bu*Ch+X*A'+Ch'*Bu', A+Ah', Bw;
            A'+Ah, Y*A'+A'*Y+Bh*Cy+Cy'*Bh', Y*Bw+Bh*Dyw;
            Bw',Bw'*Y+Dyw'*Bh', -eye(length(Iw),length(Iw))]+...
        [A*X+Bu*Ch+X*A'+Ch'*Bu', A+Ah', Bw;
            A'+Ah, Y*A'+A'*Y+Bh*Cy+Cy'*Bh', Y*Bw+Bh*Dyw;
            Bw',Bw'*Y+Dyw'*Bh', -eye(length(Iw),length(Iw))]') < 0;  
 
cvx_end

gamma_2lmi = sqrt(eta_2lmi);

MNt = eye(n)-X*Y;
[U_MNt,S_MNt,V_MNt] = svd(MNt);

sSmn    = sqrt(diag(S_MNt));
isSmn   = 1./sSmn;

M  = U_MNt * diag(sSmn);
N  = V_MNt * diag(sSmn);

iM = diag(isSmn)*U_MNt';         % calculate inverses 
iN = diag(isSmn)*V_MNt';

Ck = Ch*iM';
Bk = iN*Bh;
Ak = iN*(Ah-N*Bk*Cy*X-Y*Bu*Ck*M'-Y*A*X)*iM';
Dk = zeros(length(Iu),length(Iy));
 
K_h2lmi = ss(Ak,Bk,Ck,Dk);
G_2lmi = lft(P_h2lmi,K_h2lmi);
G_2lmi_min = minreal(G_2lmi);
gamma_2lmi_ss = ss(gamma_2lmi); 