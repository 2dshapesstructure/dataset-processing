% Generate figure 3

clear all; close all;
addpath('../')

% Load the dataset
load dataset.mat

% Read the JSON file of the elephant-1 shape
elephant1_shape = readJSON('../JSON/elephant-1.json');

figure;
displayShape(elephant1_shape)
