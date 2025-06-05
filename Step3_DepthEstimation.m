% get variable naes from VariableNames.m

I1 = imread('C:\Users\edeligia\Documents\GitHub\fMRI_3DFaces_MD_2021\Experiment\Images_PILOT\Face1_L.png'); % left
I2 = imread('C:\Users\edeligia\Documents\GitHub\fMRI_3DFaces_MD_2021\Experiment\Images_PILOT\Face1_R.png'); % right

frameLeftGray  = rgb2gray(I1);
frameRightGray = rgb2gray(I2);

frameLeftGray = histeq(frameLeftGray); % scale contrast here? ... up the contrast
frameRightGray = histeq(frameRightGray);

frameLeftGray = circshift(frameLeftGray,-d,2);
frameRightGray = circshift(frameRightGray,d,2);
    
disparityMap = disparitySGM(frameLeftGray, frameRightGray, 'UniquenessThreshold',ut);

% depth map
figure;
imshow(disparityMap, [0, 176]);
title('Disparity Map');
colormap gray
colorbar
print(gcf,SaveName,'-dpng','-r1200');
%%
% histogram
SaveName = [SaveName,'Hist'];
figure;
map = imread(MapName);
imhist(map);
ylabel('Number of Pixels')
title('Histogram for Relative Disparity')
print(gcf,SaveName,'-dpng','-r1200');