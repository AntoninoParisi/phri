clear
data = readtable('DATA_motors_pHRI/master_slave_1kHz.txt');
Ts = mean(diff(data.TIME));

data = data(428:end,:);

%%

[pos,vel,acc] = KFA(data.M_POS,data.TIME);
[pos1,vel1,acc1] = KFA_ss(data.M_POS,data.TIME);
[pos2,vel2,acc2] = KAP(data.M_POS,data.TIME);
[pos3,vel3,acc3] = KSmoother(data.M_POS,data.TIME);

%% euler approx
eul_vel = [];
eul_vel = diff(data.M_POS)./Ts;
eul_vel = [eul_vel' 0];

%% other filter
vel_filt = lowpass(data.M_VEL,0.25,10);

eul_low = lowpass(eul_vel,0.25,10);
%% result plot

% 
% plot(data.TIME,pos)
% hold on
% plot(data.TIME,data.M_POS)
% legend({'kalman filter','noisy measurement'})
% figure
% 
% 
% plot(data.TIME,vel)
% hold on
% plot(data.TIME,data.M_VEL)
% plot(data.TIME,vel_filt,'Color','Green')
% legend({'kalman filter','noisy measurement','other'})
% 
figure
plot(data.TIME,eul_vel)
hold on
plot(data.TIME,vel,'Color','Green')
plot(data.TIME,data.M_VEL,'Color','Red')
plot(data.TIME,eul_low,'Color','Black')
legend({'euler approximation','kalman','noisy measuement','Euler + low pass'})

% 
% figure
% plot(data.TIME,vel)
% hold on
% plot(data.TIME,vel1,'Color','Green')
% plot(data.TIME,vel2,'Color','Red')
% plot(data.TIME,vel3,'Color','Black')
% legend({'Kalman filter','Kalman filter steady state','Kalman predictor','Kalman smoother'})
% 
% 



%% Filter vs Predictor

[pos,vel,acc] = KFA(data.M_POS,data.TIME);
[pos1,vel1,acc1] = KAP(data.M_POS,data.TIME);

plot(data.TIME,vel,'Color','Blue','LineWidth',2)
hold on
plot(data.TIME,vel1,'Color','Red','LineWidth',2)
plot(data.TIME,data.M_VEL,'Color','Green','LineWidth',2)

legend({'kalman filter','kalman predictor','Measurement'})


figure
plot(data.TIME,acc,'Color','Blue','LineWidth',2)
hold on
plot(data.TIME,acc1,'Color','Red','LineWidth',2)

legend({'kalman filter','kalman predictor'})



%% SS Filter vs Predictor

[pos,vel,acc] = KFA_ss(data.M_POS,data.TIME);
[pos1,vel1,acc1] = KAP_ss(data.M_POS,data.TIME);


plot(data.TIME,vel,'Color','Blue','LineWidth',2)
hold on
plot(data.TIME,vel1,'Color','Red','LineWidth',2)
plot(data.TIME,data.M_VEL,'Color','Green','LineWidth',2)
legend({'kalman filter','kalman predictor','Measurement'})



figure
plot(data.TIME,acc,'Color','Blue','LineWidth',2)
hold on
plot(data.TIME,acc1,'Color','Red','LineWidth',2)

legend({'kalman filter','kalman predictor'})



%% Filter vs Smoother

[pos,vel,acc] = KFA_ss(data.M_POS,data.TIME);
[pos1,vel1,acc1] = KSmoother(data.M_POS,data.TIME);

plot(data.TIME,vel,'Color','Blue','LineWidth',2)
hold on
plot(data.TIME,vel1,'Color','Red','LineWidth',2)
plot(data.TIME,data.M_VEL,'Color','Green','LineWidth',2)

legend({'kalman filter','kalman smoother','Measurement'})



figure
plot(data.TIME,acc,'Color','Blue','LineWidth',2)
hold on
plot(data.TIME,acc1,'Color','Red','LineWidth',2)

legend({'kalman filter','kalman smoother'})






