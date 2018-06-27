%% Add BioFormats 
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

exper = struct()
exper.frameCount = 0;
i=1
for condition = conditions(9)
    disp(i)
    i +=1
    %conditVelocs = cell
    disp(condition{1})
    
    wells = conditDict(condition{1});
    disp(wells)
end