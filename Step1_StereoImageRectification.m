close all
clear all

% Read Stereo Image Pair
I1 = imread('C:\Users\edeligia\Documents\GitHub\fMRI_3DFaces_MD_2021\Experiment\Images_PILOT\Face1_L.png'); % left
I2 = imread('C:\Users\edeligia\Documents\GitHub\fMRI_3DFaces_MD_2021\Experiment\Images_PILOT\Face1_R.png'); % right

% Convert to grayscale.
I1gray = rgb2gray(I1);
I2gray = rgb2gray(I2);

figure(1);
imshowpair(I1, I2,"montage");
title("I1 (left); I2 (right)");

% Create Anaglyph
figure(2); 
imshow(stereoAnaglyph(I1,I2));
title("Composite Image (Red - Left Image, Cyan - Right Image)");

% Collect Interest Points from Each Image
blobs1 = detectSURFFeatures(I1gray,MetricThreshold=2000);
blobs2 = detectSURFFeatures(I2gray,MetricThreshold=2000);

figure(3); 
imshow(I1);
hold on;
plot(selectStrongest(blobs1,30));
title("Thirty Strongest SURF Features In I1");

figure(4); 
imshow(I2); 
hold on;
plot(selectStrongest(blobs2,30));
title("Thirty Strongest SURF Features In I2");

% Find Putative Point Correspondences
[features1,validBlobs1] = extractFeatures(I1gray,blobs1);
[features2,validBlobs2] = extractFeatures(I2gray,blobs2);

indexPairs = matchFeatures(features1,features2,Metric="SAD", ...
  MatchThreshold=5);

matchedPoints1 = validBlobs1(indexPairs(:,1),:);
matchedPoints2 = validBlobs2(indexPairs(:,2),:);

figure(5); 
showMatchedFeatures(I1, I2, matchedPoints1, matchedPoints2);
legend("Putatively Matched Points In I1","Putatively Matched Points In I2");

% Remove Outliers Using Epipolar Constraint
[fMatrix, epipolarInliers, status] = estimateFundamentalMatrix(...
  matchedPoints1,matchedPoints2,Method="RANSAC", ...
  NumTrials=10000,DistanceThreshold=0.1,Confidence=99.99);
  
if status ~= 0 || isEpipoleInImage(fMatrix,size(I1)) ...
  || isEpipoleInImage(fMatrix',size(I2))
  error(["Not enough matching points were found or "...
         "the epipoles are inside the images. Inspect "...
         "and improve the quality of detected features ",...
         "and images."]);
end

inlierPoints1 = matchedPoints1(epipolarInliers, :);
inlierPoints2 = matchedPoints2(epipolarInliers, :);

figure(6);
showMatchedFeatures(I1, I2, inlierPoints1, inlierPoints2);
legend("Inlier Points In I1","Inlier Points In I2");

% Rectify Images
[tform1, tform2] = estimateStereoRectification(fMatrix, ...
  inlierPoints1.Location,inlierPoints2.Location,size(I2));

[I1Rect, I2Rect] = rectifyStereoImages(I1,I2,tform1,tform2);
figure;
imshow(stereoAnaglyph(I1Rect,I2Rect));
title("Rectified Stereo Images (Red - Left Image, Cyan - Right Image)");

%% % Generalize The Rectification Process
% The parameters used in the above steps have been set to fit the two 
% particular stereo images. To process other images, you can use the 
% cvexRectifyStereoImages function, which contains additional logic to 
% automatically adjust the rectification parameters. The image below shows
% the result of processing a pair of images using this function.

%cvexRectifyImages("parkinglot_left.png","parkinglot_right.png");