%This function shows how to use the SetMediationtest function
%by Zhaoxia Yu. 
%mydat=simulate_YKM(1000,100,100);
mydat=simulate_YKM();

%the SetMediationTest function that returns estimate of proportion of mediation and the
%associated p-value
%Input variables:
%%%%Input Y: outcome varaibles. nx1 matrix
%%%%Input M: mediation variables. nxp matrix
%%%%Input Z: exposure variables. nxq matrix
%%%%Input nPerm: the number of permutations used to estimate p-value
SetMediationTest(mydat.Y, mydat.KM, mydat.KZ)

