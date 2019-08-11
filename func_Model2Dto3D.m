% This function was to convert 2-D image to 3-D Model
function [Gamma,pix_Rander] = func_Model2Dto3D(colorImgA,colorImgB,params,CameraMatK)
tic
K = CameraMatK;
%% Load Image and Camera Intrinsic Matrix
imgA_Color = imread(colorImgA);
imgB_Color = imread(colorImgB);

imgMatA = vl_imreadgray(colorImgA);                                         % Load Image
imgMatB = vl_imreadgray(colorImgB);                                         % Perform Feature Detection

%% SIFT Detector and Feature Matching
disp('Trace -> func_Model2Dto3D: Perform SIFT Feature Detection ...')
[siftA,siftB] = func_SIFT(imgMatA,imgMatB);                                 % Detect Sift Feature
matches = vl_ubcmatch(siftA.d, siftB.d);                                    % Find the closest descriptor for every dA in dB
% Matches: Idx for original match and closest descroptor
%% Perform RANSAC
disp('Trace -> func_Model2Dto3D: RANSAC for Essencial Matrix ...')
[EssencialMat, inlierNum, inlierPos] = func_RANSAC_3D(params.RANSACIterations,...
    params.reprojectionErrorThreshold,...
    K, siftA, siftB, matches);
%% Convert Pixel index to actual grid
disp('Trace -> func_Model2Dto3D: Convert inlier index to pixel coord ...')
[matchPixA,matchPixB] = func_inlierPos2Coord(inlierPos, matches, inlierNum, siftA, siftB);

%% Plot Epipolar Line for random keypoint
for idx = 1:2
    disp('Trace -> func_Model2Dto3D: Plot Example Epipolar Line ...')
    func_pltLineEpipo(matchPixA,matchPixB, EssencialMat, K, imgA_Color, imgB_Color)
end

%% Perform essential matrix decomposition
disp('Trace -> func_Model2Dto3D: Essential Matrix Decomposition ...')
[R1, R2, T1, T2] = func_EMD(EssencialMat);                                  % Calculate R and T

%% Voting for R and T
disp('Trace -> func_Model2Dto3D: Voting for R and T ...')
[T, R] = func_Vote_R_T(matchPixA,matchPixB,T1,T2,R1,R2,K);

%% Dencify
disp('Trace -> func_Model2Dto3D: Dencify Matched Points ...')
[ImgAB_X,ImgAB_Y,ImgBA_X,ImgBA_Y,ImgX_inp,ImgY_inp,xGid,yGid] =...
    func_Dencify(imgA_Color, imgB_Color, matchPixA, matchPixB, ...
    params.correspondenceDensificationFactor);

%% Initial Filter by Bidirectional Match
disp('Trace -> func_Model2Dto3D: Filter by bi-Directional Match ...')
% Find distance between pixels
[ptsIniFilt,ptsIniFilt_Bar] = ...
    func_BidirecFilter(ImgX_inp,ImgY_inp,xGid,yGid, ImgAB_X,ImgAB_Y,ImgBA_X, ImgBA_Y, ... %%
    params.bidirectionalMatchConsistencyThreshold);

%% Filter by EPIPOLAR Constrain
disp('Trace -> func_Model2Dto3D: Filter by Epipolar Constrain ...')
[pts3D_A, pts3D_B] = ...
    func_EpipoFilter(ptsIniFilt, ptsIniFilt_Bar, EssencialMat, K, ...
    params.reprojectionErrorThreshold);

%% Perform Reconstruction/Triangulation
disp('Trace -> func_Model2Dto3D: Perform Pixel Triangulation ...')
[Gamma,pix_Rander] = func_Rander(imgA_Color,pts3D_A,pts3D_B,R,K,T);
%%
duration = toc;
fprintf('Trace -> func_Model2Dto3D: Finished in: %4.2f seconds. \n', duration)

end

