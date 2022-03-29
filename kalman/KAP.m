
% kalman predictor 
function [P,V,A,Xk_1_bf,Pk_bf] = KAP(pos,time)


% fare il check
Ts = mean(diff(time));


Ad = [ 1 Ts Ts^2/2; 
       0 1 Ts; 
       0 0 1];
Bd = [Ts^3/6 Ts^2/2 Ts]';
Cd = [1 0 0];

Y(:,1) = pos;  



% E[x_(k+1)|Y^k]
% E[y_(k+1)|Y^k]

Q = (Bd*Bd')*10^3;
R= 0.05;


Pk = eye(3)*100;
Xk = [0 0 0]';
Kgain = [0 0 0]';
Xk_1_bf = zeros(3,1);
%%
for i = 1:length(Y)
    
   % 1. Project the state ahead
    Xk_prev = Ad * Xk;  
    
    % 2. Project the error covariance ahead
    Pk_prev = Pk;
    Pk = Ad * Pk_prev * Ad' - Ad * Kgain * Cd * Pk_prev * Ad' + Q;  
    Pk_bf(:,i) = Pk(:);

    tmp = inv(Cd * Pk_prev * Cd' + R);   
    
    % 3. compute the Kalman gain
    Kgain = Ad*(Pk_prev * Cd')*tmp;       
    
    % 4. update the estimate with measurement Yk
    Xk = Xk_prev + Kgain * (Y(i,1) - Cd * Xk_prev);
    Xk_1_bf(:,i) = Xk;    

    
    
end

P = Xk_1_bf(1,:);
V = Xk_1_bf(2,:);
A = Xk_1_bf(3,:);

end
