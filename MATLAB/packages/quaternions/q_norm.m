% This function normalizes a quaternion so it has the length 1. ( = unit
% quaternion)
% =========================================================================
% INPUTS
% quaternion
% 
% OUTPUTS
% normalized quaternion, has length 1
%
% =========================================================================
% Luca Mueri, mueril@ethz.ch

function[q_norm]=q_norm(in)   %#codegen

coder.inline('always');

% parameters
q=single(in(1:4));

absolute_value=sqrt(q(1)^2+q(2)^2+q(3)^2+q(4)^2);

if absolute_value==0
    q_norm=single([0 0 0 0]);
else
    q_norm=q/absolute_value;
end

end