
clc 
clear all

%% controller parameters

Ki = 0;
Kd = 0.4;
Kp = 60;

c = 10^10;

%% motor parameters

% electrical components
L = 0.6232;
R = 1.23;
% physical components
J = 0.005332;%0.5332;
dm = 0.1;
Km = 10;

sat = inf;