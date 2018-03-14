function ExportTrackStats(Cells,Dims,Name)

%%
[P,F,~] = fileparts(Name);
P2 = fullfile(P,'Xls');
if ~exist(P2,'dir')
    mkdir(P2)
end
XlsName = fullfile(P2,[F,'.txt']);

%% Put Segs Together
AllSegs = vertcat(Cells{:});
AllTracks = [AllSegs.Tid];

Tracks = unique(AllTracks);
counts = hist(AllTracks,Tracks);
Tracks = Tracks(counts>20);

%%

Mat = cell(length(Cells)+4,4*max(length(Tracks),1));

Mat(2,1:4:end) = {'Velocity(pixels/frame)'};
Mat(2,2:4:end) = {'Tortuosity(pixels/pixels)'};
Mat(2,3:4:end) = {'Mean Area(pixels.^2)'};
Mat(2,4:4:end) = {'Mean Covarience'};

Mat(4,1:4:end) = {'x(Pixel Position)'};
Mat(4,2:4:end) = {'y(Pixel Position)'};
Mat(4,3:4:end) = {'Area(pixels.^2)'};
Mat(4,4:4:end) = {'Covariance'};

% imd = CONSTANTS.imageData;
% ResolutionXYZ = imd.PixelPhysicalSize;
% ResolutionTime = mean(diff(imd.TimeStampDelta)) * 60 * 60;

for i = 1:length(Tracks)
    Mat(1,i*4 - 3) = num2cell(Tracks(i));
    
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
    MeanVoc = mean(sqrt(DeltaPos(:,1).^2 + DeltaPos(:,2).^2));
    
    %Convert velocity to physical space and real time
    % MeanVoc = MeanVoc* ResolutionXYZ(1) / ResolutionTime;
    
    TotalDisp = sum(sqrt(DeltaPos(:,1).^2 + DeltaPos(:,2).^2));
    LengthTraveled = norm(HullPos(1,:) - HullPos(end,:));
    Tort =  TotalDisp./LengthTraveled;
    
    %% Write to Cell Mat
    
    Mat(3,(4*i-3)) = num2cell(MeanVoc);
    Mat(3,(4*i-2)) = num2cell(Tort);
    Mat(3,(4*i-1)) = num2cell(MeanSize);
    Mat(3,(4*i)) = num2cell(mean(HullCov));
    
    Mat(Times+4,(4*i-3):(4*i-2)) = num2cell(HullPos(:,[1,2]));
    Mat(Times+4,(4*i-1)) = num2cell(Areas);
    Mat(Times+4,(4*i)) = num2cell(HullCov);
    
end
T = cell2table(Mat)
writetable(T,XlsName)
%disp(Mat)
%xlswrite(XlsName,Mat)
end