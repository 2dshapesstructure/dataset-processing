% Generate figure 9

clear all; close all;
addpath('../')

% Load the dataset
load dataset.mat
% Load the quality scores for each team
load QualityScores.mat

% Sort the teams according to their quality scores
[aux,ind_t] = sort(scores,'ascend');

figure;


% The NaN values are at the end of the sorted scores, so the index of the
% best user is the following 
best_user_ind = length(aux) - sum(isnan(aux));


% The users with the higest score are the best ones
% The 96th and 164th are the ones depicted in the paper
% The 6th to 10th annotations, out of 20, are shown in the paper
% N.B. most of the users with a better score did not annotate 20 shapes
% (they stopped before), which is why we did not select them to be in the
% paper

best_u_164 = ind_t(best_user_ind - 164 + 1);
best_u_164_shapes = shape(triplets(triplets(:,1)==best_u_164,2),2);
best_u_164_annot = annotations(triplets(triplets(:,1)==best_u_164,3));


for k = 6:10
    subplot(4,5,k-5)
   % Read JSON 
   s = readJSON(['../JSON/' best_u_164_shapes{k}]);

   displayShape(s,best_u_164_annot{k});
   drawnow
end

best_u_96 = ind_t(best_user_ind - 96 + 1);
best_u_96_shapes = shape(triplets(triplets(:,1)==best_u_96,2),2);
best_u_96_annot = annotations(triplets(triplets(:,1)==best_u_96,3));


for k = 6:10
    subplot(4,5,k)
   % Read JSON 
   s = readJSON(['../JSON/' best_u_96_shapes{k}]);

   displayShape(s,best_u_96_annot{k});
   drawnow
end


% The users with the lowest score are the worst ones
% The 10th and 12th are the ones depicted in the paper
% The 1st to 5th annotatinos are shown in the paper
worst_u_10 = ind_t(10);
worst_u_10_shapes = shape(triplets(triplets(:,1)==worst_u_10,2),2);
worst_u_10_annot = annotations(triplets(triplets(:,1)==worst_u_10,3));

for k = 1:5
    subplot(4,5,10+k)
   % Read JSON 
   s = readJSON(['../JSON/' worst_u_10_shapes{k}]);

   displayShape(s,worst_u_10_annot{k});
   drawnow
end

worst_u_12 = ind_t(12);
worst_u_12_shapes = shape(triplets(triplets(:,1)==worst_u_12,2),2);
worst_u_12_annot = annotations(triplets(triplets(:,1)==worst_u_12,3));

for k = 1:5
    subplot(4,5,15+k)
   % Read JSON 
   s = readJSON(['../JSON/' worst_u_12_shapes{k}]);

   displayShape(s,worst_u_12_annot{k});
   drawnow
end