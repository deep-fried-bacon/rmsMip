


classdef DatCon < DatConBase
    properties
%         name
%         parent      % DatCon
%         root
%         
%         
%         children    % DatCon[]
%         childIndexMap
%         data
%         info        % scalar? struct()
%         % scalar? struct()
%         level
        %level
        %depth
    end
    
    methods
        function obj = DatCon(name,parent,varargin)
            if (ischar(parent) || isstring(parent) && strcmp('root',parent))
                obj = DatConRoot(name,parent);
                %return
                %obj.parent = 'root';
                return
            end
            if ischar(name) || isstring(name)
                obj.name = name;
            else
                error('name must be char/string');
            end
            
            
                %obj.parent = parent;
                %obj.level = 0;
                
                
            if isa(parent,'DatCon')
                
                obj.parent = parent;
                
                obj.level = obj.parent.level + 1;
                obj.root = parent.root;
                if obj.level > obj.root.depth
                    obj.root.depth = obj.level;
                end
            else
                error('invalid parent argument')
            end
            
            
            if nargin >= 3
                obj.children = varargin(1);
            end
            if nargin >= 4
                obj.childIndexMap = varargin(2);
            end
            if nargin >= 5
                obj.data = varargin(3);
            end
            if nargin >= 6
                obj.info = varargin(4);
            end
            
            parent.update(obj);
            
            
        end
        
        
        function out = get(obj,varargin)
            if nargin > obj.root.depth-obj.level
                error('too many arguments')
                
            else
                if nargin == 1
                    out = obj.getChild(varargin(1));
                else
                    out = obj.getChild(varargin(1)).get(varargin(2:end));
                end
                
            end
            
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









