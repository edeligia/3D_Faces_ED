function generate_par_orders_3D_faces

DIR_IN_PAR = [pwd filesep 'PAR_ORDERS' filesep];
DIR_IN_RUN = [pwd filesep 'RUN_ORDERS' filesep];
DIR_OUT = ['C:\Users\edeligia\Documents\GitHub\fMRI_3DFaces_MD_2021\Experiment\Orders' filesep];

for par = 2:30
    
    runfilepath = sprintf('%sPAR%02d.xlsx', DIR_IN_PAR, par);

    [~,~,xls] = xlsread(runfilepath);
    
for run = 1:8 
    
   order_num = xls{run+1, 2}; 
   
   orderfilepath = sprintf('%sRUN%02d.xlsx', DIR_IN_RUN, order_num);
   
   [~, ~, order] = xlsread(orderfilepath); 

    order_filepath = sprintf('%sPAR%02d_RUN%02d.xlsx', DIR_OUT, par, run);
    fprintf('Writing: %s\n', order_filepath);
    xlswrite(order_filepath, order)
end
end