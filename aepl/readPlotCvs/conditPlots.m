GROUP_BY = {'PI', 'IKK', 'Tram', 'Bardox', 'BYL', 'DMSO'};

clear temp
temp = struct();
for gb = GROUP_BY(1:end)
    %disp(gb)
    temp.(gb{1}) = {};
    conditions = {condits(:).name};
    for condit = conditions
        %disp(condit)
        if ~isempty(strfind(condit{1},gb{1}))
            %disp(gb{1})
            %disp(condit{1})
            %disp(" ")
            temp.(gb{1})(size(temp.(gb{1}),2)+1) = condit;
        end
    end
end

% for f = fieldnames(temp)
%     disp(f)
% end
fdns = fieldnames(temp);
clear temp2
temp2 = struct()
for fn = 1:size(fdns,1)-1
    f = fdns(fn);
    disp(f)
    grou = [];
    for c = temp.(f{1})
        parts = strsplit(c{1},' ');
        grou = [grou;str2num(parts{end}),c];
        
        %disp(parts(end))
    end
    grou = cell2table(grou);
    grou = sortrows(grou);
    %temp2.(f) = grou
    %disp(grou)
    
    for conditList = grou(:,2)
        figure
        %disp(condit)
        plotCount = size(conditList,1);
        colCount = floor(sqrt(plotCount));
        rowCount = colCount;
        n = plotCount - colCount*rowCount;
        if n > 0 
            colCount = colCount + ceil(n/rowCount);
        end
%         plotNum = 1;
%         laeout = [rowCount colCount];
        
        for i = 1:plotCount
            
            
            [cond,wells] = condit2wells(conditList{i,1},condits);
%             for well = wells
            frames = size(wells(1).cells(1).xcoords*2,1);
            t_int = (1/6):(1/6):(frames/6);
            subplot(rowCount,colCount,i)
            title(conditList{i,1})
            mat = [];
            col = 1;
            for w = 1:size(wells,2)
                try
                    for c = 1:size(wells(w).cells,2)
                        mat(1:frames-1,col) = wells(w).cells(c).distance(2:end);
                        col = col + 1;
 condits(cond).wells(w).cells(c).coords = horzcat(wells(w).cells(c).xcoords, wells(w).cells(c).ycoords);

                    end
                catch e
                    %fprintf(1,"condition: " + conditList + ", well:" + wells(w).name)
                    fprintf(1,"condit:"+conditList{i,1}+"\n");
                    fprintf(2,"exception: " + getReport(e)+"\n")
                    continue
                end
                
            end
            
            
        
                    
            datMin = nanmin(mat,[],2);
            dat25 = prctile(mat,25,2);
            datMean = nanmean(mat,2);
            datMedian =  nanmedian(mat,2);
            dat75 = prctile(mat,75,2);
            datMax = nanmax(mat,[],2);
%             mea = nanmean(mat,2);
%             mea = permute(mea,[2 1]);
%             med = nanmedian(mat,2);
%             med = permute(med, [2 1]);

            t_int_temp = permute(t_int(1:size(datMin,1)),[2 1]);
            %scatter(t_int_temp,mea,'filled');
            %scatter(t_int_temp,med,'filled');
            
            hold on
            scatter(t_int_temp,datMin,'+')
            scatter(t_int_temp,dat25,'.')
            scatter(t_int_temp,datMean,'*')
            scatter(t_int_temp,datMedian,'x')            
            scatter(t_int_temp,dat75,'.')
            scatter(t_int_temp,datMax,'+')
            ylim([0,150])
            legend('min','second quart.','mean','median','third quart','max')
        end
    end
            
    
    
        
        
      
end
f = fdns(size(fdns,1));
    


    grou = temp.(f{1})
%
%temp2.(f) = grou
%disp(grou)

    figure
%disp(condit)
plotCount = 11;
colCount = floor(sqrt(plotCount));
rowCount = colCount;
n = plotCount - colCount*rowCount;
if n > 0 
    colCount = colCount + ceil(n/rowCount);
end
%         plotNum = 1;
%         laeout = [rowCount colCount];



[cond,wells] = condit2wells(grou,condits);
%             for well = wells
frames = size(wells(1).cells(1).xcoords*2,1);
t_int = (1/6):(1/6):(frames/6);
%subplot(rowCount,colCount,1)
title(grou)
mat = [];
col = 1;
for w = 1:size(wells,2)
    try
        for c = 1:size(wells(w).cells,2)
            mat(1:frames-1,col) = wells(w).cells(c).distance(2:end);
            col = col + 1;
        end
    catch e
        %fprintf(1,"condition: " + conditList + ", well:" + wells(w).name)
        fprintf(1,"condit:"+grou);
        fprintf(2,"exception: " + getReport(e)+"\n")
        continue
    end
end


hold on
mea = nanmean(mat,2);
mea = permute(mea,[2 1]);
med = nanmedian(mat,2);
med = permute(med, [2 1]);
t_int_temp = t_int(1:size(mea,2));
scatter(t_int_temp,mea,'filled');
scatter(t_int_temp,med,'filled');
ylim([0,40])
legend('mean','median')

function [c,wells] = condit2wells(name,condits) 
    %for condit = condits
    for c = 1:size(condits,2)
        condit = condits(c);
        if strcmp(condit.name,name) 
            wells = condit.wells;
            break
        end
    end
end
    

%fir




%disp(temp)