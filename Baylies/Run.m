%% Add BioFormats 
tic
addpath('../Utilities/src/MATLAB')
%folder = '/Volumes/baylieslab/Current Lab Members/Whitney/Rhabdomyosarcoma plate movies/17-06-28 final pi3k inhibitors/'
folder = '/Users/baylieslab/Documents/Amelia/rmsMim/18-03-18';
folder2 = '/Users/baylieslab/Documents/Amelia/rmsMim/16-06-23_plate-1_partial';
%folder = pwd();
%folder = uigetdir();

dlist = dir(fullfile(folder,'*.czi'));
fs = [];
f1 = '/Users/baylieslab/Documents/Amelia/rmsMim/18-03-18/18-03-18_plate-map.csv';

[conditions,conditDict] = MakeConditDict(f1);


prefix = '/Users/baylieslab/Documents/Amelia/rmsMim/18-03-18/18-03-18_';
pref2 = '18-03-18_';
suffix = '.czi';

exper = struct();
exper.frameCount = 0;

for condition = conditions([9,14])
    %conditVelocs = cell
    disp(condition{1})
    
    wells = conditDict(condition{1});
    conditVeloc = cell(size(wells,2));
    for w = wells 
        well = struct();
        well.condition = condition{1};
        well.name = w{1};
        well.path = strcat(prefix,well.name,suffix);
        well.filename = strcat(pref2,well.name,suffix);
        if exist(well.path, 'file')
            
            %disp(well.filename)
            disp(well.name)
        

            %try
            temp = figure('Name',well.condition);
            fs = [fs,temp];
            
            %% Get Images
            [well.im,well.imd] =  MicroscopeData.Original.ReadData(folder,well.filename);
            
            well.imdim = size(well.im);
            if exper.frameCount == 0 
                exper.frameCount = well.imdim(5);
            end

            [well.cells] = segIms(well.im);

            
            [well.cells2,well.edges] = getTracks(well.cells,well.imdim);


            %DrawTracks(squeeze(well.im),well.cells2,well.filename);

            %ExportTrackStats(cells2,size(im),wellF)
            
            well.allSegs = vertcat(well.cells2{:});
            well.allTracks = [well.allSegs.Tid];
            well.tracks = unique(well.allTracks);
            well.cellCount = size(well.tracks,2);
            disp("well.cellCount = " + well.cellCount)
            well.velocs = cell(exper.frameCount,size(well.tracks,2));
            
            ShowPlot(well.cells2,well.name,well.condition,fs)

    %         catch e
    %             disp("i = " + i + ", well " + wellN(end-6:end-4))
    %             disp("exception: " + e.identifier)
    %             disp("except.message: " + e.message)
    %             continue
    % 
    %         end

        end
    %break
    end

toc
end 

% dlist2 = dir(fullfile(folder,'Xls','*.txt'));
% 
% 
% 
% for i = 1:size(dlist2)
%     Name = fullfile(dlist2(i).folder,dlist2(i).name);
%     M = readtable(Name);
%     
%     xCoords = M.Mat1(5:end);
%     yCoords = M.Mat2(5:end);
%     
%     temp = str2double(xCoords);
%    
%     
%    
% end


