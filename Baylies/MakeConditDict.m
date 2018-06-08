function [conditions, conditDict] = MakeConditDict(f1)
%filename = 'D:\\PeopleFiles\\Lab\\hcc\\hccMim\\Cell_Tracking\\12.14.17 tracks\\Plate Map 12.14.17 copy.csv'
%f2 = 'D:\\PeopleFiles\\Lab\\hcc\\hccMim\\Cell_Tracking\\2018-03-18\\2018-03-18_plateMap.csv'

%f1 = '/Users/baylieslab/Documents/Amelia/rms/rmsMip/rmsMatip/misc/2018-03-18_plateMap.csv';

T = readtable(f1,'Delimiter',',','ReadVariableNames',false);

% index by row column 
T(5,10); % row 5, column 10

% find the portion of the table that has the well info - the first row
%                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             

% which has column with "B"
startRowIndices = find(strcmp(T{:,1}, 'B')); %T.Var1,'B'))
%T{row,col}

%firstB = indices(1)


% get this sub-table - then maybe the row/column names will be right ?
%NewT = T(firstB:firstB+10,:)
stopRowIndices = double.empty(length(startRowIndices),0);

% find the med for a well (like N3)
for z = 1:length(startRowIndices)
    abc = 'BCDEFGHIJKLMNOPQ';
    for i = 1:length(abc)   %T{:,1})-indices(1) 
    %     t = T{i+startIndices(1)-1,1}{1}
    %     a = abc(i)
        if i +startRowIndices(z) - 1 >= height(T)
            stopRowIndices{z} = i+startRowIndices(z)-1;
            break
        elseif ~strcmp(T{i+startRowIndices(z)-1,1}{1},abc(i))
    %         disp(i)
            stopRowIndices{z} = i+startRowIndices(z)-2;
            break
        end

    end
end

oneTwoThree = {'2','3','4','5','6','7','8','9','10','11','12',...
    '13','14','15','16','17','18','19','20','21','22','23','24'};
oneTwoThreeB = {'02','03','04','05','06','07','08','09','10','11','12',...
    '13','14','15','16','17','18','19','20','21','22','23','24'};

startColIndex = 2;
%stopRowIndex
for i = 1:length(oneTwoThree)
    %disp(col)
    if ~strcmp(T{startRowIndices(z)-1,i+1},oneTwoThree{i})
        stopColIndex= i;
        break
    end
end


wellDict = containers.Map('KeyType','char','ValueType','char');


if length(startRowIndices) == 1
    for row = startRowIndices(1):stopRowIndices(1)
        for col = startColIndex:stopColIndex 
            temp = T{row,col}
            if ~(length(temp) == 0)
                wellDict(strcat(T{row,1}{1},oneTwoThreeB{col-1})) = temp;
            end
        end
    end
elseif length(startRowIndices) == 2
    for r = 0:length(startRowIndices(1):stopRowIndices{1}) - 1
        for col = startColIndex:stopColIndex 
            
            a = T{startRowIndices(1)+r,col}{1};
            b = T{startRowIndices(2)+r,col}{1};
            %disp(b)
            if ~(length(a)==0 || length(b) == 0)
                temp = strcat(a,',',b);
            end        
            %temp = char(temp);
            temp = char(temp(:));
            if ~(length(temp)==1)
                wellDict(strcat(abc(r+1),oneTwoThreeB{col-1})) = temp;
            end
        end
    end
else 
    disp("uh oh - too many tables?")
end
    

conditions = unique(wellDict.values());

conditDict = containers.Map;%('KeyType','char','ValueType','char');

for condit = conditions
    %disp(condit{1})
    %disp(class(condit{1}))
    conditDict(condit{1}) = {};
end


% for key = myMap2.keys()
%     %disp(key)
%     
% end

for key = wellDict.keys() 
    %disp(class(key))
    %disp(myMap(key))
    well = key{1};
    condit = wellDict(well);
    
    if conditDict.isKey(condit)
        len = length(conditDict(condit));
        %conditDict(condit) = {conditDict(condit),well};
        temp = conditDict(condit);
        temp{len+1} = well;
        conditDict(condit) = temp;
        %disp(conditDict(condit))
        %disp(length(conditDict(wellDict(key{1}))))
        % = myMap(key{1})
    %if iskey(myMap2,myMap(key{1}))
%     else
%        disp(key) 
    end
end

% for key = conditDict.keys()
%     disp(key{1})
%     disp(conditDict(key{1}))
% end


end




