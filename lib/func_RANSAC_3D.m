% RANSAC

function [E, inlierMax, inlierPos] = func_RANSAC_3D(iter,Threshold, K, SIFT_A, SIFT_B, SIFT_KeyPt)

for idx = 1:size(SIFT_KeyPt,2)
    pixPairs_A(:,idx) = SIFT_A.f(1:2,SIFT_KeyPt(1,idx));
    pixPairs_B(:,idx) = SIFT_B.f(1:2,SIFT_KeyPt(2,idx));
end

matchPixLength = size(pixPairs_A,2);

pixCoord_A = ones(3,matchPixLength);
pixCoord_A(1,:) = pixPairs_A(1,:);
pixCoord_A(2,:) = pixPairs_A(2,:);

pixCoord_B = ones(3,matchPixLength);
pixCoord_B(1,:) = pixPairs_B(1,:);
pixCoord_B(2,:) = pixPairs_B(2,:);

inlierMax = 0;
%% RANSAC Iterations
for idxRANSAC = 1:iter
    
    %% =============================== RNG ================================
    %% Generate 5 random number for random 5 matched pix pairs
    listLength  = size(SIFT_KeyPt,2);                                       % Preset RGN range
    randIdx     = randi(listLength, 1, 5);                                  % Generate Rendom indexes
    randPair    = SIFT_KeyPt(:, randIdx);                                   % Get Random Pix Pair Positions
    
    %% Get Pixel Coord for Random Pairs
    pixCoordList_A = SIFT_A.f(1:2, randPair(1,:));
    pixCoordList_B = SIFT_B.f(1:2, randPair(2,:));
    Es = ComputeEssentialMatrix(pixCoordList_A, pixCoordList_B, K);         % Calculate Es
    
    %% ========================== Process all Es ==========================
    for idxEs = 1:size(Es,3)
        matF        = inv(K)' * Es{idxEs} * inv(K);
        lineParam   = matF * pixCoord_A;
        %% Calculate distance for every pixel
        deno        = dot(pixCoord_B, lineParam);
        elem        = sqrt(lineParam(1,:).^2 + lineParam(2,:).^2);
        dist        = abs(deno ./ elem);
        %% Find inliers for this E
        smallerMat  = dist < Threshold;                                     % Get all inliers position
        inlier      = sum(smallerMat);                                      % Find inlier numbers
        %% Find the E and pix has most inliers in this E
        if inlier > inlierMax
            inlierMax = inlier;
            inlierPos = smallerMat;
            E = Es{idxEs};
        end
    end
end
end

