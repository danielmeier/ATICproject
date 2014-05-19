vrr = 1
m = 1
l_w = 0.4
b_f = 5/360*2*pi
b_r = 3/360*2*pi

F_z = vrr^2 * m / l_w * sin(b_f - b_r)/sin(b_f)


s = tf('s');
P_act = (s^2 - 8*s + 21.3)/((2*s+1)*(s^2+8*s+21.3))
bode(P_act)