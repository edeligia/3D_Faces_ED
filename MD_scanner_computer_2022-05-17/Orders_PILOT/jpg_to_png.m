list =  dir('*.xlsx');

for fid = 1:length(list)
    fp = [list(fid).folder filesep list(fid).name];
    [~,~,xls] = xlsread(fp);
    
    for col = [4 5]
        values = xls(:,col);
        is_char = cellfun(@ischar, values);
        xls(is_char,col) = cellfun(@(x) strrep(x, '.jpg', '.png'), values(is_char), 'UniformOutput', false);
    end
    
    xlswrite(fp, xls);
end

disp Done!