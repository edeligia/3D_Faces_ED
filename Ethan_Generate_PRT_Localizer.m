function Ethan_Generate_PRT

%% Notes
%units are in volumes
%block baselines are included in fixation predictors
%run baselines are not included in the far fixation (only baseline predictor)
%transition predictors span the 10sec (block initial baseline) during which the move may be made
%if the final block is near, thne the final baseline (far fixation) is NOT considered a "transition to far" even though fixation position changes

%% Parameters
param.experimentName = 'Psych9223';
param.outputFolder = [pwd filesep 'PRTs_Localizer' filesep];
param.includeError = false;

%% Conditions/Predictors
cond.names = {'Body' 'Face' 'Hand' 'Scrambled'};
if param.includeError
    cond.names{end+1} = cond.names{end}
	cond.names{end} = 'Error';
end
cond.numCond = length(cond.names);
cond.colours = round(jet(cond.numCond)*255);

%% File Select
fprintf('Select one or more mat files to create PRT from...\n')
[fileNames,param.pathName] = uigetfile('*_Localizer_*.mat','multiselect','on');
if isnumeric(fileNames) & ~fileNames
    fprintf('No file selected.\n')
    return
end
if ~iscell(fileNames), fileNames = {fileNames};, end

%% Prepare Output Folder
if param.outputFolder(end) ~= filesep, param.outputFolder(end+1) = filesep;, end
if ~exist(param.outputFolder)
    mkdir(param.outputFolder)
end

%% Create PRT for Each File
for i = 1:length(fileNames)
    generatePRT(fileNames{i},param,cond)
end

%% Done
disp Done.

%%%% Based on prt_maker
function generatePRT(filename,param,cond)
%% Display
fp = [param.pathName filename];
fprintf('Generating PRT for: %s\n',fp)

%% Load file
file = load(fp);

% % %% Check file
numVol = size(file.d.sched,1);
% % if numVol ~= file.d.numVol
% %     %NOTE: you can comment out this error and create a PRT anyway if needed
% %     error('Run appears to have been incomplete!')
% % end

%% Prepare output file
filename = [filename(1:find(filename=='.',1,'last')-1) '.prt'];
fpOut = [param.outputFolder filename];
if exist(fpOut)
    error('PRT already exists and will not overwrite existing file!')
end
fid = fopen(fpOut,'w');

%% Write header
fprintf(fid,'\n');
fprintf(fid,'FileVersion:        2\n');
fprintf(fid,'\n');
fprintf(fid,'ResolutionOfTime:   Volumes\n');
fprintf(fid,'\n');
fprintf(fid,'Experiment:         %s\n',param.experimentName);
fprintf(fid,'\n');
fprintf(fid,'BackgroundColor:    0 0 0\n');
fprintf(fid,'TextColor:          255 255 255\n');
fprintf(fid,'TimeCourseColor:    255 255 255\n');
fprintf(fid,'TimeCourseThick:    3\n');
fprintf(fid,'ReferenceFuncColor: 0 0 80\n');
fprintf(fid,'ReferenceFuncThick: 3\n');
fprintf(fid,'\n');
fprintf(fid,'NrOfConditions:  %d\n',cond.numCond);
fprintf(fid,'\n');

%% Find predictors and write
for p = 1:cond.numCond
    cond_search = cond.names{p};
    if ~length(cond_search) %placeholder
        continue
    end
    fprintf(fid,'%s\n',cond_search);
    
    %number of events
    events = [];
    
    %rename
    ind = find(cond_search=='_');
    if length(ind)>1
        cond_search = cond_search(1:ind(2)-1);
    end
    
    v = 1;
    
    for row = 2:size(file.d.order,1)
        is_cond = false;
        
        vstart = v;
        v = v + file.d.order{row,3};
        vend = v-1;
        
        cond_file = file.d.order{row,2};
        is_one_back = file.d.order{row,5};
        
        file_image = file.d.order{row,4};
        if isnan(file_image)
            is_healthy = nan;
        else
            ind = find(file_image=='.',1,'last') - 1;
            num = str2num(file_image(ind));
            if num <= 4
                is_healthy = false;
            else
                is_healthy = true;
            end
        end
        
        switch cond.names{p}
            case 'NULL'
                if strcmp(cond_file,cond_search)
                    is_cond = true;
                end
            case {'Body' 'Face' 'Hand' 'Scrambled'}
                if strcmp(cond_file,cond_search) %& ~is_one_back
                    is_cond = true;
                end
            case 'Error'
                %do nothing
            otherwise
                cond.names{p}
                error('Unknown condition.')
        end
        
        if is_cond
            events(end+1,:) = [vstart vend];
        end
    end
    
    %combine events
    for e = size(events,1):-1:2
        if events(e,1) == (events(e-1,2)+1)
            events(e-1,2) = events(e,2);
            events(e,:) = [];
        end
    end
    
    if strcmp(cond_search,'Error')
        num_vol = sum(cell2mat(file.d.order(2:end,3)));
        fprintf(fid,'1\n');
        fprintf(fid,'1 %d\n',num_vol);
    else
        fprintf(fid,'%d\n',size(events,1));
        for i = 1:size(events,1)
            fprintf(fid,'%d %d\n', events(i,1), events(i,2));
        end
    end
    
    fprintf(fid,'Color:  %d %d %d\n',cond.colours(p,:));
    fprintf(fid,'\n');
end

%% Close
fclose(fid);
