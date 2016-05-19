% Generate figure 7

clear all; close all;
addpath('../')

% Load the dataset
load dataset.mat

% Read the JSON file of the deer-14 shape
deer14_shape = readJSON('../JSON/deer-14.json');
% Extract all annotations of the deer-14 shape
ind_deer14 = 1;
while (~strcmp('deer-14.json',shape{ind_deer14,2}))
    ind_deer14 = ind_deer14 + 1;
end
annotations_deer14 = annotations(triplets(:,2)==ind_deer14);


% Read the JSON file of the bell-5 shape
bell5_shape = readJSON('../JSON/bell-5.json');
% Extract all annotations of the bell-5 shape
ind_bell5 = 1;
while (~strcmp('bell-5.json',shape{ind_bell5,2}))
    ind_bell5 = ind_bell5 + 1;
end
annotations_bell5 = annotations(triplets(:,2)==ind_bell5);


% Read the JSON file of the cellular_phone-19 shape
cellularphone19_shape = readJSON('../JSON/cellular_phone-19.json');
% Extract all annotations of the cellular_phone-19 shape
ind_cellularphone19 = 1;
while (~strcmp('cellular_phone-19.json',shape{ind_cellularphone19,2}))
    ind_cellularphone19 = ind_cellularphone19 + 1;
end
annotations_cellularphone19 = annotations(triplets(:,2)==ind_cellularphone19);



% The figure 7 depicts zoomed in areas of 1st and 6th annotations of the 
% deer-14 shape, the 1st annotation of the bell-5 shape and the 1st
% annotation of the cellularphone-19 shape
subplot(1,4,1)
displayShape(deer14_shape,annotations_deer14{1})
axis([0.55 0.9 0.35 0.75])

subplot(1,4,2)
displayShape(deer14_shape,annotations_deer14{6})
axis([0.7 1 0 0.3])

subplot(1,4,3)
displayShape(bell5_shape,annotations_bell5{1})

subplot(1,4,4)
displayShape(cellularphone19_shape,annotations_cellularphone19{1})
