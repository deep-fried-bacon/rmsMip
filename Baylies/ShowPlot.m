function ShowPlot(Cells,Dims,Name)

%size(Cells)
%size(Cells(2))
tIntervals = zeros(size(Cells,2),1);
for i = 1:size(tIntervals)
    tIntervals(i) = i * (1.0/6.0);
end
% 

%%
% [P,F,~] = fileparts(Name);
% P2 = fullfile(P,'Xls');
% if ~exist(P2,'dir')
%     mkdir(P2)
% end
% XlsName = fullfile(P2,[F,'.csv']);

%% Put Segs Together
AllSegs = vertcat(Cells{:});
AllTracks = [AllSegs.Tid];

Tracks = unique(AllTracks);
counts = hist(AllTracks,Tracks);
Tracks = Tracks(counts>20);

%%
colCount = 5;

Mat = cell(length(Cells)+colCount,colCount*max(length(Tracks),1));


% imd = CONSTANTS.imageData;
% ResolutionXYZ = imd.PixelPhysicalSize;
% ResolutionTime = mean(diff(imd.TimeStampDelta)) * 60 * 60;
%hold on
hold off
%ylim([0 20])
plotCount = 1
fs = []
close all
for i = 1:length(Tracks)
    try
        
        Mat(1,(i-1)*colCount+1) = num2cell(Tracks(i));

        Tid = Tracks(i);

        cells = [AllSegs([AllSegs.Tid] == Tid)];

        %% Collect Size Stats
        Areas = [cells.Area]; %* ResolutionXYZ(1)*ResolutionXYZ(2);

        MeanSize = mean(Areas);

        %% Get Covariance
        HullsCR = {cells.PixelList};
        Hullscov = cellfun(@cov, HullsCR,'UniformOutput', false);
        HullCov = cellfun(@(x) min(x(1,1),x(2,2)) / max(x(1,1),x(2,2)),Hullscov)';

        %% Collect Movement Stats
        HullPos = vertcat(cells.Centroid);
        Times = [cells.time];
        [Times, I] = sort(Times);
        HullPos = HullPos(I,:);

        DeltaPos = [0,0; diff(HullPos,1,1)];
        Veloc = sqrt(DeltaPos(:,1).^2+DeltaPos(:,2).^2);
        MeanVoc = mean(Veloc);
        
        subplot(2,3,plotCount)
        tempIntervals = tIntervals(1:size(Veloc,1));
        scatter (tempIntervals, Veloc, 'filled')
        title(Tracks(i))
        ylim([0,50])
        if plotCount == 6 
            plotCount = 1;
            fs = [fs,figure];
            
        else
            plotCount = plotCount + 1;
        end

%         %Convert velocity to physical space and real time
%         % MeanVoc = MeanVoc* ResolutionXYZ(1) / ResolutionTime;
% 
%         TotalDisp = sum(sqrt(DeltaPos(:,1).^2 + DeltaPos(:,2).^2));
%         LengthTraveled = norm(HullPos(1,:) - HullPos(end,:));
%         Tort =  TotalDisp./LengthTraveled;
% 
%         %% Write to Cell Mat
% 
% 
    catch e
        
        % added because sometimes index exceeds matrix dimensions error
        % don't know what's causing it
        % it appears that for the same well it happens sometimes but not
        % always with what seems to be the same conditions
        disp("cell " + i + ", track " + Tracks(i))
        disp("exception: " + e.identifier)
        disp("except.message: " + e.message)
        continue

    end     

end
% T = cell2table(Mat);
% writetable(T,XlsName,'WriteVariableNames',0);
%disp(Mat)
%xlswrite(XlsName,Mat)
end