%% Add BioFormats 
addpath('../Utilities/src/MATLAB')
%folder = '/Volumes/baylieslab/Current Lab Members/Whitney/Rhabdomyosarcoma plate movies/17-06-28 final pi3k inhibitors/'
folder = '/Users/baylieslab/Documents/Amelia/rms/rmsMim/18-03-18_Subset';
folder2 = '/Users/baylieslab/Documents/Amelia/rms/rmsMim/16-06-23_plate-1_partial';
%folder = pwd();
%folder = uigetdir();

dlist = dir(fullfile(folder,'*.czi'));
fs = [];
f1 = '/Users/baylieslab/Documents/Amelia/rms/rmsMip/rmsMatip/misc/2018-03-18_plateMap.csv';

[conditions,conditDict] = MakeConditDict(f1);

prefix = '/Users/baylieslab/Documents/Amelia/rms/rmsMim/18-03-18_Subset/18-03-18_';
pref2 = '18-03-18_';
suffix = '.czi';

for condition = conditions(9)
    %conditVelocs = cell
    disp(condition{1})
    
    wells = conditDict(condition{1});
    conditVeloc = cell(3);
    for well = wells 
        wellF = strcat(prefix,well{1},suffix);
        wellN = strcat(pref2,well{1},suffix);
        if exist(wellF, 'file')
            disp(wellN)
        
        

            %try
            temp = figure('Name',condition{1});
            fs = [fs,temp];
            
            %% Get Images
            [im,imd] =  MicroscopeData.Original.ReadData(folder,wellN);
            
            

            [cells] = segIms(im);

            
            [cells2,Edges] = getTracks(cells,size(im));


            %DrawTracks(squeeze(im),cells2,wellF);

            %ExportTrackStats(cells2,size(im),wellF)
            
            AllSegs = vertcat(cells2{:});
            AllTracks = [AllSegs.Tid];
            Tracks = unique(AllTracks);
            cellCount = size(Tracks,2)
            wellVeloc = cell(size(im,5),size(Tracks,2));
            
            ShowPlot(cells2,size(im),condition,well{1},fs)

    %         catch e
    %             disp("i = " + i + ", well " + wellN(end-6:end-4))
    %             disp("exception: " + e.identifier)
    %             disp("except.message: " + e.message)
    %             continue
    % 
    %         end

        end
    end


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


