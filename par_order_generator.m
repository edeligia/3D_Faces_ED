%1 = 3D
%2 = 2D
%3 = PSEUDO
%4 = Monocular 
DIR_OUT = [pwd filesep 'PAR_ORDERS' filesep];
if ~exist(DIR_OUT, 'dir')
    mkdir(DIR_OUT);
end
num_conditions = 4;
num_run = 8; 
num_par = 30;

for par = 1:num_par
    orders = (randperm(8))';
    xls = {'Run Number' 'Order Number'};
    xls((1:num_run)+1,1) = num2cell((1:num_run)');
    xls((1:num_run)+1,2) = num2cell(orders);
    xlswrite(sprintf('%sPAR%02d.xlsx', DIR_OUT, par), xls);
end
