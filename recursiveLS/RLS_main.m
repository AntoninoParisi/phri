close all
clear
clc
data = readtable('DATA_motors_pHRI/master_slave_1kHz.txt');
Ts = mean(diff(data.TIME));
data = data(500:end,:);
time = data.TIME;


Y = data.M_VOLT;
Y = lowpass(Y,1,1/Ts);


% is important to have good data
[pos,vel,acc] = KSmoother(data.M_POS,data.TIME);

X(:,1) = acc;
X(:,2) = vel;





%% LS 

B = pinv(X'*X)*X'*Y;


%% RLS
% Pk = [0.1 0.2 0.1; 
%       0.2 0.1 0.1;
%       0.1 0.1 0.1];
% fare confronti con div. lambda 

% lambda = [0,1];
Pk = eye(2);
B0 = [0.02 0.1]';
lambda = 1;
[Bk,Y_H] = RLS(X,Y,B0,lambda,Pk);

%% Adaptive

g = 0.0005;
BkA = Adaptive(X,Y,g,Bk,Ts);




%% comparison

disp('LS :')
disp(B)
disp('RLS :')
disp(Bk(:,end))
disp('LS adaptive:')
disp(BkA(:,end))

%% check the model
% Y = X*B;

model1 = X*B;
model2 = Y_H';%X*Bk;
model3 = X*BkA;



% error rate Y - model = ?

err1 = Y - model1;
err2 = Y - model2;
err3 = Y - model3;



% error model check
% the error should be eq. to 0
plot(time,Y);
hold on
plot(time,err1);
legend({'Real data','LS model error'})
title('LS');

figure
plot(time,Y);
hold on
plot(time,err2);
legend({'Real data','RLS model error'})
title('RLS');

figure
plot(time,Y);
hold on
plot(time,err3);
legend({'Real data','Adaptive model error'})
title('Adaptive');

%%
figure
plot(time,Y);
hold on
plot(time,model1);
legend({'Real data','LS model'})
title('LS');


figure
plot(time,Y);
hold on
plot(time,model2);
legend({'Real data','RLS model'})
title('RLS');



figure
plot(time,Y);
hold on
plot(time,model3);
legend({'Real data','Adaptive model'})
title('Adaptive');



figure
plot(time,Y,'Color','Green','LineWidth',2);
hold on
plot(time,Y_H,'Color','Blue','LineWidth',2)
plot(time,model1,'Color','Red','LineWidth',2)
% plot(time,model3,'Color','Yellow','LineWidth',2);

legend({'Real data','RLS Y','LS Y'})
title('RLS');



%% comparison of lambda


Pk = eye(2);
B0 = [0 0]'

lambda = 0.995;
[Bk_99,Y_H_99] = RLS(X,Y,B0,lambda,Pk);

lambda = 0.9;
[Bk_9,Y_H_9] = RLS(X,Y,B0,lambda,Pk);


lambda = 0.5;
[Bk_5,Y_H_5] = RLS(X,Y,B0,lambda,Pk);

lambda = 0.1;
[Bk_1,Y_H_1] = RLS(X,Y,B0,lambda,Pk);


lambda = 0.01;
[Bk_01,Y_H_01] = RLS(X,Y,B0,lambda,Pk);




% plotting

plot(time,Y_H')
hold on
plot(time,Y_H_99')
plot(time,Y_H_9')
plot(time,Y_H_5')
plot(time,Y_H_1')
plot(time,Y_H_01')









