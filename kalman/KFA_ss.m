
function [P,V,A] = KFA_ss(pos,time)

Ts = mean(diff(time));


Ad = [ 1 Ts Ts^2/2; 
        0 1 Ts; 
        0 0 1];
Bd = [Ts^3/6 Ts^2/2 Ts]';
Cd = [1 0 0];

Y(:,1) = pos;  



Q = eye(3)/1000;
R= 0.005;

Pk = idare(Ad',Cd',Q,R); % riccati equation solver
Xk = [0 0 0]';
Xk_bf = zeros(3,1);
Kgain = (Pk * Cd')*pinv(Cd * Pk * Cd' + R);

%%
for i = 2:length(Y)
    
    % 1. Project the state ahead
    Xk_prev = Ad * Xk + Bd;%+Bd;%+ Bd*Kgain'*Xk;              
    
    % 2. update the estimate with measurement Yk
    Xk = Xk_prev + Kgain * (Y(i,1) - Cd * Xk_prev);
    Xk_bf(:, i) = Xk;             
    
    % 3. Update the error Covariance
%     Pk = Pk - Kgain * Cd * Pk;   % Pk = (I - Kgain*Cp)Pk_prev
%     Pk_bf(:,i) = Pk(:);
    
end

P = Xk_bf(1,:);
V = Xk_bf(2,:);
A = Xk_bf(3,:);

end
