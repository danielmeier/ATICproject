% ATIC
clc
clear all
close all

WHEEL_FL = 1;
WHEEL_FR = 2;
WHEEL_RL = 3;
WHEEL_RR = 4;

wheelStruct = struct(...
    'C_x_W', nan, ...
    'I_x_W', nan, ...
    'q_CW', nan, ...
    'q_IW',nan, ...
    'I_rn_W',nan, ...
    'dir',nan, ...
    'touchpoint',nan);


%% Degrees of Freedom

Car.I_x_C = [0.5;0;0];
Car.roll_angle = 68/360*2*pi;
Car.yaw_angle = 00/360*2*pi;
Car.steering_angle = 40/360*2*pi;

% steering_vec = -30/360*2*pi : 1/360*2*pi : 30/360*2*pi;
% roll_vec = 0 : 1/360*2*pi : 90/360*2*pi;
% 
% for ii = 1:size(steering_vec,2)
%     for jj = 1:size(roll_vec,2)
%         Car.steering_angle = steering_vec(ii);
%         Car.roll_angle = roll_vec(jj);
%% Geometry
Car.Wheel_radius = 0.037; %[mm]
Car.Wheel_width = 0.041; %[mm]

Car.Wheel(4) = wheelStruct;

Car.Wheel(WHEEL_FL).C_x_W = [0.198 -0.094 0]'; %[mm]
Car.Wheel(WHEEL_FR).C_x_W = [0.198 0.094 0]'; %[mm]
Car.Wheel(WHEEL_RL).C_x_W = [-0.104 -0.099 0]'; %[mm]
Car.Wheel(WHEEL_RR).C_x_W = [-0.104 0.099 0]'; %[mm]

Car.Wheel(WHEEL_FL).q_CW = get_rot_quaternion(0,0,Car.steering_angle);
Car.Wheel(WHEEL_FR).q_CW = get_rot_quaternion(0,0,Car.steering_angle);
Car.Wheel(WHEEL_RL).q_CW = get_rot_quaternion(0,0,3/360*2*pi);
Car.Wheel(WHEEL_RR).q_CW = get_rot_quaternion(0,0,-3/360*2*pi);

q_IC1 = get_rot_quaternion(Car.roll_angle,0,0);
q_IC2 = get_rot_quaternion(0,0,Car.yaw_angle);
Car.q_IC = q_product(q_IC2,q_IC1);

%  Calculate inertial coordinates
for i=1:4
Car.Wheel(i).q_IW = q_product(Car.q_IC,Car.Wheel(i).q_CW);
Car.Wheel(i).I_x_W = Car.I_x_C + q_vec_transform(Car.q_IC,Car.Wheel(i).C_x_W);
Car.Wheel(i).I_rn_W = q_vec_transform(Car.Wheel(i).q_IW,[0;-1;0]);

% calculate projection
normal_projection = [Car.Wheel(i).I_rn_W(1:2); 0];
crossp = -cross(Car.Wheel(i).I_rn_W,normal_projection);
Car.Wheel(i).dir = crossp/norm(crossp);

downvec = -cross(Car.Wheel(i).dir,Car.Wheel(i).I_rn_W);
Car.Wheel(i).touchpoint = Car.Wheel(i).I_x_W + downvec*Car.Wheel_radius;
end

a = Car.Wheel(2).dir
b = Car.Wheel(4).dir
Car.anglediff =  atan2(norm(cross(a,b)),dot(a,b));
Car.angleFR =  atan2(norm(cross(a,[1 0 0])),dot(a,[1 0 0]))
Car.angleRR =  atan2(norm(cross([1 0 0],b)),dot([1 0 0],b))



% res(ii,jj) = Car.anglediff;

%     end
% end
% 
% 
% figure
% subplot(1,2,1)
% surf(roll_vec',steering_vec',res)
% colorbar
% title('Effective Angle Difference of Rear- and Front Wheel Direction [rad]')
% xlabel('Vehicle Roll Angle [rad]')
% ylabel('Steering Angle [rad]')
% subplot(1,2,2)
% contour(roll_vec',steering_vec',res,30)
% colorbar
% title('Effective Angle Difference of Rear- and Front Wheel Direction [rad]')
% xlabel('Vehicle Roll Angle [rad]')
% ylabel('Steering Angle [rad]')
% break


%% Plot

I_pos = [0;0;0];

figure
axis equal
set(gca,'zdir','reverse')
set(gca,'ydir','reverse')

% Plot COS
lenvec = 0.1;
I_dir_C(:,1) = q_vec_transform(Car.q_IC,[1;0;0]);
I_dir_C(:,2) = q_vec_transform(Car.q_IC,[0;1;0]);
I_dir_C(:,3) = q_vec_transform(Car.q_IC,[0;0;1]);
mArrow3(I_pos',I_pos'+[1 0 0]*lenvec,'color','red','stemWidth',0.003); 
mArrow3(I_pos',I_pos'+[0 1 0]*lenvec,'color','green','stemWidth',0.003); 
mArrow3(I_pos',I_pos'+[0 0 1]*lenvec,'color','blue','stemWidth',0.003); 
mArrow3(Car.I_x_C',Car.I_x_C'+I_dir_C(:,1)'*lenvec,'color','red','stemWidth',0.003); 
mArrow3(Car.I_x_C',Car.I_x_C'+I_dir_C(:,2)'*lenvec,'color','green','stemWidth',0.003); 
mArrow3(Car.I_x_C',Car.I_x_C'+I_dir_C(:,3)'*lenvec,'color','blue','stemWidth',0.003); 
hold on

% Plot car
% Wheels
for i=1:4
plotCircle3D(Car.Wheel(i).I_x_W',Car.Wheel(i).I_rn_W',Car.Wheel_radius)
lenvec = 0.05;
% wheel normal vectors
%mArrow3(Car.Wheel(i).I_x_W',Car.Wheel(i).I_x_W'+Car.Wheel(i).I_rn_W'*lenvec,'color','black','stemWidth',0.002); 
mArrow3(Car.Wheel(i).touchpoint'-Car.Wheel(i).dir'*lenvec,Car.Wheel(i).touchpoint'+Car.Wheel(i).dir'*lenvec,'color','black','stemWidth',0.002);
end

grid on




