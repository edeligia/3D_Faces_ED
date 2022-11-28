function generate_par_orders
DIR_IN = ['C:\Users\edeligia\Documents\GitHub\3D_Faces_ED\Scanning\L+R_eye_check\Orders_PILOT' filesep];
run = 1;

for par = 11:30
    
    previousparticipant_filepath = sprintf('%sPAR%02d_RUN%02d.xlsx', DIR_IN, par-1, run);
    [~,~,xls] = xlsread(previousparticipant_filepath);
    
    order_filepath = sprintf('%sPAR%02d_RUN%02d.xlsx', DIR_IN, par, run);
    fprintf('Writing: %s\n', order_filepath);
    xlswrite(order_filepath, xls)
end
end