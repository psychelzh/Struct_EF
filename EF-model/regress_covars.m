%% regress the phenotypes, writen by junjiao Feng, 
cd EFFiltered
Y = readmatrix("ef_behav_all_trans.csv");
load 100subsAgeGender.mat;
all_Y_reg=[];
a = ones(100,1);
X=[X,a];
for i = 1:9;
  [b,bint,r] = regress (Y(:,i),X);
  Y_reg = r;
  all_Y_reg =[all_Y_reg,Y_reg];
end

csvwrite ("ef_behav_all_trans_regress.csv", all_Y_reg)




