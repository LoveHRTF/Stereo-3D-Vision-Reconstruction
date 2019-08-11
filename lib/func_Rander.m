function [GammaT,pix_Rander] = func_Rander(ColorImg,pts3D_A,pts3D_B,R,K,T)

img_Color = double(ColorImg);
Gamma = zeros(3, size(pts3D_A, 2));
pix_3D = zeros(size(pts3D_A, 2), 3);

for idx = 1:size(pts3D_A,2)
    F = [-R * (K \ pts3D_A(:,idx)), K \ pts3D_B(:,idx)] \ T';
    Gamma(:,idx) = F(1) * K \ pts3D_A(:,idx);
    pix_3D(idx,:)=img_Color(pts3D_A(2,idx),pts3D_A(1,idx),:);               % Rander color for every pixed
end

GammaT = Gamma';
pix_Rander = pix_3D/(max(pix_3D(:)));

end

