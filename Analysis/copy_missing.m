function copy_missing

allow_overwrite = true;

load('compare_to_target.mat')

files_to_copy = [files_missing files_different];

num = length(files_to_copy);
for i = 1:num
    fid = files_to_copy(i);
    file = files{fid};
    fprintf('Copying %d/%d: %s\n',i,num,file);
    
    f = file;
    fol = folder_target;
    while 1
        ind = find(f==filesep,1,'first');
        if isempty(ind)
            break
        else
            part = f(1:ind);
            fol = [fol part];
            f = f(ind+1:end);
            if ~exist(fol,'dir'), mkdir(fol);, end
        end
    end
    
    fp_source = [folder_source file];
    fp_target = [folder_target file];
    try
		if allow_overwrite
			copyfile(fp_source, fp_target, 'f')
		else
			copyfile(fp_source, fp_target)
		end		
    catch err
        err
    end
    
end

disp Done.