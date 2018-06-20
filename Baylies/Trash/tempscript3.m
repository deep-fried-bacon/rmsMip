% im1 = rand(50,40,3);
% im2 = rand(50,50,3);
% imwrite(im1,'myMultipageFile.tif')
% imwrite(im2,'myMultipageFile.tif','WriteMode','append')
% 
tempdata = load('kjhkj.mat');
size(tempdata);


count = 0;
count2 = 0;
a = tempdata.tempData(:,:,1);
b = tempdata.tempData(:,:,2);
c = tempdata.tempData(:,:,3);
for i = a
    %disp(i)
    if i == 240
        count = count + 1;
    else
        count2 = count2 + 1;
    end
end
count
count2

count = 0;
count2 = 0;
for i = b
    if i == 240
        count = count + 1;
    else
        count2 = count2 + 1;
    end
end
count
count2

count = 0;
count2=0;
for i = c
    if i == 240
        count = count + 1;
    else
        count2 = count2 + 1;
    end
end
count
count2



