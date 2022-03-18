function [dat]=simulate_YKM(n, p, q)
    if nargin<1
        n=500;
        q=500;
        p=500;
    end

 sigmaj=sqrt(1/q);
 sigmae=sqrt(1);
 sigmaa=sqrt(1/p);
 sigmab=sqrt(1/q);
    M=zeros(n, p);
    Z=normrnd(0, 1, n, q);
    Z=Z-mean(Z); %center each column of Z

    for j = 1:p
        M(:,j)=Z*normrnd(0, sigmaj,q,1)+normrnd(0,sigmae, n, 1);
    end
    
    M=M-mean(M); %center each column of M
    Y=M*normrnd(0, sigmaa, p, 1)+ Z*normrnd(0, sigmab, q, 1) + normrnd(0, sigmae, n, 1);
    dat.Y=Y-mean(Y);
    
    dat.KM=M*M'/p;
    dat.KZ=Z*Z'/q;
    
end