function Es = ComputeEssentialMatrix(pixels1, pixels2, K)

    matchesInMeters = zeros(5, 3, 2);
    pixels1 = double(pixels1);
    pixels2 = double(pixels2);
    
    for i = 1:5
       meters1 = K \ [pixels1(:,i); 1];
       meters2 = K \ [pixels2(:,i); 1];
       matchesInMeters(i, 1, 1) = meters1(1); matchesInMeters(i, 2, 1) = meters1(2); matchesInMeters(i, 3, 1) = 1;
       matchesInMeters(i, 1, 2) = meters2(1); matchesInMeters(i, 2, 2) = meters2(2); matchesInMeters(i, 3, 2) = 1;                
    end
       
    Es = fivePointAlgorithmSelf(matchesInMeters);
    
end