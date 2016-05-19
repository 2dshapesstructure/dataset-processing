% Generate figure 6

clear all; close all;
addpath('../')

% Load the dataset
load dataset.mat

% Read the JSON file of the device7-17 shape
device7_17_shape = readJSON('../JSON/device7-17.json');
% Extract all annotations of the device7-17 shape
ind_device7_17 = 1;
while (~strcmp('device7-17.json',shape{ind_device7_17,2}))
    ind_device7_17 = ind_device7_17 + 1;
end
annotations_device7_17 = annotations(triplets(:,2)==ind_device7_17);

plotAllShapesAnnotations(device7_17_shape,annotations_device7_17,[4,7])



% Read the JSON file of the elephant-1 shape
elephant1_shape = readJSON('../JSON/elephant-1.json');
% Extract all annotations of the elephant-1 shape
ind_elephant1 = 1;
while (~strcmp('elephant-1.json',shape{ind_elephant1,2}))
    ind_elephant1 = ind_elephant1 + 1;
end
annotations_elephant1 = annotations(triplets(:,2)==ind_elephant1);

plotAllShapesAnnotations(elephant1_shape,annotations_elephant1,[5,7])