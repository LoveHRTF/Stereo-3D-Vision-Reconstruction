% This function was to convert the inlier position to actual pixel
% positions on two images
function [matchPixA_3bN,matchPixB_3bN] = func_inlierPos2Coord(inlierPos, matches, inlierNum, siftA, siftB)

%% Find all the matching points coord
SIFTPts(1,:) = (matches(1,:) .* inlierPos);
SIFTPts(2,:) = (matches(2,:) .* inlierPos);

idxInlier = 0;

matchPixA = zeros(2, inlierNum);
matchPixB = zeros(2, inlierNum);

%% Assign Points
for idx = 1:size(SIFTPts,2)
    if SIFTPts(1,idx) ~= 0
        idxInlier = idxInlier + 1;
        
        matchPixA(1,idxInlier) = siftA.f(1,SIFTPts(1,idx));
        matchPixA(2,idxInlier) = siftA.f(2,SIFTPts(1,idx));
        
        matchPixB(1,idxInlier) = siftB.f(1,SIFTPts(2,idx));
        matchPixB(2,idxInlier) = siftB.f(2,SIFTPts(2,idx));
    end
end


%% Convert from 2bN to 3bN
matchPixA_3bN = ones(3,size(matchPixA,2));
matchPixB_3bN = ones(3,size(matchPixB,2));

matchPixA_3bN(1:2,:) = matchPixA;
matchPixB_3bN(1:2,:) = matchPixB;


end

