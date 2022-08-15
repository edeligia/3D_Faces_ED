function copy_middle_echo_dicom
%% Parameters
total_func_volumes = 1236;
% can only run for a single subject at a time
%input folder needs to be path to folder containing each raw series folder
input_folder = 'D:\Faces3D_ED\Multi_echo\raw_DICOMS\P09\DICOM\20220708\2022_07_08_3D_DX16\1.7B540A65';
%output folder points to where new series folders containing only middle
%echo should be saved 
output_folder = 'D:\Faces3D_ED\Multi_echo\raw_DICOMS\P09\DICOM\20220708\2022_07_08_3D_DX16\middle_echo_DICOMS';

%specify which series are functional scans for the specific subject
func_series_to_process = [7, 8, 9, 10, 12, 13, 14, 15] ;

%folders end with filesep
if input_folder(end) ~= filesep
    input_folder = [input_folder filesep];
end
if output_folder(end) ~= filesep
    output_folder = [output_folder filesep];
end
%make output folder
if ~exist(output_folder, 'dir')
    fprintf('Creating output folder: %s\n', output_folder);
    mkdir(output_folder);
end

%% Copy echo DICOMS
for n = 1:8
    series = func_series_to_process(1,n);
    series_folder = sprintf('%s%d', input_folder, series);
    
    %find all files
    list = dir(series_folder);
    list = list(~ismember({list.name},{'.','..'}));
    number_files = length(list);
    if number_files ~= total_func_volumes
        error('raw DICOM folder for series %d does not contain expected number of functional volumes', series);
    end
    
    middle_volumes = 2:3:total_func_volumes;
    for file_num = 1:total_func_volumes
        current_filename = list(file_num).name;
        fileparts = strsplit(current_filename, '.');
        filepart_vol_num = cell2mat(fileparts(1,5));
        filepart_vol_num = str2double(filepart_vol_num);
        match = ismember(middle_volumes, filepart_vol_num);
        is_mid_vol = any(match);
        if is_mid_vol == 1
            vol_source_filepath = [series_folder filesep current_filename];
            vol_target_folder = sprintf('%s%d', output_folder, series);

            %make output folder
            if ~exist(vol_target_folder, 'dir')
                fprintf('Creating output folder: %s\n', vol_target_folder);
                mkdir(vol_target_folder);
            end
            
            fprintf('Currently processing volume %d of %d, filename %s\n', filepart_vol_num, number_files, current_filename);
            
            copyfile(vol_source_filepath, vol_target_folder)
        end
    end
end
end



