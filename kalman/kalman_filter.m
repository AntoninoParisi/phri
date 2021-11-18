clear
masterslave = readtable('DATA_motors_pHRI/master_slave_2kHz.txt');

Ts = mean(diff(masterslave.TIME));


Ad = [ 1 Ts; 0 1];
Bd = [Ts^2/2 Ts]';
Cd = [1 0];

Y(:,1) = masterslave.M_POS;  
Y(:,2) = masterslave.M_VEL;   


% E[x_(k+1)|Y^k]
% E[y_(k+1)|Y^k]

Xnext = 0;
q=1000;
Q = [q 0; 0 q];
r=50000;
R = [r 0; 0 r];

Pk = [0.001 0; 0 0.001];
Pk_next = [];
Xk = [Y(1,1) Y(1,2)]';

%%
for i = 2:length(Y)
    
    % 1. Project the state ahead
    Xk_prev = Ad * Xk;          
    
    % 2. Project the error covariance ahead
    Pk_prev = Ad * Pk * Ad' + q;                  
                                   

    tmp = inv(Cd * Pk_prev * Cd' + r);   
    
    % 1. compute the Kalman gain
    Kgain = (Pk_prev * Cd')*tmp;       
    
    % 2. update the estimate with measurement Yk
    Xk = Xk_prev + Kgain' * ([Y(i,1) Y(i,2)]' - Cd * Xk_prev);
    Xk_bf(:, i) = Xk;             
    
    % 3. Update the error Covariance
    Pk = Pk_prev - Kgain * Cd * Pk_prev;   % Pk = (I - Kgain*Cp)Pk_prev
    Pk_bf(:,i) = Pk(:);
    
end


%% euler approx
vel = [];
for i = 1:length(Y)-1
    vel(i) = (Y(i,2) - Y(i+1,2)) / Ts;
        
end
vel = [vel 0];

%% other filter


vel2 = lowpass(Y(:,2),0.7,10);
%% result plot


plot(masterslave.TIME,Xk_bf(1,:))
hold on
plot(masterslave.TIME,masterslave.M_POS)
legend({'kalman filter','noisy measurement'})
figure


plot(masterslave.TIME,Xk_bf(2,:))
hold on
plot(masterslave.TIME,masterslave.M_VEL)
plot(masterslave.TIME,vel2,'Color','Green')

legend({'kalman filter','noisy measurement','other'})
figure
plot(masterslave.TIME,vel)
legend({'euler approximation'})




