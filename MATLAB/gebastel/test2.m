clc
clear all
close all


w = 20;
z = 0.5;

P_alpha = tf(w^2,[1 2*z*w w^2]);
bode(P_alpha)


Pss = ss(P_alpha);
A=Pss.a;
B=Pss.b;
C=Pss.c;
D=Pss.d;

[u,t] = gensig('square',4,10,0.001);


A = [0 1;
    -w^2 -2*w*z]

B = [0;w^2]

C = [1 0]

D = 0;
bla = ss(A,B,C,D)


lsim(Pss,u,t) 
step(Pss)



%% Test F_z

m = 1.2;
lw = 0.3;
vRR = 1;

aF = 10/360*2*pi
aR = -3/360*2*pi


psi = vRR/lw*sin(aF-aR)/cos(aR)

F_z = m*vRR^2/lw*sin(aF-aR)/cos(aF)