function [pts3D_A, pts3D_B] = func_EpipoFilter(ptsIniFilt, ptsIniFilt_Bar, EssencialMat, K, eppRejParam)

line_epp = inv(K)' * EssencialMat * inv(K) * ptsIniFilt;                    % Find the epipolar line for one image

pixDist_epp = abs(dot(ptsIniFilt_Bar,line_epp)) ./...                       % Find the constrained distance for this epipolar line
    sqrt(line_epp(1,:) .^ 2 + line_epp(2,:) .^ 2);

ptsInEpp = find(pixDist_epp < eppRejParam);                                 % Find the pts position with in constrain

pts3D_A = ptsIniFilt(:, ptsInEpp);                                          % Assign actual pixel position by matrix position index
pts3D_B = ptsIniFilt_Bar(:, ptsInEpp);

end

