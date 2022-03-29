function B = Adaptive(X,Y,g,B0,Ts)


BkA = B0;
e = [Y(1) - X(1,:)*BkA(:,1)];

for k = 1:size(X,1)-1
    
    
    e(k+1,:) = Y(k) - X(k,:)*BkA(:,k);
    BkA(:,k+1) = BkA(:,k) + (g*Ts*X(k+1,:)*e(k+1,:))';
%     grad(:,k) = -2*X(k,:)'*e(k,:);

end

B = BkA(:,end);