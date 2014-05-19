function[q_AB]=get_rot_quaternion(alpha,beta,gamma) %#codegen

coder.inline('always');

% output is the rotation quaternion of a system B which is rotated about
% alpha, beta and gamma from A system

% angles in the F-system
a = alpha;
b = beta;
c = gamma;

% calculate rotation matrix and quaternion
rx = [1 0 0;0 cos(a) -sin(a);0 sin(a) cos(a)];
ry = [cos(b) 0 sin(b);0 1 0;-sin(b) 0 cos(b)];
rz = [cos(c) -sin(c) 0;sin(c) cos(c) 0; 0 0 1];
rotation = rx*ry*rz; 

q_AB = rot2quat(rotation);

