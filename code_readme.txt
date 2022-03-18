Scope
The repository contains scripts for the analyses used in the paper?" A cognitive neurogenetic approach to uncovering the structure of executive functions"?by Feng et al. Herein, we proposed a novel cognitive neurogenetic approach that integrates genetic, neural, and behavioral data to examine the structure of EFs. The scripts in this repository can be used to study the structure of other complex traits at behavioral (latent variable models), neural (brain functional connectivity) and genetic levels.  If you have questions or trouble with the scripts, feel free to contact me: fengjunjiao54@163.com

Sample data
We provided sample data just to help run the functions, these are not real data.

Software requirements
Matlab version 2021
R version 4.1.2

Instructions for use (script description)
For the analysis done in the paper, the scripts should be run in the following order:

DataClean.R 
This function is used for ¡°data cleaning¡±
We removed participants who did not make response for more than 20% of trials or made too many mistakes based on the binomial distribution. And truncated the extreme scores (i.e., scores that were 1.5x IQR less than the first quartile or 1.5x IQR more than the third quartile) by replacing them with median - 1.5x IQR and + 1.5x IQR, respectively.

input: EFRes\ *Result.csv
output: EFFiltered\ef_behav_all.csv

trans.Rmd
The cleaned dependent measures were then transformed so that a high score represented high ability.
Input£ºEFFiltered\ef_behav_all.csv
Output£ºEFFiltered\ef_behav_all_trans.csv

regress.m
This function is used to regress out the effects of age and gender

Input£ºEFFiltered\ef_behav_all_trans.csv 
Output£ºEFFiltered\ef_behav_all_trans_regress.csv


normality.Rmd
This function is used to transform the residuals to Z scores before further EF model estimation.

Input:  EFFiltered\ef_behav_all_trans_regress.csv
Output: cfa\data\ef_behav_all_trans_regress_scaled.csv

model_fitting.Rmd
This function is used to estimate the latent variable models with maximum likelihood estimation by using the ¡°lavaan¡± package in R software.
Input: cfa\data\ef_behav_all_trans_regress_scaled.csv
Output: model_fitting.html, cfa\result\factor scores.





CPM
BehavioralPrediction.m
This function is modified based on the article that developed the CPM approach (Shen et al., 2017), using brain functional connectivity to predict EF factor scores.


High dimensional mediation

This function shows how to use the high-dimensional mediation function(Zhang, 2021).
Just run ¡°read.m¡±




references

Shen, X. L., Finn, E. S., Scheinost, D., Rosenberg, M. D., Chun, M. M., Papademetris, X., & Constable, R. T. (2017). Using connectome-based predictive modeling to predict individual behavior from brain connectivity. Nat Protoc, 12(3), 506-518. doi:10.1038/nprot.2016.178
Zhang, Q. (2021). High-Dimensional Mediation Analysis with Applications to Causal Gene Identification. Statistics in Biosciences. doi:10.1007/s12561-021-09328-0

