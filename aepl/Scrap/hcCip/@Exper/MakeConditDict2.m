function [conditions, conditDict] = MakeConditDict(obj)%filename)


T = readtable(obj.plateMapFile,'Delimiter',',','ReadVariableNames',false);


startRowIndices = find(strcmp(T{:,1}, 'B'));
stopRowIndices = double.empty(length(startRowIndices),0); % just instatiating object

%% loops through each table if there are multiple
for z = 1:length(startRowIndices)
    abc = 'BCDEFGHIJKLMNOPQ';
    for i = 1:length(abc)   
        if i+startRowIndices(z) - 1 >= height(T)
            stopRowIndices{z} = i+startRowIndices(z)-1;
            break
        elseif ~strcmp(T{i+startRowIndices(z)-1,1}{1},abc(i))
    %         disp(i)
            stopRowIndices{z} = i+startRowIndices(z)-2;
            break
        end

    end
end
%%

oneTwoThree = {'2','3','4','5','6','7','8','9','10','11','12',...
    '13','14','15','16','17','18','19','20','21','22','23','24'};
oneTwoThreeB = {'02','03','04','05','06','07','08','09','10','11','12',...
    '13','14','15','16','17','18','19','20','21','22','23','24'};

startColIndex = 2;

for i = 1:length(oneTwoThree)
    if ~strcmp(T{startRowIndices(z)-1,i+1},oneTwoThree{i})
        stopColIndex= i;
        break
    end
end


%wellDict = containers.Map('KeyType','char','ValueType','char');
wellDict = struct();

if length(startRowIndices) == 1
    for row = startRowIndices(1):stopRowIndices(1)
        for col = startColIndex:stopColIndex 
            temp = T{row,col};
            if ~(isempty(temp))
                % oneTwoThreeB{col-1} --> assumes cols start with 2
                % wellDict.(strcat(T{row,1}{1},oneTwoThreeB{col-1})) = temp;
                wellDict.(strcat(T{row,1}{1},oneTwoThreeB{col-1})) = temp;
                

            end
        end
    end
elseif length(startRowIndices) == 2
    for r = 0:length(startRowIndices(1):stopRowIndices{1}) - 1
        for col = startColIndex:stopColIndex 
            
            a = T{startRowIndices(1)+r,col}{1};
            %disp(a)
            b = T{startRowIndices(2)+r,col}{1};
            %disp(b)
            %disp(strcat('a{1}="',a{1},'" isempty(a)=',num2str(isempty(a))))
%             if strcmp(abc(r+1), 'O')
%                 %disp(isempty(a) || isempty(b))
%                 %disp(isempty(b))
%                 disp(class(a))
%                 disp(a)
%                 disp(class(b))
%                 disp(b)
%             end
                
            %if ~(isempty(a) || isempty(b) || isempty(a{1}) || isempty(b{1}))
            if ~(isempty(a) || isempty(b))
                %disp(strcat('a="',a, '" b="',b, '"'))
                temp = strcat(a,", ",b);
                %class(temp)
                %temp)
            end       
            
            %temp = char(temp(:));
            %disp(temp)
            %Sdisp(length(temp))
            if ~(length(temp)>1)
                %disp('ja')
                
                wellDict.(strcat(abc(r+1),oneTwoThreeB{col-1})) = (temp);
            end
        end
    end
else 
    disp("uh oh - too many tables?")
end

%wellDict.P16

%wells = fieldnames(wellDict);
%wells2 = cell2mat(wells);%wells(:,:);
%class(wells2);
%bloop = wellDict(wells2(:,:))
temp = struct2cell(wellDict);
temp = [temp{:,:,:}];

conditions = unique(temp);%struct2cell(wellDict));


conditDict = struct();%containers.Map;%('KeyType','char','ValueType','char');

for condit = conditions
    %disp(condit{1})
    %disp(class(condit{1}))
    conditDict.(condit) = [];
end


% for key = myMap2.keys()
%     %disp(key)
%     
% end

for well = fieldnames(wellDict)
    %disp(class(key))
    %disp(myMap(key))
    %well = key{1};
    condit = wellDict.well;
    
    if conditDict.isKey(condit)
        %len = length(conditDict(condit));
        %conditDict(condit) = {conditDict(condit),well};
        temp = conditDict(condit);
        temp(end+1) = well;
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




