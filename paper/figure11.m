% Generate figure 11

clear all; close all;
addpath('../')

% Load the dataset
load dataset.mat
% Load the quality scores for each team
load QualityScores.mat

% We want to discard the 20% worst users; we compute the quality threshold
% below which we filter out users
scores_filt = scores(~isnan(scores)); % Remove the NaN users
scores_sorted = sort(scores_filt,'ascend');
score_threshold = scores_sorted(round(20*length(scores_sorted)/100));


% Read the JSON file of the camel-18 shape
camel18_shape = readJSON('../JSON/camel-18.json');
% Extract all annotations of the camel-18 shape
ind_camel18 = 1;
while (~strcmp('camel-18.json',shape{ind_camel18,2}))
    ind_camel18 = ind_camel18 + 1;
end
annotations_camel18 = annotations(triplets(:,2)==ind_camel18);
scores_camel18 = scores(triplets(triplets(:,2)==ind_camel18,1));

% Compute the mejority vote of the camel-18 annotations from users who are
% above the quality threshold
majority_camel18 = computeMajority(annotations_camel18(scores_camel18 > score_threshold));


areas_tri = computeTrianglesArea(camel18_shape);
[clust_maj,annot_clust,ind_annot_clust] = spectralClustering(annotations_camel18(scores_camel18 > score_threshold),areas_tri);

subplot(1,3,1)
displayShape(camel18_shape,majority_camel18);
title('Majority vote')

subplot(1,3,2)
displayShape(camel18_shape,clust_maj{1});
title('Spectral Clustering - Mode #1')

subplot(1,3,3)
displayShape(camel18_shape,clust_maj{2});
title('Spectral Clustering - Mode #2')