% Generate figure 1

clear all; close all;
addpath('../')

% Load the dataset
load dataset.mat

% Read the JSON file of the bird-1 shape
bird1_shape = readJSON('../JSON/bird-1.json');

% Extract all annotations of the bird-1 shape
ind_bird1 = 1;
while (~strcmp('bird-1.json',shape{ind_bird1,2}))
    ind_bird1 = ind_bird1 + 1;
end

annotations_bird1 = annotations(triplets(:,2)==ind_bird1);

% Figure 1 depicts the 16th, 8th and 14th annotations of the bird-1 shape
figure;
subplot(1,3,1)
displayShape(bird1_shape,annotations_bird1{16})

subplot(1,3,2)
displayShape(bird1_shape,annotations_bird1{8})

subplot(1,3,3)
displayShape(bird1_shape,annotations_bird1{14})
