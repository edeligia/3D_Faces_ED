

% Read Stereo Image Pair
I1 = imread('C:\Users\edeligia\Documents\GitHub\fMRI_3DFaces_MD_2021\Experiment\Images_PILOT\Face2_L.png'); % left
I2 = imread('C:\Users\edeligia\Documents\GitHub\fMRI_3DFaces_MD_2021\Experiment\Images_PILOT\Face2_R.png'); % right

d = 80;
im1 = circshift(I1,-d,2);
im2 = circshift(I2,d,2);

% change size of output
% im1 = im1(:, 401:1520, :);
% im2 = im2(:, 401:1520, :);

%im1 = I1;
%im2 = I2;
im1g = im2gray(im1);
im2g = im2gray(im2);
disparityRange = [0 96];
disparityMap = disparityBM(im1g,im2g,'DisparityRange',disparityRange,'UniquenessThreshold',0);

figure(1);
imshow(disparityMap,disparityRange)
title('Disparity Map')
colorbar

%print(gcf,SaveName,'-dpng','-r1200');