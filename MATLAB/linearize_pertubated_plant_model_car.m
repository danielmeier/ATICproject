%     ---------------- interconnection structure ------------

%    The interconnection structure has the following i/o
%    connections.   The numbers corrrespond to the port
%    numbers on the simulink block diagram.  The letters
%    correspond to:
%                            ________
%                            |       |
%      Delta inputs:  z  <---|       |<--- v:  Delta output
%                            |       |
%      cost/errors:   e  <---|   P   |<--- w:  exogenous inputs
%                            |       |
%      measurements:  y  <---|       |<--- u:  control actuation
%                            |_______|
%
%
%                       Outputs     Inputs
%
%    Delta1 (rho)         z1          v1
%    Delta2 (alpha)       z2          v2
%
%    rho tracking err     e3          w3  rho noise
%    alpha act penalty    e4          w4  rho reference
%                                     w5  rho disturbance
%
%    rho reference        y5          u6  alpha command
%    rho measurement      y6
%
%    The controller will have 1 input and 1 output.  Note
%    the positive feedback is assumed in the implementation
%    of the controller.

sys_P_car = linmod('model_car');
A_P = sys_P_car.a;
B_P = sys_P_car.b;
C_P = sys_P_car.c;
D_P = sys_P_car.d;

%[A_P,B_P,C_P,D_P] = linmod('model_car');
P = ss(A_P,B_P,C_P,D_P);

%    Create indices for each block.
Iz = [1:2]';
Ie = [3:4]';
Iy = [5:6]';

Iv = [1:2]';
Iw = [3:5]';
Iu = [6:6]';

%    define dimensions for each
nz = length(Iz);
nv = length(Iv);
ne = length(Ie);
nw = length(Iw);
nmeas = length(Iy);
nctrl = length(Iu);


