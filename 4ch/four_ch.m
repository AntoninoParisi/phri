% Sample parameters for four channel bilateral teleoperation
clear all;
close all;

% Input function parameter (sin or step with low pass filter)
A = 0.1;

B = 10;

% Low pass frequency cuff off
Fip = 1;
% Sin frequency
Fc = 1; 

% % Human intention controller (PI)
% Ph = 20000;
% Dh = 1000;
Ph = 20100; 
Dh = 100;
% Master controller
% Bm = 0.8*5 ;
% Km = 4;
Bm = 3.2;
Km = 4;

% Slave controller
% Bs = 0.8*5;
% Ks = 4;
Bs = 3.2;
Ks = 4;
% Intertia of robot dynamics
Mm = 0.5;
Ms = 2;

% Make the real pole with re<0 to change the inertia of the robot
% dynamics verify this value by adding them to the simulink model
% Dm = 5;
% Ds = 10;
Dm = 5;
Ds = 10;

% Human impedance parameters
Jh = 0.5;
Bh = 70;
Kh = 2000;

% Environment impedance parameters
Je = 0;
Be = 100; %100;
Ke = 200;

Ts = 0.001;

% High frequency pole
tau = 10000;

% s = tf('s');
% Zm = Mm*s+Dm;
% Zs = Ms*s+Ds;
% Cm = (Bm*s+Km)/s;
% Cs = (Bs*s+Ks)/s;
% C4 = -(Mm*s^2+(Bm+Dm)*s+Km)/s;
% C2 = 1;
% C1 = (Ms*s^2+(Bs+Ds)*s+Ks)/s;
% C3 = 1;
% D = 1/(C1+C3*Zm+C3*Cm);
% 
% H11 = (Zm+Cm)*D*(Zs+Cs-C3*C4)+C4
% H12 = -(Zm+Cm)*D*(1-C3*C2)-C2
% H21 = minreal(D*(Zs+Cs-C3*C4))
% H22 = -D*(1-C3*C2)
% 
% Zwidth = (H12*H21 - H11*H22) / (H22*H21)

% G = w_n^2/(s^2+2*w_n*xi*s+w_n^2)