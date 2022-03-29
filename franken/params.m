% Sample parameters for four channel bilateral teleoperation
clear all;
close all;



% Low pass frequency cuff off
Fip = 1;


% Human intention controller (PI)
Ph = 25;
Dh = 10;



% Slave controller
Bs = 50;
Ks = 100;

% Master controller
Bm = 50;
Km = 100;

% Intertia of robot dynamics
Mm = 0.5;
Ms = 2;

% Make the real pole with re<0 to change the inertia of the robot
% dynamics verify this value by adding them to the simulink model
% Dm = 5;
% Ds = 10;
Dm = 0;
Ds = 0;

% Human impedance parameters
Jh = 0.5;
Bh = 20;
Kh = 50;

% Environment impedance parameters
Je = 0;
Be = 0; %100;
Ke = 20;

Ts = 0.001;



% tank values


H_d = 1;
beta = 0.25;
alpha = 0.55;
delay = 1;




