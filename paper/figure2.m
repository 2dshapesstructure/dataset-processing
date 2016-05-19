% Generate figure 2

clear all; close all;
addpath('../')

% Load the dataset
load dataset.mat

% Read the JSON file of the butterfly-14 shape
butterfly14_shape = readJSON('../JSON/butterfly-14.json');

% Extract all annotations of the butterfly-14 shape
ind_butterfly14 = 1;
while (~strcmp('butterfly-14.json',shape{ind_butterfly14,2}))
    ind_butterfly14 = ind_butterfly14 + 1;
end

annotations_butterfly14 = annotations(triplets(:,2)==ind_butterfly14);

% Figure 2 depicts the 1st and 16th annotations of the butterfly-14 shape
figure;
subplot(1,2,1)
displayShape(butterfly14_shape,annotations_butterfly14{16})

subplot(1,2,2)
displayShape(butterfly14_shape,annotations_butterfly14{1})
