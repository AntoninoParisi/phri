function [P,V,A,Xk_bf,Pk_bf] = KFA(pos,time)

Ts = mean(diff(time));


Ad = [ 1 Ts Ts^2/2; 
       0 1 Ts; 
       0 0 1];
Bd = [Ts^3/6 Ts^2/2 Ts]';
Cd = [1 0 0];

Y(:,1) = pos;  



% E[x_(k+1)|Y^k]
% E[y_(k+1)|Y^k]

Q = (Bd*Bd')*10^2;
R= 0.0005;
Kgain = [ 0 0 0]';
Pk = eye(3)*0;
Xk = [0 0 0]';

Xk_bf = zeros(3,1);
%%
for i = 2:length(Y)
    
    % 1. Project the state ahead
    Xk_prev = Ad * Xk;  
    
    % 2. Project the error covariance ahead
    
    Pk = Ad * Pk * Ad' - Ad * Kgain * Cd * Pk * Ad' + Q;  
    Pk_bf(:,i) = Pk(:);

    tmp = inv(Cd * Pk * Cd' + R);   
    
    % 3. compute the Kalman gain
    Kgain = (Pk * Cd')*tmp;       
    
    % 4. update the estimate with measurement Yk
    Xk = Xk_prev + Kgain * (Y(i,1) - Cd * Xk_prev);
    Xk_bf(:,i) = Xk;             
    
    
end

P = Xk_bf(1,:);
V = Xk_bf(2,:);
A = Xk_bf(3,:);

end
