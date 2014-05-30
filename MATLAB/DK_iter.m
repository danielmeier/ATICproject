%% DK-Iteration
disp('DK-iteration...')
[Dl0,Dr0] = mussvunwrap(muinfo0);
% TODO maybe mussvextract(muinfo) helps???


figure
subplot(2,3,1)
loglog(Dl0(1,1),'r-',Dl0(2,2),'b-')
grid
xlabel('Frequency [rad/sec]');
legend('D0(1,1)','D0(2,2)')
title('mu iteration 1: D scales (not normalized)')

D0_perf = Dl0(2,2);
D0_1 = Dl0(1,1)/D0_perf;



subplot(2,3,4)
loglog(D0_1,'r-')
grid
xlabel('Frequency [rad/sec]');
legend('D0(1,1)')
title('mu iteration 1: D scales (normalized so D_{perf} = I)')

DMDi = Grob_f;
DMDi(1,:)   = D0_1 * DMDi(1,:);

DMDi(:,1)   = DMDi(:,1)/D0_1;


% bnd1    = svd(DMDi);
% figure(i)
% i=i+1;
% semilogx(muRP(1), bnd1(1))

D0_1a  = fitfrd(genphase(D0_1),0);
D0_1b  = fitfrd(genphase(D0_1),1);
D0_1c  = fitfrd(genphase(D0_1),2);
D0_1d  = fitfrd(genphase(D0_1),3);

D0_1a_f = frd(D0_1a,omega);
D0_1b_f = frd(D0_1b,omega);
D0_1c_f = frd(D0_1c,omega);
D0_1d_f = frd(D0_1d,omega);

subplot(2,3,2)

loglog(D0_1, D0_1a_f,D0_1b_f,D0_1c_f,D0_1d_f)
legend('D0_1', '0-th order fit','1st order fit', '2nd order fit', '3rd order fit')

%  Compare each fit by seeing how much it affects the
%  mu upper bound.

DMDi_a = DMDi;
DMDi_a(1,:) = D0_1a_f*DMDi_a(1,:)/D0_1;   
DMDi_a(:,1) = D0_1*DMDi_a(:,1)/D0_1a_f;
bnd_1a = svd(DMDi_a);
bnd_1a = bnd_1a(1);              % select max svd

DMDi_b = DMDi;
DMDi_b(1,:) = D0_1b_f*DMDi_b(1,:)/D0_1;   
DMDi_b(:,1) = D0_1*DMDi_b(:,1)/D0_1b_f;
bnd_1b = svd(DMDi_b);
bnd_1b = bnd_1b(1);              % select max svd

DMDi_c = DMDi;
DMDi_c(1,:) = D0_1c_f*DMDi_c(1,:)/D0_1;   
DMDi_c(:,1) = D0_1*DMDi_c(:,1)/D0_1c_f;
bnd_1c = svd(DMDi_c);
bnd_1c = bnd_1c(1);              % select max svd

DMDi_d = DMDi;
DMDi_d(1,:) = D0_1d_f*DMDi_d(1,:)/D0_1;   
DMDi_d(:,1) = D0_1*DMDi_d(:,1)/D0_1d_f;
bnd_1d = svd(DMDi_d);
bnd_1d = bnd_1d(1);              % select max svd


subplot(2,3,3)
semilogx(muRP(1),'k-',bnd_1a,'b-',bnd_1b,'g-',...
         bnd_1c,'r-',bnd_1d,'c-')
xlabel('Frequency [rad/sec]')
grid
legend('D0_1','n=0','n=1','n=2','n=3')
title('mu iteration 1: Dscale #1: mu bounds for fit orders')


% D0_2a  = fitfrd(genphase(D0_2),0);
% D0_2b  = fitfrd(genphase(D0_2),1);
% D0_2c  = fitfrd(genphase(D0_2),2);
% D0_2d  = fitfrd(genphase(D0_2),3);
% 
% D0_2a_f = frd(D0_2a,omega);
% D0_2b_f = frd(D0_2b,omega);
% D0_2c_f = frd(D0_2c,omega);
% D0_2d_f = frd(D0_2d,omega);
% subplot(2,3,5)
% loglog(D0_2, D0_2a_f,D0_2b_f,D0_2c_f,D0_2d_f)
% legend('D0_2', '0-th order fit','1st order fit', '2nd order fit', '3rd order fit')
% 
% %  Compare each fit by seeing how much it affects the
% %  mu upper bound.
% 
% DMDi_a = DMDi;
% DMDi_a(2,:) = D0_2a_f*DMDi_a(2,:)/D0_2;   
% DMDi_a(:,2) = D0_2*DMDi_a(:,2)/D0_2a_f;
% bnd_2a = svd(DMDi_a);
% bnd_2a = bnd_2a(1);              % select max svd
% 
% DMDi_b = DMDi;
% DMDi_b(2,:) = D0_2b_f*DMDi_b(2,:)/D0_2;   
% DMDi_b(:,2) = D0_2*DMDi_b(:,2)/D0_2b_f;
% bnd_2b = svd(DMDi_b);
% bnd_2b = bnd_2b(1);              % select max svd
% 
% DMDi_c = DMDi;
% DMDi_c(2,:) = D0_2c_f*DMDi_c(2,:)/D0_2;   
% DMDi_c(:,2) = D0_2*DMDi_c(:,2)/D0_2c_f;
% bnd_2c = svd(DMDi_c);
% bnd_2c = bnd_2c(1);              % select max svd
% 
% DMDi_d = DMDi;
% DMDi_d(2,:) = D0_2d_f*DMDi_d(2,:)/D0_2;   
% DMDi_d(:,2) = D0_2*DMDi_d(:,2)/D0_2d_f;
% bnd_2d = svd(DMDi_d);
% bnd_2d = bnd_2d(1);              % select max svd
% 
% 
% subplot(2,3,6)
% semilogx(muRP(1),'k-',bnd_2a,'b-',bnd_2b,'g-',...
%          bnd_2c,'r-',bnd_2d,'c-')
% xlabel('Frequency [rad/sec]')
% grid
% legend('D0_2','n=0','n=1','n=2','n=3')
% title('mu iteration 1: Dscale #2: mu bounds for fit orders')


sysD0 = zeros(1,1);   %% FIXME generic
sysD0 = ss(sysD0);
sysDi0 = zeros(1,1);   %% FIXME generic
sysDi0 = ss(sysDi0);
sysD0(1,1) = D0_1d; % choose 3rd order
sysDi0(1,1) = inv(D0_1d);
%sysD0(2,2) = D0_2a;
%sysDi0(2,2) = inv(D0_2a);

% remove alles mit D0_2...
% K-iteration (inclusive v-->z)


D0h = [sysD0, zeros(length(Iz),length(Ie)+nmeas);...
    zeros(length(Ie),length(Iz)), eye(length(Ie),length(Ie)), zeros(length(Ie),nmeas);...
    zeros(nmeas, length(Iz)+length(Ie)), eye(nmeas,nmeas)];

D0hi =  [sysDi0, zeros(length(Iv), length(Iw)+nctrl);...
    zeros(length(Iw),length(Iv)),eye(length(Iw),length(Iw)), zeros(length(Iw),nctrl);...
    zeros(nctrl,length(Iv)+length(Iw)),eye(nctrl,nctrl)];

Pmu1design= D0h * P * D0hi;