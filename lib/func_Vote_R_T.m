function [T, R] = func_Vote_R_T(matchPix_A,matchPix_B,T1,T2,R1,R2,K)
% Create 3 x N matrix for match pts
%matchPix_A = ones(3, size(matchPixA,2)); matchPix_B = ones(3, size(matchPixB,2));
% matchPix_A(1:2,:) = matchPixA; matchPix_B(1:2,:) = matchPixB;

% Start Voting
R_Votes = zeros(1,4);
for idx = 1:size(matchPix_A,2)
    A1 = [K \ matchPix_A(:,idx), -R1 * (K \ matchPix_B(:, idx))];
    A2 = [K \ matchPix_A(:,idx), -R2 * (K \ matchPix_B(:, idx))];
    
    rho1 = A1 \ T1.'; rho2 = A1 \ T2.'; rho3 = A2 \ T1.'; rho4 = A2 \ T2.';
    % Vote base on the sign of rhos
    if rho1(1) >= 0 && rho1(2) >= 0
        R_Votes(1) = R_Votes(1) + 1;
    end
    if rho2(1) >= 0 && rho2(2) >= 0
        R_Votes(2) = R_Votes(2) + 1;
    end
    if rho3(1) >= 0 && rho3(2) >= 0
        R_Votes(3) = R_Votes(3) + 1;
    end
    if rho4(1) >= 0 && rho4(2) >= 0
        R_Votes(4) = R_Votes(4) + 1;
    end
end
[max_val, max_idx] = max(R_Votes);                                          % Max value and position

if max_idx == 1 
    R = R1;
    T = T1;
elseif max_idx == 2
    R = R1;
    T = T2;
elseif max_idx == 3
    R = R2;
    T = T1;
else
    R = R2;
    T = T2;
end

end

