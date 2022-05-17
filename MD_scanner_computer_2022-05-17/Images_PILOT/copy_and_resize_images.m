RESIZE_FACTOR = 0.225;
FOLDER_RAW = [pwd filesep 'Raw' filesep];

list = dir(FOLDER_RAW);
list = list([list.bytes]>0);

number_files = length(list);
fprintf('Applying resize factor %g to %d images...\n', RESIZE_FACTOR, number_files);
for fid = 1:number_files
    fprintf('Processing %d of %d: %s\n', fid, number_files, list(fid).name);
    
    img = imread([list(fid).folder filesep list(fid).name]);
    img = imresize(img, RESIZE_FACTOR);
    
    filename = strrep(list(fid).name, '.jpg', '.png');
    imwrite(img, filename);
end

disp Done!