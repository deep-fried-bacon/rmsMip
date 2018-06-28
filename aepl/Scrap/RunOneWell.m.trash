
%% well = struct with fields
%   condition
%   filename

function RunOneWell(well)
    
[well.im,well.imd] =  MicroscopeData.Original.ReadData(folder,well.filename);
            
            well.imdim = size(well.im);
            if exper.frameCount == 0 
                exper.frameCount = well.imdim(5);
            end

            [well.cells] = segIms(well.im);

            
            [well.cells2,well.edges] = getTracks(well.cells,well.imdim);


            DrawTracks(squeeze(well.im),well.cells2,well.filename);

