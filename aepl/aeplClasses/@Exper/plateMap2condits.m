function [condits, conditIndexMap, groupWellMap] = plateMap2condits(obj,plateMapFile)
%condits = '';
%conditIndexMap = '';
ttable = readtable(plateMapFile,'Delimiter',',','ReadVariableNames',false);


startRowIndices = find(strcmp(ttable{:,1}, 'B')); %T.Var1,'B'))

groupIndex = find(strcmp(ttable{:,1},'Groups')) + 2;
if ~isempty(groupIndex) 
%temp = grouping+2;
    %g = ;
    startRowIndices(find(startRowIndices(:) == groupIndex)) = [];
else
    groupIndex = false;
end

stopRowIndices = double.empty(length(startRowIndices),0);


for z = 1:length(startRowIndices)
    abc = 'BCDEFGHIJKLMNOPQ';
    for i = 1:length(abc)   
        if i +startRowIndices(z) - 1 >= height(ttable)
            stopRowIndices(z) = i+startRowIndices(z)-1;
            break
        elseif ~strcmp(ttable{i+startRowIndices(z)-1,1}{1},abc(i))
            stopRowIndices(z) = i+startRowIndices(z)-2;
            break
        end

    end
end

oneTwoThree = {'2','3','4','5','6','7','8','9','10','11','12',...
    '13','14','15','16','17','18','19','20','21','22','23','24'};
oneTwoThreeB = {'02','03','04','05','06','07','08','09','10','11','12',...
    '13','14','15','16','17','18','19','20','21','22','23','24'};


startColIndex = 2;
stopColIndex = size(ttable,2);
for i = 2:size(ttable,2)    
    if ~strcmp(ttable{startRowIndices(z)-1,i},oneTwoThree{i-1})
        stopColIndex= i-1;
        break
    end
end


wellConditMap = containers.Map('KeyType','char','ValueType','char');
wellGroupMap = containers.Map('KeyType','char','ValueType','char');


%conditions = cell(0,2);
%groups = cell(0,2);
%condits = Condit.empty();



tableCount = length(startRowIndices);
for r = 0:stopRowIndices(1)-startRowIndices(1)         
    for col = startColIndex:stopColIndex
        
        
        temp = cell(tableCount,1);
        for i = 1:tableCount
            temp{i} = ttable{startRowIndices(i)+r,col}{1};
        end
        if ~any(cellfun(@isempty,temp))     %if no elements of temp are empty
            temp2 = strjoin(temp,', ');
            wellConditMap(strcat(abc(r+1),oneTwoThree{col-1})) = temp2;
            

            if groupIndex
                wellGroupMap(strcat(abc(r+1),oneTwoThree{col-1})) = ttable{groupIndex+r,col}{1};
            end
        end
          
    end
end
%end

    
    

conditions = unique(wellConditMap.values());
groups = unique(wellGroupMap.values());

conditWellMap = containers.Map;%('KeyType','char','ValueType','char');
groupWellMap = containers.Map;
conditCount = size(conditions,2);
%condits = Condit.empty(conditCount,0);

for condit = conditions
    %disp(condit{1})
    %disp(class(condit{1}))
    conditWellMap(condit{1}) = {};
end

for group = groups
    groupWellMap(group{1}) = {};
end
%for i = 1:conditCount
    %condits(i) = Condit(conditions(i));
%end

% for key = myMap2.keys()
%     %disp(key)
%     
% end
%wells = wellDict.keys();
%wells = mat2cell(wells);
for key = wellConditMap.keys() 
    %disp(class(key))
    %disp(myMap(key))
    well = key{1};
    condit = wellConditMap(well);
    conditWellMap(condit) = [conditWellMap(condit), well];

    try 
        group = wellGroupMap(well);
        groupWellMap(group) = [groupWellMap(group),condit];
    catch 
        
    end
    
    %disp(condit)
    
    %if conditWellMap.isKey(condit)
        
        


end



condits = Condit.empty(conditCount,0);
conditIndexMap = containers.Map;
i = 1;
for key = conditWellMap.keys()
    %disp(key{1})
    %disp(conditDict(key{1}))
    condits(i) = Condit(key{1}, conditWellMap(key{1}), obj);
    conditIndexMap(key{1}) = i;
    i = i + 1;
end




end




