


classdef (Abstract) DatConBase < handle
    properties
        name
        parent      % DatCon
        root
        
        
        children    % DatCon[]
        childIndexMap
        data
        info        % scalar? struct()
        % scalar? struct()
        level
        %level
        %depth
    end
    methods
        
        function obj = DatConBase(name)
            obj.name = name;
        end
    
        
        function child = getChild(obj,key)
            if isnumeric(key)
                child = obj.children(key);
            elseif ischar(key) || isstring(key)
                child = obj.children(obj.childIndexMap(key));
            else
                error('invalid key or index')
            end
        end
        
        
        function update(obj,child)
            obj.count = obj.count + 1;
            obj.Children(obj.count) = child;
            obj.childIndexMap(child.name) = obj.count;
        end
        
        
        function addChild(obj, name)
            DatCon(name,obj);
            
        end
        
        
    end
    
    
    
    
end




















