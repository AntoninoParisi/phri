% Input function parameter (sin or step with low pass filter)
clear
clc
Ts = 0.001;

% s = tf('s');

B = 1;

% Human intention controller (PI)
Ph = 55;
Dh = 10;

% Master controller
Bm = 1;
Km = 5;
% Cm = (Bm*s+Km)/s;
% C1_z = c2d(Cm,Ts,'tustin');


% Slave controller
Bs = 5;
Ks = 140;

% Intertia of robot dynamics
Mm = 0.5;
Ms = 2;

% Dm = 5;
% Ds = 10;
Dm = 0;
Ds = 0;

% Human impedance parameters
Jh = 0.05;
Bh = 70; %70
Kh = 200; % 2000

% Environment impedance parameters
Je = 0;
Be = 15; %100;
Ke = 50;

