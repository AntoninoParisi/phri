function [B,Y_H,B_buff] = RLS(X,Y,B0,lambda,Pk)



K = [Pk*X(1,:)'];
Bk = B0;
e = [Y(1) - X(1,:)*Bk(:,1)];
Pk_prec = Pk;

Y_H = [];

for k = 2:size(X,1)
    
    
    Pk = 1/lambda*(Pk_prec - (Pk_prec*X(k,:)'*X(k,:)*Pk_prec)/(lambda + X(k,:)*Pk_prec*X(k,:)'));

    K(:,k) = Pk*X(k,:)';
    e(k,:) = Y(k) - X(k,:)*Bk(:,k-1);
    Bk(:,k) = Bk(:,k-1) + (K(:,k)*e(k));
    Pk_prec = Pk;
    
    Y_H(:,k) = X(k,:)*Bk(:,k);

end


B = Bk(:,end);
B_buff = Bk;