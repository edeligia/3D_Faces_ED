% BIDSRename(folder_input, folder_output, name_prior, name_new)
%
% Creates a copy of a BIDS subject folder with renamed code. Specificially:
%   1. filenames are adjusted to use the new code
%   2. *.nii.gz are adjusted to contain files with the new code
%   3. *.json and *.tsv files have the codes adjusted
%
% INPUTS:
%
%   folder_input      char        Path to the root bids folder (contains sub-CODE subfolders)
%
%   folder_output     char        Path to create renamed duplicate in
%
%   name_prior        char        Include sub- (e.g., sub-AB12)
%
%   name_new          char        Include sub- (e.g., sub-01)
%
function rename_BIDS
for sub = 6:6
    for run = 1:8
        name_prior = sprintf('sub-XJ20_task-faces_run-%d', run);
        name_new = sprintf('sub-%02d_ses-01_task-3Dfaces_run-%02d', sub, run);
        folder_input = sprintf('D:\\Faces3D_ED\\Multi_echo\\brainvoyager\\Faces\\BIDS\\derivatives\\sourcedata_bv\\sub-%02d\\ses-01\\func', sub); 
        folder_output = sprintf('D:\\Faces3D_ED\\Multi_echo\\brainvoyager\\Faces\\BIDS\\derivatives\\sourcedata_bv\\sub-%02d\\ses-01\\func', sub); 
        %% Prep
        
        %folders end with filesep
        if folder_input(end) ~= filesep
            folder_input = [folder_input filesep];
        end
        if folder_output(end) ~= filesep
            folder_output = [folder_output filesep];
        end
        
        %add subid to folder paths
        folder_input = [folder_input sprintf('run-%d', run) filesep];
%         folder_output = [folder_output filesep];
        
        %input folder exists
        if ~exist(folder_input, 'dir')
            error('Source folder does not exist: %s', folder_input);
        end
        
        %make output folder
        if ~exist(folder_output, 'dir')
            fprintf('Creating output folder: %s\n', folder_output);
            mkdir(folder_output);
        end
        
        %% Step 1 - Copy Files With Rename
        
        fprintf('Step 1: Copying files with renaming...\n');
        
        %find all files
        list = dir(fullfile(folder_input, '**', '*.*'));
        
        %exclude folders
        list = list(~[list.isdir]);
        
        %copy each file with renaming
        number_files = length(list);
        for f = 1:number_files
            list(f).folder = [list(f).folder filesep];
            
            name = strrep(list(f).name, name_prior, name_new);
            fol = strrep(list(f).folder, folder_input, folder_output);
            fprintf('\tCopying file %d of %d:\n\t\tSource Folder: %s\n\t\tTarget Folder: %s\n\t\tSource Name: %s\n\t\tTarget Name: %s\n', f, number_files, list(f).folder, fol, list(f).name, name);
            
            if ~exist(fol, 'dir')
                mkdir(fol);
            end
            
            fp_out = [fol name];
            if exist(fp_out, 'file')
                fprintf('\t\t\tFile already exists. Skipping!\n');
            else
                copyfile([list(f).folder filesep list(f).name], fp_out);
            end
        end
        
    end
end
%% Done
disp Done.