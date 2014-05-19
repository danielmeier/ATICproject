function[q_inv]=q_inv(q) %#codegen

coder.inline('always');

% This function gives out the inverse of a quaternion with the same
% dimensions as the input (no vector dimensions are changed)


q_inv=q;                % initializing

q_inv(1)=q(1);          % element changing
q_inv(2)=-q(2);
q_inv(3)=-q(3);
q_inv(4)=-q(4);
end