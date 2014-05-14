function [beta_F, beta_R] = calculate_angles(alphaF,alphaR,rho)

WHEEL_FR = 1;
WHEEL_RR = 2;

Car.Wheel(WHEEL_FR).C_x_W = [0.198 0.094 0]'; %[mm]
Car.Wheel(WHEEL_RR).C_x_W = [-0.104 0.099 0]'; %[mm]

Car.Wheel(WHEEL_FR).q_CW = get_rot_quaternion(0,0,alphaF);
Car.Wheel(WHEEL_RR).q_CW = get_rot_quaternion(0,0,alphaR);

q_C_axis = get_rot_quaternion(rho,0,0);

%  Calculate inertial coordinates
for i=1:2
    Car.Wheel(i).q_IW = q_product(q_C_axis,Car.Wheel(i).q_CW);
    Car.Wheel(i).I_rn_W = q_vec_transform(Car.Wheel(i).q_IW,[0;-1;0]);

    % calculate projection
    normal_projection = [Car.Wheel(i).I_rn_W(1:2); 0];
    crossp = -cross(Car.Wheel(i).I_rn_W,normal_projection);
    Car.Wheel(i).dir = crossp/norm(crossp);
end

a = Car.Wheel(WHEEL_FR).dir;
b = Car.Wheel(WHEEL_RR).dir;

sign = cross([1 0 0],a)/norm(cross([1 0 0],a));
beta_F =  sign(3)*acos(dot(a/norm(a),[1 0 0]));
sign = cross([1 0 0],b)/norm(cross([1 0 0],b));
beta_R =  sign(3)*acos(dot([1 0 0],b/norm(b)));

if ~isfinite(beta_F)
    beta_F = 0;
end
if ~isfinite(beta_R)
    beta_R = 0;
end

%beta_F =  atan2(norm(cross(a,[1 0 0])),dot(a,[1 0 0]));
%beta_R =  atan2(norm(cross([1 0 0],b)),dot([1 0 0],b));

end