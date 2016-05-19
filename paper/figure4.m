% Generate figure 4

clear all; close all;
addpath('../')

% Load the dataset
load dataset.mat

% Read the JSON file of the bird-5 shape
bird5_shape = readJSON('../JSON/bird-5.json');
% Extract all annotations of the butterfly-14 shape
ind_bird5 = 1;
while (~strcmp('bird-5.json',shape{ind_bird5,2}))
    ind_bird5 = ind_bird5 + 1;
end
annotations_bird5 = annotations(triplets(:,2)==ind_bird5);
majority_bird5 = computeMajority(annotations_bird5);


% Read the JSON file of the elephant-16 shape
elephant16_shape = readJSON('../JSON/elephant-16.json');
% Extract all annotations of the elephant-16 shape
ind_elephant16 = 1;
while (~strcmp('elephant-16.json',shape{ind_elephant16,2}))
    ind_elephant16 = ind_elephant16 + 1;
end
annotations_elephant16 = annotations(triplets(:,2)==ind_elephant16);
majority_elephant16 = computeMajority(annotations_elephant16);


% Read the JSON file of the camel-20 shape
camel20_shape = readJSON('../JSON/camel-20.json');
% Extract all annotations of the camel-20 shape
ind_camel20 = 1;
while (~strcmp('camel-20.json',shape{ind_camel20,2}))
    ind_camel20 = ind_camel20 + 1;
end
annotations_camel20 = annotations(triplets(:,2)==ind_camel20);
majority_camel20 = computeMajority(annotations_camel20);


% Read the JSON file of the deer-20 shape
deer20_shape = readJSON('../JSON/deer-20.json');
% Extract all annotations of the deer-20 shape
ind_deer20 = 1;
while (~strcmp('deer-20.json',shape{ind_deer20,2}))
    ind_deer20 = ind_deer20 + 1;
end
annotations_deer20 = annotations(triplets(:,2)==ind_deer20);
majority_deer20 = computeMajority(annotations_deer20);


% Figure 4 depicts the majority annotations of the bird-5, camel-20, 
% elephant-16 and deer-20 shapes
figure;
subplot(1,4,1)
displayShape(bird5_shape,majority_bird5)

subplot(1,4,2)
displayShape(camel20_shape,majority_camel20)

subplot(1,4,3)
displayShape(elephant16_shape,majority_elephant16)

subplot(1,4,4)
displayShape(deer20_shape,majority_deer20)
