function average_img

% Get a file specification.
folder = pwd; % Wherever you want.
filePattern = fullfile(folder, 'Face*.png'); % Adapt as needed.

% Get files in the folder matching that specification.
fileList = dir(filePattern);
numberOfFiles = numel(fileList);
numberOfFilesSummed = 0;

% Concatenate all filenames into one cell array for convenience.
allFileNames = fullfile(folder, {fileList.name});

% Read in first image and put it into the sum image.
sumImage = double(imread(allFileNames{1}));
firstSize = size(sumImage);

% Read in remaining images and sum them in.
for k = 2 : numberOfFiles
	% Read in RGB image.
    rgbImage = imread(allFileNames{k});
	% Display the image.
	imshow(rgbImage);
	caption = sprintf('File #%d of %d : "%s"', fileList(k).name);
	title(caption);
	drawnow;
	% Make sure size matches that of the very first image.
	if ~isequal(firstSize, size(rgbImage))
		fprintf('Skipping "%s"\n    because size does not match that of the first image\n', allFileNames{k});
		continue;
	end
	% Sum in the image.
    sumImage = sumImage + double(rgbImage);
	% Increment the number of images we actually summed.
	numberOfFilesSummed = numberOfFilesSummed + 1;
end
% Divide by the number of images to get the mean.
meanImage = sumImage / numberOfFilesSummed;
meanImage = uint8(meanImage);
% Display the floating point mean image with [] to scale it properly.
imshow(meanImage, []);
imwrite(meanImage, "avg_face_L+R.png")
end