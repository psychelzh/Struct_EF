% modified based on  shen et al(2017)
%writen by Junjiao Feng
% CPM analysis, using brain functional connectivity to predict EF factor scores 


clear;
clc;
% ------------ INPUTS -------------------
load SimulateFC.mat;%functioanl connectivity of all subjects, 
load 100sublist.mat; %sublist
load simulateCovar.mat;   %covariants
all_FC = cat(1,sublist',all_FC);
all_FC_trans = all_FC';
load simulateEFfactorScore.mat; %behavioral data
load 100subs_random_group_100times.mat; %% randomly divided subs into 10 groups 100 times
all_results = [];
all_edges=[];
for it = 1:100
    g_sub = g_sub_all(:,:,it);
    all_test_behav = [];
    all_behav_pred = [];
    
  for i = 1:10
      A = ~ismember(all_FC_trans(:,1), g_sub(:,i));
      A = double(A);
      B = ismember(all_FC_trans(:,1), g_sub(:,i));
      B = double(B);

      train_mats = all_FC_trans.*A;
      train_mats(all(train_mats==0,2),:)=[]; 
      train_mats(:,1) = [];
      
      test_mats = all_FC_trans.*B;
      test_mats(all(test_mats==0,2),:)=[]; 
      test_mats(:,1) = [];
      
      %To avoid biasing the test set, edge strengths were z-scored across
      %subjects within the training set and the corresponding
      %transformation was  subsequently applied to the test set
      mean_train_mats = mean(train_mats); 
      std_train_mats = std(train_mats);  
      train_mats = (train_mats - mean_train_mats)./std_train_mats; 
      test_mats = (test_mats - mean_train_mats)./std_train_mats;
      
      train_behav = Y(:,3).*A;
      train_behav(all(train_behav==0,2),:)=[]; 

      test_behav = Y(:,3).*B;
      test_behav(all(test_behav==0,2),:)=[]; 

      train_covariance = X.*A;
      train_covariance(all(train_covariance==0,2),:)=[];

      % threshold for feature selection, 
      thresh = 0.05;% p-value
      train_no_sub = size(train_mats,1);
      test_no_sub = size(test_mats,1);

      % correlate all edges with behavior using partial correlation
      [r_mat,p_mat] = partialcorr(train_mats,train_behav,train_covariance);
      pos_edges = r_mat > 0 & p_mat < thresh;
      neg_edges = r_mat < 0 & p_mat < thresh;
      both_edges = p_mat < thresh;
   
      % get sum of all edges in TRAIN subs
      train_sumpos = sum(train_mats(:, pos_edges), 2);
      train_sumneg = sum(train_mats(:, neg_edges), 2);    
      % build model on TRAIN subs,combining both postive and negative features
      b = regress(train_behav,[train_sumpos,train_sumneg,ones(train_no_sub,1)]);
      % run model on TEST sub
      behav_pred = zeros(test_no_sub,1);
      % run model on TEST sub
      for leftout = 1:test_no_sub
          test_mat = test_mats(leftout,:);
          test_sumpos = sum(test_mat(:, pos_edges), 2);
          test_sumneg = sum(test_mat(:, neg_edges), 2);
        
          behav_pred(leftout) = b(1)*test_sumpos+b(2)*test_sumneg+b(3);
        
       end
      all_behav_pred = [all_behav_pred; behav_pred];
      all_test_behav =[all_test_behav; test_behav];
   end 
  % compare predicted and observed scores
    [R,P]= corr(all_behav_pred,all_test_behav);
    all_results = [all_results;R];
    mean_predict = mean(all_results);
    
end
save  predictResults.mat all_results;

