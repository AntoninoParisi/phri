% Input function parameter (sin or step with low pass filter)
clear
clc
Ts = 0.001;

% s = tf('s');

B = 1;

% Human intention controller (PI)
Ph = 2;
Dh = 0.45;

% slave vel controller

kp_s = 750;
ki_s = 30;

% Master controller
Bm = 5;
Km = 0.1;
% Cm = (Bm*s+Km)/s;
% C1_z = c2d(Cm,Ts,'tustin');


% Slave controller
Bs = 100;
Ks = 20;

% Intertia of robot dynamics
Mm = 0.5;
Ms = 2;

% Dm = 5;
% Ds = 10;
Dm = 0;
Ds = 0;

% Human impedance parameters
Jh = 0.05;
Bh = 1.5; %70
Kh = 1; % 2000

% Environment impedance parameters
Je = 0;
Be = 100; %100;
Ke = 200;

