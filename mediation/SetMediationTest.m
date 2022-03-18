%%%%%%%%%%%%%%% 
%%%%Input Y: outcome varaibles. nx1 matrix
%%%%Input M: mediation variables. nxp matrix
%%%%Input Z: exposure variables. nxq matrix
function [med] = SetMediationTest(Y, KM, KZ)
    if nargin<4
        nPerm = 1000;
    end
    
    Y= Y-mean(Y); %center Y
    n=length(Y)-1;
    tau_Y=dot(Y,Y);
    tau_M=trace(KM);
    tau_Z=trace(KZ);
    tau_MZ=trace(KM*KZ);
    tau_MM=trace(KM*KM);
    tau_ZZ=trace(KZ*KZ);

    A=[tau_M tau_Z n; tau_MM tau_MZ tau_M; tau_MZ tau_ZZ tau_Z];
    sum_sigmaj=(tau_Z*tau_M-n*tau_MZ)/(tau_Z^2-n*tau_ZZ)

    tau_YM=Y'*KM*Y; %% changes in Boostraped or permuted samples
    tau_YZ=Y'*KZ*Y; %% changes in Boostraped or permuted samples
    vec_Y=[tau_Y; tau_YM; tau_YZ]; 
    vec_sigma=inv(A)*vec_Y
    med.prop=sum_sigmaj*vec_sigma(1)/(sum_sigmaj*vec_sigma(1)+vec_sigma(2));

    %permutation to obtain p-value
    med_prop_perm=zeros(nPerm,1);
    for i=1:nPerm
        Y=Y(randperm(n+1));
        tau_YM=Y'*KM*Y; %% changes in Boostraped or permuted samples
        tau_YZ=Y'*KZ*Y; %% changes in Boostraped or permuted samples
        vec_Y=[tau_Y; tau_YM; tau_YZ]; 
        vec_sigma=inv(A)*vec_Y;
        med_prop_perm(i)=sum_sigmaj*vec_sigma(1)/(sum_sigmaj*vec_sigma(1)+vec_sigma(2));
    end
    med.Pvalue= (sum(med_prop_perm>med.prop)+1)/(nPerm+1);
end

