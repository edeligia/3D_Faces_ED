FRAME_SIZE = [775 1134];
FOLDER_RAW = [pwd filesep 'Raw' filesep];

list = dir(FOLDER_RAW);
list = list([list.bytes]>0);

number_files = length(list);
fprintf('Applying frame [%d %d] to %d images...\n', FRAME_SIZE, number_files);
for fid = 1:number_files
    fprintf('Processing %d of %d: %s\n', fid, number_files, list(fid).name);
    
    img = imread([list(fid).folder filesep list(fid).name]);
    sz = size(img);
    
    ratio = min(FRAME_SIZE ./ sz(1:2));
    img = imresize(img, ratio);
    
    imwrite(img, list(fid).name);
end

disp Done!