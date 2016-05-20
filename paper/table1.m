% Generate the numbers in table 1
% PLEASE BE ADVISED, YOU NEED TO RUN THE SPECTRAL CLUSTERING BEFORE USING
% runSpectralClusteringOnAllShapes.m

clear all; close all;
addpath('../')

% Load the dataset
load dataset.mat

% We count the number of modes obtained with Spectral Clustering
nbModes = [];


% Browse each shape
for ind_shape=1:length(shape)
   if exist(['../Results/Spectral/' shape{ind_shape,2}(1:end-4) 'mat']) 
      
       load(['../Results/Spectral/' shape{ind_shape,2}(1:end-4) 'mat'])
      
       nbModes = [nbModes length(annot_clust)];
       
       % Clear all relevant variables
       clear clust_maj annot_clust ind_annot_clust
   end
end

nb1 = round(length(find(nbModes==1))*100/length(nbModes));
nb2 = round(length(find(nbModes==2))*100/length(nbModes));
nb3 = round(length(find(nbModes==3))*100/length(nbModes));
nb4 = round(length(find(nbModes==4))*100/length(nbModes));
nb58 = 100 - nb1 - nb2 - nb3 - nb4;

disp('|-------------------------------------------------------------|')
disp('|        Percentage of shapes and their # of modes            |')
disp('|-------------------------------------------------------------|')
disp('|     1     |     2     |     3     |     4     |     5-8     |')
disp('|-------------------------------------------------------------|')
disp(['|    ' int2str(nb1) '%    |    '  int2str(nb2) '%    |     '   int2str(nb3) '%    |     '  int2str(nb4) '%    |     '  int2str(nb58) '%      |']) 
disp('|-------------------------------------------------------------|')
