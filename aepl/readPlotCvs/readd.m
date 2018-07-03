function condits = readd(path)


COL_COUNT = 5;

COL_LAYOUT.xcoords = 1;
COL_LAYOUT.ycoords = 2;
COL_LAYOUT.area = 3;
COL_LAYOUT.covarience = 4;
COL_LAYOUT.distance = 5;
COLS = (fieldnames(COL_LAYOUT));

PLATE_MAP_SUF = '_plate-map.csv';

GROUP_BY = {'PI-103', 'IKK', 'Tram', 'Bardox', 'BYL', 'DMSO'};


%f18_03_18 = '/Users/baylieslab/Documents/Amelia/rmsMim/18-03-18/';
%f18_06_20 = '/Volumes/baylieslab/Current Lab Members/Whitney/Rhabdomyosarcoma plate movies/18-06-20/';
%f16_06_23 = '/Volumes/baylieslab/Current Lab Members/Whitney/Rhabdomyosarcoma plate movies/16-06-23 (1st plate)/16-06-23/';


exper = struct();
exper.folder = path;
%exper = Exper(path);


[~,exper.name] = fileparts(exper.folder(1:end-1));
exper.plateMapFile = strcat(exper.folder,exper.name,PLATE_MAP_SUF);

[exper.conditions,exper.conditDict] = MakeConditDict(exper.plateMapFile);
%exper.xlsFolder = fullfile(exper.folder, 'Xls')

%tic
dlist2 = dir(fullfile(exper.folder,'Xls','*.csv'));
clear condits
condits(size(exper.conditions,2)) = struct();
for c = 1:size(exper.conditions,2)
    condits(c).name = exper.conditions{c};  
    disp(condits(c).name)
    disp(exper.conditDict(exper.conditions{c}))
    

    conditWells = exper.conditDict(exper.conditions{c});
    condits(c).wells(size(conditWells)) = struct();
    %for 
    for w = 1:size(conditWells,2)%w = conditWells
        %tic
        
    %for i = 1:size(dlist2)
        %exper
        %well = struct();
        %clear well
        condits(c).wells(w).name = conditWells(w);
        %disp(condits(c).wells(w).name)
        condits(c).wells(w).path = strcat(exper.folder,'Xls/', exper.name,'_',condits(c).wells(w).name{1}, '.csv');
        %condits(c).wells(w).path = condits(c).wells(w).path{1};
        if exist(condits(c).wells(w).path, 'file')
            %condits(c).wells(w).path = fullfile(dlist2(i).folder,dlist2(i).name);
            %condits(c).wells(w).name = split(dlist2(i).name,'.');
            %condits(c).wells(w).name = split(condits(c).wells(w).name{1},'_');
            %condits(c).wells(w).name = condits(c).wells(w).name{end};
            %Name = fullfile(dlist2(i).folder,dlist2(i).name);
            condits(c).wells(w).raw = readtable(condits(c).wells(w).path);
            condits(c).wells(w).cellCount = width(condits(c).wells(w).raw)/COL_COUNT;

            condits(c).wells(w).raw = condits(c).wells(w).raw.Variables;

            %xCoords = M.Var1(5:end);
            %yCoords = M.Var2(5:end);

            %condits(c).wells(w).cellCount = width(condits(c).wells(w).raw)/COL_COUNT;
            condits(c).wells(w).cells(condits(c).wells(w).cellCount) = struct();
            %clas
            %j = 0;
            %while j <= width(condits(c).wells(w).raw) :
            for j = 1:condits(c).wells(w).cellCount
                startCol = (j-1)*5;
                %
                condits(c).wells(w).cells(j).id = condits(c).wells(w).raw{1,startCol+1};
                %for k = 1:COL_COUNT 
                for k = 1:COL_COUNT
                    condits(c).wells(w).cells(j).(COLS{k}) = str2double(condits(c).wells(w).raw(5:end,startCol+COL_LAYOUT.(COLS{k})));
                    if isnan(condits(c).wells(w).cells(j).(COLS{k})(end))
                        condits(c).wells(w).cells(j).(COLS{k})(end) = [];
                    end
                end
                %condits(c).wells(w).cells(j).id 

                %condits(c).wells(w).cs(j) = struct()
                %condits(c).wells(w).cs(j).id = condits(c).wells(w).raw{1,startCol}

            end
        else 
            disp(strcat('missing ', condits(c).wells(w).name))
        end
        
        %condit(c).wells(l) = well;
        %toc
    end
    

    
    %temp = str2double(xCoords);
   
    
   
end


%toc

end