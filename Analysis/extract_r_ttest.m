function extract_r_ttest
%read main parameters
p = Get_Main_Params;
output_filename = 'D:\3DFaces_ED_2022\multi-echo\brainvoyager\Faces\BIDS\derivatives\rawdata_bv\RSA_rpSTS\summary_ttests_correlations_rpSTS.xlsx';

%% read VOI RSMs
try
    load([p.FILEPATH_TO_SAVE_LOCATION p.SUBFOLDER_ROI_DATA filesep '6. ROI RSMs' filesep 'VOI_RSMs.mat']);
catch err
    warning('Could not load VOI RSMs. Has VOI step6 been run or has data moved?')
    rethrow(err);
end

count_vois = length(data.RSM_split(1,1,1,:));
num_vois = length(data.VOINames);
if count_vois ~= num_vois
    error
end
name_vois = data.VOINames_short;
num_pars = p.NUMBER_OF_PARTICIPANTS;
Results = {'a-b_significant';'a-b_p-value';'c-d_significant';'c-d_p-value';'e-f_significant';'e-f_p-value'};
voi_summary_stats=table(Results);

for v = 1:num_vois
    voi={data.VOINames{v}};
    voi_cells=cell(6,1);
    voi_data = data.RSM_split(:,:,:,v);
    mean_a = mean([voi_data(1,1,:) voi_data(2,2,:)],2);
    mean_b = mean([voi_data(1,2,:) voi_data(2,1,:)],2);
    [h,p] = ttest(mean_a, mean_b);
    if h==1
        voi_cells{1,1}='TRUE';
    elseif h==0
        voi_cells{1,1}='FALSE';
    end
    voi_cells{2,1}=p;

    mean_c = mean([voi_data(2,2,:) voi_data(3,3,:)],2);
    mean_d = mean([voi_data(2,3,:) voi_data(3,2,:)],2);
    [h,p] = ttest(mean_c, mean_d);
    if h==1
        voi_cells{3,1}='TRUE';
    elseif h==0
        voi_cells{3,1}='FALSE';
    end
    voi_cells{4,1}=p;
    
    mean_e = mean([voi_data(1,1,:) voi_data(4,4,:)],2);
    mean_f = mean([voi_data(1,4,:) voi_data(4,1,:)],2);
    [h,p] = ttest(mean_e, mean_f);
    if h==1
        voi_cells{5,1}='TRUE';
    elseif h==0
        voi_cells{5,1}='FALSE';
    end
    voi_cells{6,1}=p;
    voi_cells=cell2table(voi_cells,"VariableNames",voi);
    voi_summary_stats=[voi_summary_stats voi_cells];
end
writetable(voi_summary_stats, output_filename)

%%
function [p] = Get_Main_Params
return_path = pwd;
main_path = [return_path filesep];
try
    cd(main_path)
    p = ALL_STEP0_PARAMETERS;
    cd(return_path);
catch err
    cd(return_path);
    rethrow(err);
end
