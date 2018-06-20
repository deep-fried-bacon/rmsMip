COL_COUNT = 5;

COL_LAYOUT.xcoords = 1;
COL_LAYOUT.ycoords = 2;
COL_LAYOUT.area = 3;
COL_LAYOUT.covarience = 4;
COL_LAYOUT.distance = 5;
COLS = (fieldnames(COL_LAYOUT));

PLATE_MAP_SUF = '_plate-map.csv';


f18_03_18 = '/Users/baylieslab/Documents/Amelia/rmsMim/18-03-18/';

%exper = struct();
exper.folder = f18_03_18;


[~,exper.name] = fileparts(exper.folder(1:end-1));
exper.plateMapFile = strcat(exper.folder,exper.name,PLATE_MAP_SUF);

[exper.conditions,exper.conditDict] = MakeConditDict(exper.plateMapFile);
%exper.xlsFolder = fullfile(exper.folder, 'Xls')


dlist2 = dir(fullfile(exper.folder,'Xls','*.csv'));

for condition = exper.conditions
    conditWells = exper.conditDict(condition{1});
    %for 
    
%for i = 1:size(dlist2)
    %exper
    %well = struct();
    clear well
    well.path = fullfile(dlist2(i).folder,dlist2(i).name);
    well.name = split(dlist2(i).name,'.');
    well.name = split(well.name{1},'_');
    well.name = well.name{end};
    %Name = fullfile(dlist2(i).folder,dlist2(i).name);
    well.raw = readtable(well.path);
    well.cellCount = width(well.raw)/COL_COUNT;

    well.raw = well.raw.Variables;
    
    %xCoords = M.Var1(5:end);
    %yCoords = M.Var2(5:end);
    
    %well.cellCount = width(well.raw)/COL_COUNT;
    well.cells(well.cellCount) = struct();
    %clas
    %j = 0;
    %while j <= width(well.raw) :
    for j = 1:well.cellCount
        startCol = (j-1)*5 + 1;
        %
        well.cells(j).id = well.raw{1,startCol};
        %for k = 1:COL_COUNT 
        for k = 1:COL_COUNT
            well.cells(j).(COLS{k}) = str2double(well.raw(5:end,COL_LAYOUT.(COLS{1})));
            if isnan(well.cells(j).(COLS{k})(end))
                well.cells(j).(COLS{k})(end) = [];
            end
        end
        %well.cells(j).id 
        
        %well.cs(j) = struct()
        %well.cs(j).id = well.raw{1,startCol}
    end

    
    
    %temp = str2double(xCoords);
   
    
   
end