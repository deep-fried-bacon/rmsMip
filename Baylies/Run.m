%% Add BioFormats 
addpath('../Utilities/src/MATLAB')
%folder = '/Users/baylieslab/Documents/Amelia/some czi/'
folder = '/Volumes/baylieslab/Current Lab Members/Whitney/Rhabdomyosarcoma plate movies/17-06-28 final pi3k inhibitors/'
% folder = pwd();
%folder = uigetdir();
%disp(class(folder))
dlist = dir(fullfile(folder,'*.czi'));
%disp(dlist(1));
for i = 1:size(dlist)
    
%% Get Images
%Name = fullfile(folder,dlist(i).name);
Name = fullfile(folder,dlist(i).name);
try

    [im,imd] =  MicroscopeData.Original.ReadData(folder,dlist(i).name);

    [cells] = segIms(im);

    [cells2,Edges] = getTracks(cells,size(im));

    %DrawTracks(squeeze(im),cells2,Name)

    ExportTrackStats(cells2,size(im),Name)
catch
    continue
end

end 
