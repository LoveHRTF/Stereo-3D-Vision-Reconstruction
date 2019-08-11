function [ImgAB_X,ImgAB_Y,ImgBA_X,ImgBA_Y,ImgX_inp,ImgY_inp,xGid,yGid] =...
    func_Dencify(imgA_Color, imgB_Color, matchPixA, matchPixB, Fd)

[xGid, yGid] = meshgrid(1 : Fd : size(imgA_Color,2), 1 : Fd : size(imgA_Color,1));

ImgAB_X = griddata(matchPixA(1, :), matchPixA(2, :), matchPixB(1, :), xGid, yGid);
ImgAB_Y = griddata(matchPixA(1, :), matchPixA(2, :), matchPixB(2, :), xGid, yGid);

ImgBA_X = griddata(matchPixB(1, :), matchPixB(2, :), matchPixA(1, :), xGid, yGid);
ImgBA_Y = griddata(matchPixB(1, :), matchPixB(2, :), matchPixA(2, :), xGid, yGid);

ImgX_inp = interp2(xGid, yGid, ImgBA_X , ImgAB_X, ImgAB_Y);
ImgY_inp = interp2(xGid, yGid, ImgBA_Y , ImgAB_X, ImgAB_Y);

end

