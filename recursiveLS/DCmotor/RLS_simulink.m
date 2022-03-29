
% clear

time = out.tout;
Ts = mean(diff(time));
B_real = [0.005332 0.1 10]';
% if i trucate the position values then the spring value (k) is spread to other
% 2 thetas
X(:,1) = lowpass(out.acc1.Data,50,1/Ts);%out.M_VEL;
X(:,2) = lowpass(out.vel1.Data,50,1/Ts);%out.M_POS;
X(:,3) = lowpass(out.pos1.Data,5,1/Ts);%out.M_POS;

% [pos,vel,acc] = KFA(out.pos1.Data,time);
% X(:,1) = acc;
% X(:,2) = vel;

Y = out.volt1.Data;
% Y = lowpass(Y,20,1/Ts);








%% LS 

B = pinv(X'*X)*X'*Y;


%% RLS

Pk = eye(3);

[Bk,Y_H] = RLS(X,Y,[0 0 0]',1,Pk);


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

model1 = X*B; % LS
model2 = Y_H'; % RLS
model3 = X*BkA(:,end); % adaptive

m_real = X * B_real;

% error rate =  Y - model 

err1 = Y - model1;
err2 = Y - model2;
err3 = Y - model3;



% error model check
% the error should be eq. to 0
plot(time,Y);
hold on
plot(time,model1);
legend({'Real out','LS model error'})
title('LS');

figure
plot(time,Y);
hold on
plot(time,model2);
legend({'Real out','RLS model error'})
title('RLS');

figure
plot(time,Y);
hold on
plot(time,model3);
legend({'Real out','Adaptive model error'})
title('Adaptive');

clear X Y






