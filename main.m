% Perform stereo 3d vision reconstruction by giving two photos from stereo camera and camera intrinsic matrix
% @chenz
%
% Dependency: VLFeat lib for SIFT 

clc;
close all;
clear all;

addpath('lib')
addpath('data')

% Algorithm parameters

params = [];
params.RANSACIterations = 5000;                                             % 5000 iterations
params.reprojectionErrorThreshold = 2;                                      % 2 pixels
params.bidirectionalMatchConsistencyThreshold = 2;                          % 2 pixels
params.correspondenceDensificationFactor = 4;                               % every 4 pixels

%% Reconstruct the 3D scene

load('cameraIntrinsicMatrix.mat'); 
colorImgA = '1.jpg';
colorImgB = '2.jpg';
[Gamma,pix_Rander] = func_Model2Dto3D(colorImgA,colorImgB,params,K);        % Plot 3 epipolar line pairs
%% Plot 3D Pixel Cloud

figure
pcshow(Gamma, pix_Rander);                                    




















