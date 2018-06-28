GROUP_BY = {'PI', 'IKK', 'Tram', 'Bardox', 'BYL', 'DMSO'};

clear temp
temp = struct();
for gb = GROUP_BY(1:end)
    temp.(gb{1}) = {};
    conditions = {condits(:).name};
    for condit = conditions
        if ~isempty(strfind(condit{1},gb{1}))
           
            temp.(gb{1})(size(temp.(gb{1}),2)+1) = condit;
        end
    end
end


fdns = fieldnames(temp);
clear temp2
temp2 = struct();
%for fn = 1:size(fdns,1)-1
if 0 %for fn = 1
    f = fdns(fn);
    disp(f)
    grou = [];
    for c = temp.(f{1})
        parts = strsplit(c{1},' ');
        grou = [grou;str2num(parts{end}),c];
        
    end
    grou = cell2table(grou);
    grou = sortrows(grou);
    for conditList = grou(:,2)
          laeout = [3,4,100];
        
%         colCount = floor(sqrt(plotCount));
%         rowCount = colCount;
%         n = plotCount - colCount*rowCount;
%         if n > 0 
%             colCount = colCount + ceil(n/rowCount);
%         end
%         plotNum = 1;
%         laeout = [rowCount colCount];

        %for i = 1:2
        for i = 1:size(conditList,1)
            if laeout(3) > laeout(1)*laeout(2) 
                figure
                laeout(3) = 1;
            end
            plottyPlot(conditList{i,1},laeout,condits)
        laeout(3) = laeout(3)+1;
        end
    end
end
f = fdns(size(fdns,1));
    


grou = temp.(f{1});

figure
laeout = [1 1 1];

disp(grou)
plottyPlot(grou,laeout,condits)

function [c,wells] = condit2wells(name,condits) 
    for c = 1:size(condits,2)
        condit = condits(c);
        if strcmp(condit.name,name) 
            wells = condit.wells;
            break
        end
    end
end

function plottyPlot(conditName,laeout,condits)



    [cond,wells] = condit2wells(conditName,condits);
    frames = size(wells(1).cells(1).xcoords*2,1);
    t_int = (1/6):(1/6):(frames/6);
    subplot(laeout(1),laeout(2),laeout(3))
    title(conditName)
    
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
            fprintf(1,"condit:"+condits(cond).name+"\n");
            fprintf(2,"exception: " + getReport(e)+"\n")
            continue
        end
    end
 
    scatNotHist = 1;
    %addpath('/iosr')
        t_int_temp = permute(t_int(1:size(mat,1)),[2 1]);

    boop = iosr.statistics.qqPlot(mat);
    iosr.figures.multiwaveplot(mat);
    boop = iosr.statistics.functionalBoxPlot(mat);
    boop = iosr.statistics.functionalSpreadPlot(mat);

    %if scatNotHist
    if 0
        hold on
        t_int_temp = permute(t_int(1:size(mat,1)),[2 1]);
        mat(mat>50)=nan;
        %mat2 = prctile(mat,[0:25:100],2);
        mat2 = prctile(mat,50,2);
        rs = 0;
        r = .05;
        if rs+r*20 > 1
            rs = 0;
            r = .05;
        end

        gs = .5;
        g = .02;
        if gs+g*20 > 1
            gs = 0;
            g = .05
        end

        bs = 0;
        b = .001;
        if bs+b*20 > 0
            bs = 0;
            b =.05;
        end



        %colors = permute([rs:r:rs+r*20;gs:g:gs+g*20;bs:b:bs+b*20;],[2 1]);
        colors = buildcmap([0:10]);
        for k = 1:size(mat2,2)
            if k == 3
                s = scatter(t_int_temp,mat2(:,k),30,colors(k*2+1,:),'filled');
            else
                s = scatter(t_int_temp,mat2(:,k),10,colors(k*2+1,:),'filled');
            end
            %colors(k,:))
            ylim([0 20])
        end

            %p = prctile(mat(:),95);
            %mat(mat>=50)=nan;
%             datMin = nanmin(mat,[],2);
%             dat25 = prctile(mat,25,2);
%             datMean = nanmean(mat,2);
%             datMedian =  nanmedian(mat,2);
%             dat75 = prctile(mat,75,2);
%             datMax = nanmax(mat,[],2);
%             cmap = buildcmap([1:size(datMin,1)]);
% %             mea = nanmean(mat,2);
% %             mea = permute(mea,[2 1]);
% %             med = nanmedian(mat,2);
% %             med = permute(med, [2 1]);
% 
%             scatter(t_int_temp,datMin,200,'.');
%             scatter(t_int_temp,dat25,300,'.');
%             scatter(t_int_temp,datMean,500,'.');
%             scatter(t_int_temp,datMedian,400,'.') ;
%             scatter(t_int_temp,dat75,300,'.');
%             scatter(t_int_temp,prctile(mat,80,2),'.')
%             scatter(t_int_temp,prctile(mat,85,2),'.')
%             scatter(t_int_temp,prctile(mat,90,2),'.')
%             scatter(t_int_temp,prctile(mat,95,2),'.')
%             scatter(t_int_temp,datMax,200,'.'); 

            
            %s.Parent.Color = [0 0 0];
            %ylim([0,datMax])
            
            
            
            
            %l = legend('min','second quart.','mean','median','third quart','80','85','90','95','max');
            %l.Location = 'northeastoutside';
        hold off
    elseif 0

        maxx = nanmax(mat(:));
%             maxx = max(maxx);
%             xlim([0,maxx])
        %title(
        %legend(['max: ',num2str(maxx)])
        %xlim([0,maxx])
        %boop = prctile(mat,99);
        tempMat = mat(:);
        %p = prctile(tempMat,98);
        %title('1')
        %count = size(mat(mat>=p));
        mat(mat >= 50) = nan;
        histogram(mat)
        title(conditName)


       % mat(mat

           %for
            
            %prcs = nan(20,1);
            %for j = 1:5:100
                %prcs = prctile(mat,25,2)
%             subplot(laeout(1),laeout(2),laeout(3)+2)
%             histogram(mat)
%             maxx = nanmax(mat(:));
%             legend(['max: ',num2str(maxx)]);
%             text(0,0,['removed: ', num2str(count)])
%             xlim([0,maxx])
            %legend(['<98percentile=',num2str(p)])
             %tempMat = prctile(mat,[1:5:100],1);
             
%              plot(mat(:,1));
%              ylim([0 500])    

    end
        %rawText = [Min
        %sprintf =(
        
    
end
    
