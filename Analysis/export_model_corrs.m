function export_model_corrs
output_fol = "D:\3DFaces_ED_2022\multi-echo\brainvoyager\Faces\BIDS\derivatives\rawdata_bv\RSA_depth-areas\";
%% read Model Corrs
try
    load('D:\3DFaces_ED_2022\multi-echo\brainvoyager\Faces\BIDS\derivatives\rawdata_bv\RSA_depth-areas\ROI\7. ROI Model Correlations\VOI_corrs.mat');
catch err
    warning('Could not load VOI corrss. Has VOI step7 been run or has data moved?')
    rethrow(err);
end

num_vois = length(corrs_split(1,1,:));

for v= 1:num_vois
    voi_name = voi_names{v};
    output_filename = sprintf('%smodel_corrs_%s.xlsx', output_fol,voi_name);
    model_corrs = corrs_split(:,4:6,v);
    writematrix(model_corrs, output_filename)
end 
