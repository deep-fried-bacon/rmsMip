
function DrawTracks(im,Segs,Name)


close all, 
figure, 

cmap = colormap('jet');
cmap = cmap(randperm(size(cmap,1)),:);

saveframe  = 1;
AllSegs = vertcat(Segs{:});

AllTracks = [AllSegs.Tid];
Tracks = unique(AllTracks);
% counts = hist(AllTracks,Tracks);

Fr = cell(1,size(im,3));

for i = 1:size(im,3)
    
    Tsegs = AllSegs([AllSegs.time]==i);
    % put break on next line to step through outlined cells
    TTracks = [Tsegs.Tid];
    
    imagesc(im(:,:,i))
    colormap gray
    Axis = gca;
    Axis.Position = [0 ,0, 1, 1];
    axis equal
    axis off
    hold on
    for ii = 1:length(TTracks)
        
        pts = vertcat(Tsegs(ii).Bound);
        cid = mod(TTracks(ii),64)+1;
        plot(pts(:,2),pts(:,1),'-','Color',cmap(cid,:))
        cent = Tsegs(ii).Centroid;
        text(cent(1),cent(2),num2str(Tsegs(ii).Tid),'Color',cmap(cid,:),'FontSize',10)
        
    end
    hold off
    drawnow
    
    
    if saveframe
        Fr{i} = getframe(gca);
    end
end

%MakeMovie(Fr,Name)


[P,F,~] = fileparts(Name);


% P2 = fullfile(P,'Tiffs');
% if ~exist(P2,'dir')
%     mkdir(P2)
% end 
% VidName = fullfile(P2,[F,'.tiff']);
VidName = strcat('/Users/baylieslab/Documents/Amelia/rmsMim/18-03-18/',F,".tif");

disp(VidName)

%Fr2 = uint8(size(Fr));
tempData = Fr{1}.cdata;
imwrite(tempData,VidName)
for i = 2:size(Fr)
    tempData = Fr{i}.cdata;
    imwrite(tempData,VidName,'WriteMode','append')
end


end
