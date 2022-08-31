function faces_make_PRT
mat_filepath = 'C:\Users\edeligia\Documents\GitHub\fMRI_3DFaces_MD_2021\Experiment\Data_PILOT\PAR09_RUN08_PILOT_15-43-20_8-7_2022.mat';
mat_file = load(mat_filepath);
fp_out = 'D:\Faces3D_ED\Multi_echo\brainvoyager\PRT\PRT_excel_templates_faces\Order4.xls';

order = zeros(412,3);
count = 1;
for x=1:412
    order(x,1) = count;
    count = count + 1;
end
for x = 1:412
for cond = 1:6
    switch cond
        case 1
            cond_name = 'Pseudo';
            tf = strcmp({mat_file.d.volume_data(x).condition.Condition},cond_name);
            if tf == 1 && (order(x,3) == 0)
                order(x, 2) = 1;
            elseif tf == 1 && (order(x,3) == 1)
                order(x, 2) = 7;
            end
        case 2
            cond_name = 'MonocL';
            tf = strcmp({mat_file.d.volume_data(x).condition.Condition},cond_name);
            if tf == 1 && (order(x,3) == 0)
                order(x, 2) = 2;
            elseif tf == 1 && (order(x,3) == 1)
                order(x, 2) = 7;
            end
        case 3
            cond_name = '2D';
            tf = strcmp({mat_file.d.volume_data(x).condition.Condition},cond_name);
            if tf == 1 && (order(x,3) == 0)
                order(x, 2) = 3;
            elseif tf == 1 && (order(x,3) == 1)
                order(x, 2) = 7;
            end
        case 4
              cond_name = '3D';
            tf = strcmp({mat_file.d.volume_data(x).condition.Condition},cond_name);
            if tf == 1 && (order(x,3) == 0)
                order(x, 2) = 4;
            elseif tf == 1 && (order(x,3) == 1)
                order(x, 2) = 7;
            end 
        case 5 
              cond_name = 'CUE';
            tf = strcmp({mat_file.d.volume_data(x).condition.Condition},cond_name);
            if tf == 1 && (order(x,3) == 0)
                order(x, 2) = 5; 
            elseif tf == 1 && (order(x,3) == 1)
                order(x, 2) = 7;
            end
        case 6
           cond_name = 'NULL';
           tf = strcmp({mat_file.d.volume_data(x).condition.Condition},cond_name);
            if tf == 1
                order(x, 2) = 6; 
            end
    end
end 
for y = 1:412
order(y,3) = mat_file.d.volume_data(y).condition.Is_Repeat;
end
end 

prt_order = cell(28,5);
prt_order(1,1:5) = {'Condition' 'State#' 'BV Start' 'BV Stop' 'FaceOrder4'};
prt_order(2:14,1) = {'2D Faces', 'Natural 3D', 'Pseudo 3D', 'Monocular 2D', 'Cue', 'OneBack25', 'OneBack26', 'OneBack27', 'OneBack28', 'OneBack29', 'OneBack30', 'OneBack31', 'OneBack32'};

count = 1;
for n = 2:28
prt_order(n,2) = {count};
count = count +1; 
end


m = 1;
counter = 1;  
state = 2;


for m = 1:411
first_row = order(m, 2); 
next_row = order(m+1, 2);

    if (first_row == next_row) && (first_row ~= 6) && (counter == 1) && (first_row ~= 7)
        prt_order(state, 3) = {m};
        counter = counter +1;
        prt_order(state, 5) = {first_row}; 
    elseif (first_row ~= next_row) && (counter ==2) && (first_row ~= 7)
        prt_order(state, 4) = {m};
        counter = 1;
        state = state +1;
    elseif (first_row ~= next_row) && (first_row ~= 6) && (first_row == 7)
        prt_order(state, 3) = {m};
        prt_order(state, 4) = {m};
        prt_order(state, 5) = {first_row}; 
        state = state +1;
    end

end
   
writecell(prt_order, fp_out);

end


