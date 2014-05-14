function[vec_I]=q_vec_transform(q_IB,vec_B) %#codegen

coder.inline('always');

% transforms vector in B-frame to vector in I-frame by applying
% transformation q_IB

q_IB_inv=q_inv(q_IB);

vec_I=q_product(q_product(q_IB,[0;vec_B]),q_IB_inv);

vec_I=[vec_I(2) vec_I(3) vec_I(4)]';

