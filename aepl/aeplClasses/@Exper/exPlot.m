function obj = exPlot(obj)
class(obj);


for group = obj.groups.keys()
    for c = obj.groups(group{1})
        
        obj. condits( obj.conditIndexMap(c{1}) ) = obj. condits( obj.conditIndexMap(c{1}) ).exPlot();
        %S.type = '()';
        %S.subs = c;
        %index = find(obj.condits, obj.subsref(S))
        
    end 

end