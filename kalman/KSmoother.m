function [P,V,A] = KSmoother(pos,time)


Ts = mean(diff(time));


Ad = [ 1 Ts Ts^2/2; 
       0 1 Ts; 
       0 0 1];
Bd = [Ts^3/6 Ts^2/2 Ts]';
Cd = [1 0 0];

% forward

[~,~,~,Xk_bf,Pk_bf] = KFA(pos,time);
[~,~,~,Xk_bf_1,Pk_bf_1] = KAP(pos,time);


% backward
Xs = zeros(3,size(Xk_bf,2));
Xs(:,end) = Xk_bf(:,end);
Pk_n = eye(3)*0;
K = reshape(Pk_bf(:,end),[3 3]) * Ad' * pinv(reshape(Pk_bf_1(:,end),[3 3]));

for i = length(Xk_bf)-1:-1:1
    Xs(:,i) = Xk_bf(:,i) + K*(Xs(:,i+1) - Xk_bf_1(:,i));
    
    Pk_n = reshape(Pk_bf(:,i),[3 3]) + K * (Pk_n - reshape(Pk_bf(:,i+1),[3 3]));
    
    K = reshape(Pk_bf(:,i),[3 3]) * Ad' * pinv(reshape(Pk_bf_1(:,i),[3 3]));
end


P = Xs(1,:);
V = Xs(2,:);
A = Xs(3,:);


end