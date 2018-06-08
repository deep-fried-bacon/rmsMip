
%COL_NAMES = {2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24};
% COL_NAMES_2 = {'2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24'};
% ROW_NAMES = {'B','C','D','E','F','G','H','I','J','K','L','M','N','O','P'};

COL_NAMES = {"2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24"};
ROW_NAMES = {"B","C","D","E","F","G","H","I","J","K","L","M","N","O","P"};





file = '/Users/baylieslab/Documents/Amelia/EPL/06-23pm.csv';
plateMapT = readtable(file,'TextType','string','Delimiter',',');
 
plateMapC = table2cell(plateMapT);

[rCount, cCount] = size(plateMapC);
started = false;
col = 1;
row = 1;


for r = 1:rCount
    for c = 1:cCount
        temp = string(plateMapC{r,c});
        %disp(["temp",temp,"COL_NAMES{col}",COL_NAMES{col}])
        if started 
           
             if temp ~= COL_NAMES{col}
                 
             else
                 %disp(['r',r,'c',c])
                 col = col + 1;
             end
        else
            if temp == COL_NAMES{1}
                pm.
                started = true;
                col = col + 1;
            end
        end
    end
end

% 
% for r = 1:rCount
%     for c = 1:cCount
%         temp = plateMapC{r,c};
%         if started 
%             if 
%         else
%             if temp == COL_NAMES{1}
%                 started = true
%             end
%         end
%     end
% end




% [rCount, cCount] = size(plateMapC);
% %plateMapT2 = 
% for r = 1:rCount
%     for c = 1:cCount
%         temp = plateMapC{r,c};
%         %disp(class(temp))
%         if class(temp) == "char"
%             [num, status] = str2num(temp);
%             if status == 1 
%                 plateMapC{r,c} = num;
%             else
%         
%                 if temp == ""
%                     plateMapC{r,c} = NaN;
% 
%                 end
%             end
%         end
%     end
% end




