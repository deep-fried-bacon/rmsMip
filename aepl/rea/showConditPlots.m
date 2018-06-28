function showConditPlots(condits,ind)
    

    plotCount = 1;
    %laeout = [2,2];
    laeout = [3,4];
    %f = [figure('pos',[0,0,900,300])];
       f = [figure];

    %clear figure
    %figure
    clf
    if ind == -1
        ind = 1:size(condits,2);
    end
    frames = size(condits(1).wells(1).cells(1).xcoords*2,1);
    t_int = (1/6):(1/6):(frames/6);
    %disp(condits(1))
    hold on
    for condit = ind
        %subplot('Name',condits(condit).name)
        %figure
        %disp(c)
        %if plotCount > laeout(1)*laeout(2)
        %if plotCount > laeout(1)*laeout(2)
        if plotCount > 11
            %f = [f,figure('pos',[0,0,900,300])];
            f = [f,figure];

            plotCount = 1;
        %else
            %plotCount = plotCount + 1;
                    
        end
        disp(strcat(num2str(condit),". ",condits(condit).name))
        subplot(laeout(1),laeout(2),plotCount)
        title(condits(condit).name)
        

        mat = []; %nan(frames,10);
        col = 1;
        for w = 1:size(condits(condit).wells,2)
            try
                %disp(w)
                %disp(condits(condit).wells(w).name)
                for c = 1:size(condits(condit).wells(w).cells,2) 
                    %disp(c)

                    %hold on
                    %d = condits(condit).wells(w).cells(c).distance;
                    %x = condits(condit).wells(w).cells(c).xcoords;

                    %size(condits(condit).wells(w).cells(c).distance(2:end));
                    mat(1:frames-1,col) = condits(condit).wells(w).cells(c).distance(2:end);


                    col = col + 1;
    %                 hold on
    %                 
    %                 scatter(t_int,condits(condit).wells(w).cells(c).distance,'filled')

                end
             catch e
                fprintf(1,"condition: " + condits(condit).name + ", well:" + condits(condit).wells(w).name)
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

        
        
        
        
        plotCount = plotCount + 1;
        %myLine = refline(0,5);
        %myLine.Color = [0 0 0];
        
        %disp(i)
    end



end