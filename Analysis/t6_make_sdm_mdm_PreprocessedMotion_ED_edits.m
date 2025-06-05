decon_count = 41;
num_sub = 19;

rel_paths = false;

use_raw_vtc = false;
if use_raw_vtc
    suffix_smooth = '_NoTHP_NoSmooth';
else
    suffix_smooth = '';
end

mode = 2;
switch mode
    case 1
        task_name = 'Depth_loc';
        root = 'D:\Faces3D_ED\Multi_echo\brainvoyager\Depth_loc-mid_echo\BIDS\derivatives\sourcedata_bv\';
        vols = 336;
        max_runs = 2;
        
        valid_runs = true(num_sub, max_runs);
         valid_runs(7,2) = false;
         valid_runs(8,2) = false;
         valid_runs(10,:) = false;
         valid_runs(11,2) = false;
       
        vol_exceptions = nan(num_sub,max_runs);
%         vol_exceptions(14,:) = 336;
    case 2
        task_name = 'FOPSR';
        root = 'D:\3D_SizeFace_ED_2025\FOPSRLoc\Analysis\BIDS\derivatives\rawdata_bv\';
        vols = 496;
        max_runs = 1;
        
        % valid_runs = true(num_sub, max_runs);
        % valid_runs(2:16, 3) = false;
        % valid_runs(18:24, 3) = false; 
        % valid_runs(1,:) = false;
        % valid_runs(2:3,2) = false;
        % valid_runs(9,2) = false;
        % valid_runs(5,2) = false;
        % valid_runs(23,2) = false;
        % valid_runs(4,1) = false;
        % valid_runs(17,1) = false;

        vol_exceptions = nan(num_sub,max_runs);
    case 3
        task_name = 'faces';
        root = 'D:\3DFaces_ED_2022\multi-echo\brainvoyager\Faces\BIDS\derivatives\rawdata_bv\';
        vols = 412;
        max_runs = 8;

        valid_runs = true(num_sub, max_runs);        
        valid_runs(1,:) = false;
%         valid_runs(9,:) = false;
%         valid_runs(3:4,:) = false;
%         valid_runs(16,:) = false;        
%         valid_runs(18,:) = false;        
%         valid_runs(23,:) = false;

        vol_exceptions = nan(num_sub,max_runs);
    otherwise
        error
end

param.rcond = []; %predictors to discard
param.prtr = 1000; %TR
param.nvol = vols; %number volumes



%%

list_sdm_standard = cell(0);
list_sdm_standard_poni = cell(0);
list_sdm_decon = cell(0);
list_sdm_decon_poni = cell(0);
list_vtc = cell(0);

counter = 0;

for sub = 1:num_sub
    fprintf('Participant %d of %d...\n', sub, num_sub);
    
    fol = sprintf('%ssub-%02d%sfunc%s', root, sub, filesep, filesep);
    for run = 1:max_runs
        if ~valid_runs(sub,run)
            continue;
        end
        
        %%
        
        counter = counter + 1;
        
        %% VTC
        
        if use_raw_vtc
            fp_vtc = sprintf('%ssub-%02d_ses-01_task-%s_run-%02d_bold_SCCTBL_3DMCTS_MNI.vtc', fol, sub, task_name, run);
        else
            fp_vtc = sprintf('%ssub-%02d_task-%s_run-%d_desc-optcomDenoised_bold_MNI_THPGLMF3c_SD3DVSS5.00mm.vtc', fol, sub, task_name, run);
        end
        if ~exist(fp_vtc, 'file')
            error('Missing: %s', fp_vtc)
        else
            list_vtc{counter} = fp_vtc;
        end
        
        %% load prt
        
        fp_prt = sprintf('%ssub-%02d_ses-01_task-3DFaces_run-%d.prt', fol, sub, run);
        if ~exist(fp_prt, 'file')
            error('Missing: %s', fp_prt)
        else
            prt = xff(fp_prt);
        end
        
%         %% load motion
%         
% %         fp_motion = sprintf('%ssub-%02d_ses-01_task-%s_run-%02d_bold_SCCTBL_3DMC.sdm', fol, sub, task_name, run);
%          fp_motion = sprintf('%smotion_sdm\\sub-%02d_ses-01_task-%s_run-%02d_bold_SCCTBL_3DMC_THPGLMF3c.sdm', fol, sub, task_name, run);
%         if ~exist(fp_motion, 'file')
%             error('Missing: %s', fp_motion);
%         end
%         sdm_mtn = xff(fp_motion);
%         
        %% SDM
        
        param_use = param;
        if ~isnan(vol_exceptions(sub,run))
            param_use.nvol = vol_exceptions(sub,run);
        end
%         
%         %create
%         sdm = prt.CreateSDM(param_use);
%         
        %save
        fp_sdm = sprintf('%ssub-%02d_task-%s_run-%d.sdm', fol, sub, task_name, run);
%           sdm.SaveAs(fp_sdm);
        list_sdm_standard{counter} = fp_sdm;
        
        fp_gppi_sdms = 'D:\3DFaces_ED_2022\multi-echo\brainvoyager\Faces\BIDS\derivatives\rawdata_bv\';
        fp_sdm_gppi = sprintf('%sgPPI_sub-%02d_task-%s_run-%d_desc-optcomDenoised_bold_MNI_THPGLMF3c_SD3DVSS5.00mm_rIPS0_depth-loct3.5ANDWang.sdm', fp_gppi_sdms, sub, task_name, run);  
        list_sdm_gppi{counter} = fp_sdm_gppi;

%         %add motion
%         sdm.SDMMatrix = [sdm.SDMMatrix(:,1:end-1) sdm_mtn.SDMMatrix(:,1:6) sdm.SDMMatrix(:,end)];
%         sdm.PredictorNames = [sdm.PredictorNames(1:end-1) sdm_mtn.PredictorNames(1:6) sdm.PredictorNames(end)];
%         sdm.PredictorColors = [sdm.PredictorColors(1:end-1,:); sdm_mtn.PredictorColors(1:6,:); sdm.PredictorColors(end,:)];
%         sdm.NrOfPredictors = sdm.NrOfPredictors + 6; 
%         
%         %save
%         fp_sdm = sprintf('%ssub-%02d_ses-01_%s_run-%d_PreprocessedMotionPONI.sdm', fol, sub, task_name, run);
%           sdm.SaveAs(fp_sdm);
%         list_sdm_standard_poni{counter} = fp_sdm;
%         
%         %% SDM Decon
%         
%         matrix = zeros(param_use.nvol,0);
%         names = cell(0);
%         colours = [];
%         
%         number_main_cond = sdm.FirstConfoundPredictor - 1;
%         for c = 1:number_main_cond
%             onsets = prt.Cond(c).OnOffsets(:,1);
%             
%             for i = 0:(decon_count-1)
%                 ind = size(matrix, 2) + 1;
%                 
%                 vols = onsets + i;
%                 
%                 matrix(vols,ind) = 1;
%                 names{ind} = sprintf('%s_D%d', sdm.PredictorNames{c}, i);
%                 colours(ind,:) = sdm.PredictorColors(c,:);
%             end
%         end
%         %trim
%         matrix = matrix(1:param_use.nvol,:);
%         
%         %count
%         num_decon_preds = size(matrix,2);
%         
%         %constant
%         ind_const = num_decon_preds + 1;
%         matrix(:,ind_const) = 1;
%         names{ind_const} = 'Constant';
%         colours(ind_const,:) = [255 255 255];
%         
%         %sdm
%         sdm.NrOfPredictors = num_decon_preds + 1;
%         sdm.FirstConfoundPredictor = num_decon_preds + 1;
%         sdm.PredictorColors = colours;
%         sdm.PredictorNames = names;
%         sdm.SDMMatrix = matrix;
%         sdm.RTCMatrix = matrix(:, 1:num_decon_preds);
%         
%         %save
%         fp_sdm = sprintf('%ssub-%02d_ses-01_%s_run-%d_Decon%d.sdm', fol, sub, task_name, run, decon_count);
% %         sdm.SaveAs(fp_sdm);
%         list_sdm_decon{counter} = fp_sdm;
%         
%         %add motion
%         sdm.SDMMatrix = [sdm.SDMMatrix(:,1:end-1) sdm_mtn.SDMMatrix(:,1:6) sdm.SDMMatrix(:,end)];
%         sdm.PredictorNames = [sdm.PredictorNames(1:end-1) sdm_mtn.PredictorNames(1:6) sdm.PredictorNames(end)];
%         sdm.PredictorColors = [sdm.PredictorColors(1:end-1,:); sdm_mtn.PredictorColors(1:6,:); sdm.PredictorColors(end,:)];
%         sdm.NrOfPredictors = sdm.NrOfPredictors + 6; 
% 
%         %save
%         fp_sdm = sprintf('%ssub-%02d_ses-01_%s_run-%d_Decon%d_PreprocessedMotionPONI.sdm', fol, sub, task_name, run, decon_count);
% %          sdm.SaveAs(fp_sdm);
%         list_sdm_decon_poni{counter} = fp_sdm;
%         
        %% cleanup
        prt.ClearObject;
%         sdm.ClearObject;
%         sdm_mtn.ClearObject;
    end
end

%% mdm

for RFX = [false true]
    if RFX
        suffix = '_RFX';
    else
        suffix = '_FFX';
    end
    
for type = [5] %1:4
    has_motion_poni = false;
    switch type
        case 1
            name = 'Standard_sdm_no_motion_regs';
            sdms = list_sdm_standard;
        case 2
            name = 'Standard';
            has_motion_poni = true;
            sdms = list_sdm_standard_poni;
        case 3
            name = sprintf('Decon%d', decon_count);
            sdms = list_sdm_decon;
        case 4
            name = sprintf('Decon%d', decon_count);
            has_motion_poni = true;
            sdms = list_sdm_decon_poni;
        case 5
            name = sprintf('Standard_gPPI_rIPS0');
            sdms = list_sdm_gppi;
        otherwise
            error
    end
    
    if has_motion_poni
        name = [name '_PreprocessedMotionPONI'];
    end
    
    mdm = xff('mdm');
    mdm.FileVersion = 3;
    mdm.TypeOfFunctionalData = 'VTC';
    mdm.RFX_GLM = RFX;
    mdm.PSCTransformation = 1;
    mdm.zTransformation = 0;
    mdm.SeparatePredictors = 0;
    mdm.NrOfStudies = counter;

    mdm.XTC_RTC = [list_vtc' sdms'];
    
    %use relative paths
    if rel_paths
        mdm.XTC_RTC = strrep(mdm.XTC_RTC, root, '\');
    end
    
    fp_mdm = sprintf('%sGroup_%s_%s%s%s.mdm', root, task_name, name, suffix_smooth, suffix);
    mdm.SaveAs(fp_mdm);
    
    fp_junk = [fp_mdm(1:end-3) 'rtv'];
    if exist(fp_junk, 'file')
        delete(fp_junk)
    end
    
    mdm.ClearObject;
end
end

