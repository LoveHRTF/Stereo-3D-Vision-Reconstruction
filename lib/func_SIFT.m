function [siftA,siftB] = func_SIFT(imageRight,imageLeft)

% Using VLFeat lib

imgMatA = single(imageRight);
[siftA.f, siftA.d] = vl_sift(imgMatA);

imgMatB = single(imageLeft);
[siftB.f, siftB.d] = vl_sift(imgMatB);

end

