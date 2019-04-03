%% Initialisation
addpath('./Questions/Pictures/')
addpath('./Questions/Functions/')
addpath('./Questions/Variables/')
close all;

load('variables.mat')
average_plotter();
distance_plotter(38, All_averages, All_pictures, MyFolderInfo);
reconstruct_illum();