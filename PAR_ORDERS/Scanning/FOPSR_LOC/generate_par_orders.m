function generate_par_orders
DIR_IN = ['C:\Users\edeligia\Documents\GitHub\3D_Faces_ED\Scanning\FOPSR_LOC\Orders_LOC' filesep];

for par = 10:30
    for run = 1:2
        previousparticipant_filepath = sprintf('%sPAR%02d_RUN%02d.xlsx', DIR_IN, par-1, run);
        [~,~,xls] = xlsread(previousparticipant_filepath);
        
        order_filepath = sprintf('%sPAR%02d_RUN%02d.xlsx', DIR_IN, par, run);
        fprintf('Writing: %s\n', order_filepath);
        xlswrite(order_filepath, xls)
    end
end
end