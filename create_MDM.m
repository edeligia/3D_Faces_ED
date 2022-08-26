function create_MDM
%% Inputs
% currently the filepaths to the VTCs and SDMs are hardcoded, any changes
% to the naming needs to be reflected at lines 36 and 37
task_name = '3DFaces';
num_par = 9; %max number of participants
num_runs = 8;
working_dir = pwd;
output_dir = [pwd filesep 'group' filesep];
if ~exist(output_dir,'dir'), mkdir(output_dir); end

%set GLM parameters
GLM_type	= 0; %1 for on 0 for off
PSCTransformation = 1; %1 for on 0 for off
zTransformation = 0; %1 for on 0 for off
SeparatePredictors = 2; %predictors of equal name are either concatenated across all runs of all subjects (0), only across runs of the same subject, but separate across subjects (2), or fully separated across runs and subjects (1)

%% Create MDMD
%Check which subjects to process
subs_to_do = zeros(num_par,1);
for par = 1:num_par
    fp_in = sprintf('%s\\sub-%02d',working_dir, par);
    if exist(fp_in, 'file')
        subs_to_do(num_par,1) = true;
    elseif ~exist(fp_in,'file')
        warning(sprintf('No folder found for Par %02d, skipping import\n', par));
    end
    
    run_list = dir([fp_in '*.sdm*']);
    if length(run_list) < num_runs
        warning(sprintf('Fewer than expected number of runs for Par %02d\n', par));
    end
end
fprintf('Subjects to include:');
subs_to_do

total_subs_to_do = sum([subs_to_do]);
% populate mdm with filepaths
mdm = zeros((total_subs_to_do*num_runs), 2);
mdm = num2cell(mdm);

counter = 1;

for par = 1:total_subs_to_do
    for run = 1:num_runs
        filepath_vtc = sprintf('%s\\sub-%02d\\ses-01\\func\\sub-%02d_ses-01_task-%s_run-%02d_bold_SCCTBL_3DMCTS_MNI_THPGLMF3c_SD3DVSS5.00mm.vtc', working_dir, par, par, task_name, run);
        filepath_sdm = sprintf('%s\\sub-%02d\\ses-01\\func\\sub-%02d_ses-01_task-%s_run-%02d_bold_SCCTBL_3DMCTS_MNI_THPGLMF3c_SD3DVSS5.00mm.sdm', working_dir, par, par, task_name, run);
        
        mdm{counter,1} = filepath_vtc;
        mdm{counter,2} = filepath_sdm;
        
        counter = counter + 1;
    end
end

%make mdm and save parameters
mdm_file = xff('mdm');
mdm_file.RFX-GLM = RFX_GLM;
mdm_file.PSCTransformation = PSCTransformation;
mdm_file.zTransformation = zTransformation;
mdm_file.SeparatePredictors = SeparatePredictors;
mdm_file.NrOfStudies = (total_subs_to_do*num_runs);

if RFX_GLM == 1
    GLM_type = 'RFX';
elseif SeparatePredictors == 2
    GLM_type = 'SPSB';
elseif SeparatePredictors == 0
    GLM_type = 'FFX';
end
fp_out = sprintf('%s%s_VTC_N-%d_%s.mdm', output_dir, task_name, (total_subs_to_do*num_runs), GLM_type);
  if exist(fp_out,'file')
        warning(sprintf('MDM file already exists'));
        error
  end
mdm.SaveAs(fp_out);

mdm.ClearObject;

end

