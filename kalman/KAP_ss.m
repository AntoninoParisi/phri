
% kalman predictor 
function [P,V,A,Xk_1_bf] = KAP_ss(pos,time)


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

Q = eye(3)/1000;
R= 0.005;


Pk = idare(Ad',Cd',Q,R); % riccati equation solver
Xk = [0 0 0]';
Xk_1_bf = zeros(3,1);
Kgain = Ad*Pk*Cd'*pinv(Cd * Pk * Cd' + R);  

%%
for i = 1:length(Y)-1
    
    % 1. Project the state ahead
    Xk_prev = Ad * Xk;
        
    % 2. update the estimate with measurement Yk+1
    Xk = Xk_prev + Kgain * (Y(i+1,1) - Cd * Xk_prev);
    Xk_1_bf(:, i+1) = Xk;     
    
    
end

P = Xk_1_bf(1,:);
V = Xk_1_bf(2,:);
A = Xk_1_bf(3,:);

end
