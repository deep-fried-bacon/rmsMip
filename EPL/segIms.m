%%
% 
%   for x = 1:10
%       disp(x)
%   end
% 
function [cells] = segIms(im)

cells = cell(1,size(im,5));
UID = 1;
for t = 1:size(im,5)

[imBW,~] = SegTexture_MSKCC(im(:,:,1,1,t));

imBW = SplitLargeAreas(imBW);

[B] = bwboundaries(imBW,'noholes');

 CC = regionprops(imBW,'centroid','area','PixelList');
    for ii = 1:length(CC)
        CC(ii).id = UID;
        CC(ii).Tid = UID;
        CC(ii).time = t;
        CC(ii).Bound = B{ii};
        UID = UID +1;
    end

cells{t} = CC;
end 
end 



%% 
function imBWout = SplitLargeAreas(imBW)

imBWout = imBW;

tooLarge = bwareaopen(imBW, 6000);
imBWout(tooLarge) = false;

L = SeparateObjects(tooLarge,3500);

imBWout(L>0) = true;
end

function L2 = SeparateObjects(imBW,MeanArea)


L = bwlabel(imBW);
L2 = zeros(size(L));
if nnz(imBW)==0
    return 
end 
CellFeats = regionprops(imBW,'Area','PixelList','PixelIdxList');
LMat = false(size(imBW,1),size(imBW,2),size(imBW,3),3*length(CellFeats));
Lmax = 1;
for i = 1:max(L(:))
    k =  round((CellFeats(i).Area/MeanArea));
    if k < 2
        L2(CellFeats(i).PixelIdxList)=Lmax ;
        LMat(:,:,:,Lmax) = L2==Lmax;
        Lmax = Lmax + 1;
    else
        T = kmeans(CellFeats(i).PixelList,k);
        for j = 1:max(T(:))
            L2(CellFeats(i).PixelIdxList(T==j))=Lmax ;
            LMat(:,:,:,Lmax) = L2==Lmax;
            Lmax = Lmax + 1;
        end
    end
end

%% Seperate Touching Objects
LMat = imdilate(LMat,ones([3,3,1,1]));

Boundry = sum(LMat,4)>1;
L2(Boundry) = false;
end 