function [ptsIniFilt,ptsIniFilt_Bar] = func_BidirecFilter(ImgX_inp,ImgY_inp,xGid,yGid,ImgAB_X,ImgAB_Y, ImgBA_X, ImgBA_Y, rejParam)

pixDist = sqrt(((ImgX_inp - xGid) .^ 2) + ((ImgY_inp - yGid) .^ 2));        % Calculate distance between pix
[iniFilt_X, iniFilt_Y] = find(pixDist < rejParam);                          % Reject pix with dist larger than threshold

ptsIniFilt = ones(3, size(iniFilt_X,1));
ptsIniFilt_Bar = ones(3, size(iniFilt_X,1));

for idx = 1:size(ptsIniFilt, 2)
    ptsIniFilt(1,idx) = xGid(iniFilt_X(idx),iniFilt_Y(idx));                % Assign Filtered pixel axis
    ptsIniFilt(2,idx) = yGid(iniFilt_X(idx),iniFilt_Y(idx));  
    
    ptsIniFilt_Bar(1,idx) = ImgAB_X(iniFilt_X(idx),iniFilt_Y(idx));         % Assign Filtered pixel bars
    ptsIniFilt_Bar(2,idx) = ImgAB_Y(iniFilt_X(idx),iniFilt_Y(idx));   
end


end

