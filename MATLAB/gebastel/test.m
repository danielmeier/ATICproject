clc
clear all
close all


w = 20;
z = 0.5;

A = [0 1;
    -w^2 -2*w*z]

B = [0;w^2]

C = [1 0]

D = 0;

x = [0;0]

u = 1

dt = 0.001
for i=2:10
    x(:,i) = dt*(A*x(:,i-1) + B*u);
end
figure
plot(x(1,:))
hold on
plot(x(2,:))

figure
plot(x)

P_alpha = tf(w^2,[1 2*z*w w^2]);
bode(P_alpha)


Pss = ss(P_alpha);
A=Pss.a;
B=Pss.b;
C=Pss.c;
D=Pss.d;

u = (ones(1,1001))'
t = (0:0.001:1)'

lsim(Pss,u,1) 

x = [1;1]
dt = 0.001
for i=2:1000
    x(:,i) = dt*(A*x(:,i-1) + B*u);
end
figure
plot(x(1,:))
hold on
plot(x(2,:))


opspec = operspec('steering')

%opspec = addoutputspec(opspec,'scdspeed/rad//s to rpm',1);


op(1) = findop('steering',opspec);

io(1) = linio('steering/aSP',1,'input');
io(2) = linio('steering/a',1,'output');

sys = linearize('steering',io);
bodemag(sys)
