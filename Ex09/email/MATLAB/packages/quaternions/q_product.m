function[q_c]=q_product(q_a,q_b) %#codegen

coder.inline('always');

% takes in 2 quaternions (vertical vector with 4 elements) and gives out
% the quaternion product of these two.


mue_a=q_a(1);
mue_b=q_b(1);
eta_a=q_a(2:4);
eta_b=q_b(2:4);

q_c=[mue_a*mue_b - eta_a'*eta_b;
    mue_a*eta_b + mue_b*eta_a + cross(eta_a,eta_b)];

end