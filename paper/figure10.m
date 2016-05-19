% Generate figure 10

clear all; close all;
addpath('../')

% Load the dataset
load dataset.mat

% Read the JSON file of the camel-18 shape
camel18_shape = readJSON('../JSON/camel-18.json');
% Extract all annotations of the camel-18 shape
ind_camel18 = 1;
while (~strcmp('camel-18.json',shape{ind_camel18,2}))
    ind_camel18 = ind_camel18 + 1;
end
annotations_camel18 = annotations(triplets(:,2)==ind_camel18);

plotAllShapesAnnotations(camel18_shape,annotations_camel18,[4,7])
