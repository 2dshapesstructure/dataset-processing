% Generate figure 8

clear all; close all;
addpath('../')

% Load the dataset
load dataset.mat
% Load the gold standard expert annotations
load goldstandard.mat

% Figure 8 only shows expert users 2 and 4
% Comment these two lines to see all expert users annotations
t = [tripletsGS(tripletsGS(:,1)==2,:); tripletsGS(tripletsGS(:,1)==4,:)];
tripletsGS = t;

figure;
nbExperts = length(unique(tripletsGS(:,1)));

% Loop over the Gold Standard shapes
for ind_shape = 1246:1249
   
    % Read the JSON of the Gold Standard shape
    GS_shape = readJSON(['../JSON/' shape{ind_shape,2}]);
    
    % Extract all expert annotations for this Gold Standard shape
    GS_annotations = annotationsGS(tripletsGS(tripletsGS(:,2)==ind_shape,3));
    
    % Loop over all expert annotations
    for ind_xp = 1:length(GS_annotations)
       subplot(nbExperts,4,(ind_xp-1)*4+ind_shape-1245)
       displayShape(GS_shape,GS_annotations{ind_xp})
       drawnow
    end
    
end