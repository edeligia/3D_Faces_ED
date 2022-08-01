function copy_middle_echo_dicom
%% Parameters
total_func_volumes = 1236;
echo_of_choice = 2; % range from 1-3 for 1st, 2nd, 3rd echo
input_folder = 'D:\Faces3D_ED\Multi_echo\raw_DICOMS\P06\DICOM\20220622\2022_06_22_3D_XJ20\1.65ECC648';
output_folder = 'D:\Faces3D_ED\Multi_echo\raw_DICOMS\P06\DICOM\20220622\2022_06_22_3D_XJ20\middle_echo_DICOMS';

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

%specify which series are functional scans
func_series_to_process = [8,9,10,11,13,14,15,16]

%% Copy echo DICOMS 

for series = func_series_to_process(1,1):func_series_to_process(1,8)
    series_folder = sprintf('%s\\%d', input_folder, series);
    
    %find all files
    list = dir(series_folder);
    list = list(~ismember({list.name},{'.','..'}));
    number_files = length(list);
    for vol = 2 :(total_func_volumes - 1)
        for v = 1: number_files
            current_vol = vol + 3;
            current_filename = list(v).name;
            fileparts = strsplit(current_filename, '.');
            filepart_vol_num = cell2mat(fileparts(1,5));
            if filepart_vol_num == current_vol
                vol_source_filepath = [series_folder filesep current_filename];
                vol_target_filepath = sprintf('%s\\%d', output_folder, series);
                %make output folder
                if ~exist(vol_target_filepath, 'dir')
                    fprintf('Creating output folder: %s\n', vol_target_filepath);
                    mkdir(vol_target_filepath);
                end

                fprintf('Currently processing volume %d of %d, filename %s\n', current_vol, number_files, current_filename);
                
                copyfile(vol_source_filepath, vol_target_filepath)
            end
        end
    end
end
end

         
    