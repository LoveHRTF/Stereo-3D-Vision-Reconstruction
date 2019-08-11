function [] = func_pltLineEpipo(matchPixA,matchPixB, EssencialMat, K, imgA_Color, imgB_Color)

pixRand = randperm(size(matchPixA, 2), 1);                                  % Randomly select a matched keypoint
eppLine = inv(K)' * EssencialMat * inv(K) * matchPixA(:, pixRand);          % Calculate the epipolar line for selected keypoint in [a, b, c].T form
eppLine_X = 1:size(imgA_Color,2);                                           % Get the width of image
eppLine_Y = (-eppLine(3) - eppLine(1) .* eppLine_X) ./ eppLine(2);          % Get -aX - b/c

%% Plot selected random keypoint
figure
imshow(imgA_Color);
hold on;
plot(matchPixA(1,pixRand),matchPixA(2,pixRand),...
    '-g*',...
    'LineWidth', 3,...
    'MarkerSize', 20);
% saveas(gcf,'lineEpipoA.png')

%% Plot corresponding epipolar Line
figure
imshow(imgB_Color);
hold on;
plot(eppLine_X,eppLine_Y,...
    '-g',...
    'LineWidth', 3);
% saveas(gcf,'lineEpipoB.png')
end

