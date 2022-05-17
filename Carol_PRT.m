%Types: LOC CHP4 CHP7 CHP32 ACT19 ACT61 
function Carol_PRT(type)

%% param
p.include_baseline = false; %includes baselines and null
p.allow_overwrite = true; %probably leave true
p.baseline_always_includes_first_last = false; %include 16sec baseline even if p.include_baseline is false
p.exclude_one_back = true;
p.COMBINE_EVENTS = true;

%%
type = upper(type);
p.folder_data = [pwd filesep 'Data_' type(1:3) filesep];

addy='';
if p.COMBINE_EVENTS
    addy = [addy '_CombineEvents'];
end
if p.include_baseline
    addy = [addy '_WithBaseline'];
end
p.folder_prt = [pwd filesep 'PRT_' type addy filesep];
p.experimentName = ['Carol_' type];

%% prep
if ~exist(p.folder_prt,'dir'), mkdir(p.folder_prt);, end

list = dir([p.folder_data '*.mat']);

c=0;
switch type
    case 'LOC'
        if p.include_baseline
        c=c+1;
        cond(c).name = 'Baseline';
        cond(c).cond_names = {'Null'};
        cond(c).image_names = {};
        colours(c,:) = [0 0 0];
        end
        
        c=c+1;
        cond(c).name = 'Food';
        cond(c).cond_names = {'Food'};
        cond(c).image_names = {};
        colours(c,:) = [255 102 102];
        
        c=c+1;
        cond(c).name = 'Object';
        cond(c).cond_names = {'Object'};
        cond(c).image_names = {};
        colours(c,:) = [0 0 255];
        
        c=c+1;
        cond(c).name = 'Animal';
        cond(c).cond_names = {'Animal'};
        cond(c).image_names = {};
        colours(c,:) = [0 128 64];
        
        c=c+1;
        cond(c).name = 'Scrambled';
        cond(c).cond_names = {'Scrambled'};
        cond(c).image_names = {};
        colours(c,:) = [102 102 102];
    case 'Faces'
        if p.include_baseline
            c=c+1;
            cond(c).name = 'Baseline';
            cond(c).cond_names = {'Null'};
            cond(c).image_names = {};
            colours(c,:) = [0 0 0];
        end
        
        c=c+1;
        cond(c).name = 'Food';
        cond(c).cond_names = {'Food'};
        cond(c).image_names = {};
        colours(c,:) = [255 102 102];
        
        c=c+1;
        cond(c).name = 'Object';
        cond(c).cond_names = {'Object'};
        cond(c).image_names = {};
        colours(c,:) = [0 0 255];
        
        c=c+1;
        cond(c).name = 'Animal';
        cond(c).cond_names = {'Animal'};
        cond(c).image_names = {};
        colours(c,:) = [0 128 64];
        
        c=c+1;
        cond(c).name = 'Scrambled';
        cond(c).cond_names = {'Scrambled'};
        cond(c).image_names = {};
        colours(c,:) = [102 102 102];
        
%     case 'CHP4'
%         
%         if p.include_baseline
%         c=c+1;
%         cond(c).name = 'Baseline';
%         cond(c).cond_names = {'Null'};
%         cond(c).image_names = {};
%         colours(c,:) = [0 0 0];
%         end
%         
%         c=c+1;
%         cond(c).name = 'Food_PL';
%         cond(c).cond_names = {'Food_PL'};
%         cond(c).image_names = {};
% %         colours(c,:) = [255 102 102];
%         
%         c=c+1;
%         cond(c).name = 'Food_PH';
%         cond(c).cond_names = {'Food_PH'};
%         cond(c).image_names = {};
% %         colours(c,:) = [0 0 255];
%         
%         c=c+1;
%         cond(c).name = 'Food_UL';
%         cond(c).cond_names = {'Food_UL'};
%         cond(c).image_names = {};
% %         colours(c,:) = [0 128 64];
%         
%         c=c+1;
%         cond(c).name = 'Food_UH';
%         cond(c).cond_names = {'Food_UH'};
%         cond(c).image_names = {};
% %         colours(c,:) = [102 102 102];
%         
%         if p.include_baseline
%         colours(2:c,:) = round(jet(c-1) * 255);
%         else
%         colours(1:c,:) = round(jet(c) * 255);    
%         end
%     
%     case 'CHP7' % Food_UL is all healthy, else 1-4 unhealthy 5-8 healthy
%         
%         if p.include_baseline
%         c=c+1;
%         cond(c).name = 'Baseline';
%         cond(c).cond_names = {'Null'};
%         cond(c).image_names = {};
%         colours(c,:) = [0 0 0];
%         end
%         
%         c=c+1;
%         cond(c).name = 'Food_PL_Unhealthy';
%         cond(c).cond_names = {};
%         cond(c).image_names = arrayfun(@(x) sprintf('Food_PL%d.jpg',x), 1:4, 'UniformOutput', false);
%         
%         c=c+1;
%         cond(c).name = 'Food_PL_Healthy';
%         cond(c).cond_names = {};
%         cond(c).image_names = arrayfun(@(x) sprintf('Food_PL%d.jpg',x), 5:8, 'UniformOutput', false);
%         
%         c=c+1;
%         cond(c).name = 'Food_PH_Unhealthy';
%         cond(c).cond_names = {};
%         cond(c).image_names = arrayfun(@(x) sprintf('Food_PH%d.jpg',x), 1:4, 'UniformOutput', false);
%         
%         c=c+1;
%         cond(c).name = 'Food_PH_Healthy';
%         cond(c).cond_names = {};
%         cond(c).image_names = arrayfun(@(x) sprintf('Food_PH%d.jpg',x), 5:8, 'UniformOutput', false);
%         
%         c=c+1;
%         cond(c).name = 'Food_UL_Healthy';
%         cond(c).cond_names = {'Food_UL'};
%         cond(c).image_names = {};
%         
%         c=c+1;
%         cond(c).name = 'Food_UH_Unhealthy';
%         cond(c).cond_names = {};
%         cond(c).image_names = arrayfun(@(x) sprintf('Food_UH%d.jpg',x), 1:4, 'UniformOutput', false);
%         
%         c=c+1;
%         cond(c).name = 'Food_UH_Healthy';
%         cond(c).cond_names = {};
%         cond(c).image_names = arrayfun(@(x) sprintf('Food_UH%d.jpg',x), 5:8, 'UniformOutput', false);
%         
%         if p.include_baseline
%         colours(2:c,:) = round(jet(c-1) * 255);
%         else
%         colours(1:c,:) = round(jet(c) * 255);    
%         end
%         
%     case 'CHP32'
%         
%         if p.include_baseline
%         c=c+1;
%         cond(c).name = 'Baseline';
%         cond(c).cond_names = {'Null'};
%         cond(c).image_names = {};
%         colours(c,:) = [0 0 0];
%         end
%         
%         for conds = {'Food_PL' 'Food_PH' 'Food_UL' 'Food_UH'}
%             for id = 1:8
%                 
%                 c=c+1;
%                 cond(c).name = sprintf('%s_%d',conds{1},id);
%                 cond(c).cond_names = {};
%                 cond(c).image_names = {sprintf('%s%d.jpg',conds{1},id)};
%                 
%             end
%         end
%         
%         if p.include_baseline
%         colours(2:c,:) = round(jet(c-1) * 255);
%         else
%         colours(1:c,:) = round(jet(c) * 255);    
%         end
%         
%     case 'ACT19'
%         
%         if p.include_baseline
%         c=c+1;
%         cond(c).name = 'Baseline';
%         cond(c).cond_names = {'Null'};
%         cond(c).image_names = {};
%         colours(c,:) = [0 0 0];
%         end
%         
%         conditions = { 'Food_1H',
%                         'Food_2H',
%                         'Food_Fork',
%                         'Food_Chopstick',
%                         'Food_Spoon',
%                         'Food_Knife',
%                         'Object_Hand',
%                         'Object_Mouth',
%                         'Tool_Normal',
%                         'Tool_Chopstick',
%                         'Tool_Fork',
%                         'Tool_Spoon',
%                         'Tool_Knife',
%                         'Body_1H',
%                         'Body_2H',
%                         'Body_Mouth',
%                         'Body_Eyes',
%                         'Body_Legs'};  
%         
%         for ci = conditions'
%             
%                 c=c+1;
%                 cond(c).name = ci{1};
%                 cond(c).cond_names = ci{1};
%                 cond(c).image_names = {};
%                 
%         end
%         
%         c=c+1;
%         cond(c).name = 'Scrambled';
%         cond(c).cond_names = {};
%         cond(c).image_names = {};
%         cond(c).compare = 'scramble';
%         
%         if p.include_baseline
%         colours(2:c,:) = round(jet(c-1) * 255);
%         else
%         colours(1:c,:) = round(jet(c) * 255);    
%         end
%                         
%     case 'ACT61'
%         
%         if p.include_baseline
%         c=c+1;
%         cond(c).name = 'Baseline';
%         cond(c).cond_names = {'Null'};
%         cond(c).image_names = {};
%         colours(c,:) = [0 0 0];
%         end
%         
%         conditions = { 'Food_1H',
%                         'Food_2H',
%                         'Food_Fork',
%                         'Food_Chopstick',
%                         'Food_Spoon',
%                         'Food_Knife',
%                         'Object_Hand',
%                         'Object_Mouth',
%                         'Tool_Normal',
%                         'Tool_Chopstick',
%                         'Tool_Fork',
%                         'Tool_Spoon',
%                         'Tool_Knife',
%                         'Body_1H',
%                         'Body_2H',
%                         'Body_Mouth',
%                         'Body_Eyes',
%                         'Body_Legs'};  
%                     
%         for id = 1:length(conditions) %have 6 images each
%             
%             if id<=2
%                 num_img = 6;
%             else
%                 num_img = 3;
%             end
%             
%             for i = 1:num_img
%             
%                 c=c+1;
%                 cond(c).name = sprintf('%s_%d',conditions{id},i);
%                 cond(c).cond_names = {};
%                 cond(c).image_names = sprintf('%s%d.jpg',conditions{id},i);
%             
%             end
%         end
%         
%         c=c+1;
%         cond(c).name = 'Scrambled';
%         cond(c).cond_names = {};
%         cond(c).image_names = {};
%         cond(c).compare = 'scramble';
%         
%         if p.include_baseline
%         colours(2:c,:) = round(jet(c-1) * 255);
%         else
%         colours(1:c,:) = round(jet(c) * 255);    
%         end
        
    otherwise
        error
end
number_conditions = c;

%% run
for fid = 1:length(list)
    fn = list(fid).name;
    loaded = load([p.folder_data fn]);
    
    fn_out = [fn(1:find(fn=='.',1,'last')-1) '.prt'];
    fpOut = [p.folder_prt fn_out];
    if ~p.allow_overwrite & exist(fpOut)
        error('PRT already exists and will not overwrite existing file!')
    end
    fid = fopen(fpOut,'w');
    
    fprintf(fid,'\n');
    fprintf(fid,'FileVersion:        2\n');
    fprintf(fid,'\n');
    fprintf(fid,'ResolutionOfTime:   Volumes\n');
    fprintf(fid,'\n');
    fprintf(fid,'Experiment:         %s\n',p.experimentName);
    fprintf(fid,'\n');
    fprintf(fid,'BackgroundColor:    0 0 0\n');
    fprintf(fid,'TextColor:          255 255 255\n');
    fprintf(fid,'TimeCourseColor:    255 255 255\n');
    fprintf(fid,'TimeCourseThick:    3\n');
    fprintf(fid,'ReferenceFuncColor: 0 0 80\n');
    fprintf(fid,'ReferenceFuncThick: 3\n');
    fprintf(fid,'\n');
    fprintf(fid,'NrOfConditions:  %d\n',number_conditions);
    fprintf(fid,'\n');
    
    order = loaded.d.order(2:end,:);
    order_rows = size(order,1);
    
    for c = 1:number_conditions
        cond_name = cond(c).name;
        cond_conds = cond(c).cond_names;
        cond_images = cond(c).image_names;
        fprintf(fid,'%s\n',cond_name);
        
        events = [];
        
        v=1;
        for row = 1:order_rows
            if ~p.exclude_one_back | ~order{row,5} %ignore one-back
                
                if (p.baseline_always_includes_first_last & strcmp(cond_name,'Baseline') & (row==1 | row==order_rows)) | ...
                        (length(cond_conds) & any(strcmp(lower(cond_conds),lower(order(row,2))))) | ...
                        (length(cond_images) & ~any(isnan(order{row,4})) & any(strcmp(lower(cond_images),lower(order(row,4))))) | ...
                        (any(strcmp(fields(cond),'compare')) & ~any(isnan(order{row,4})) & ~isempty(strfind(lower(order{row,4}),lower(cond(c).compare))))
                    
                    if strcmp(cond_name,'Baseline') | strcmp(upper(type),'LOC') 
                        events(end+1,:) = [v v+order{row,3}-1];
                    else
                        events(end+1,:) = [v v];
                    end
                
                end
            end
            
            
%             if ~order{row,5} %ignore one-back
%                 if (strcmp(cond_search,'Baseline') & ((row==1 | row==order_rows) | (p.baseline_all & strcmp(lower(order(row,2)),'null')))) | ...
%                         strcmp(lower(cond_search),lower(order(row,2)))
%                     events(end+1,:) = [v v+order{row,3}-1];
%                 end
%             end
            v=v+order{row,3};
        end
        
        if p.COMBINE_EVENTS
        %combine events
        for i =  size(events,1)-1:-1:1
            if events(i,2) >= (events(i+1,1)-1)
                events(i,:) = [events(i,1) events(i+1,2)];
                events(i+1,:) = [];
            end
        end
        end
		
		%write volumes
		fprintf(fid,'%d\n',size(events,1));
        for i = 1:size(events,1)
            fprintf(fid,'%d %d\n', events(i,1), events(i,2));
        end
        
        fprintf(fid,'Color:  %d %d %d\n',colours(c,:));
        fprintf(fid,'\n');
    end
    
    fclose(fid);
end