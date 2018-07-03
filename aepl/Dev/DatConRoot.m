


classdef DatConRoot < DatConBase
    properties
        depth
    end
    
    methods 
        function obj = DatConRoot(name,parent)
            disp('k')
            disp(nargin)
            obj.name = name;
            %obj.parent = 'root';
            obj.parent = parent;
            obj.level = 1;
            obj.depth = 1;
            
            if nargin >= 2
                obj.children = varargin(1);
            end
            if nargin >= 3
                obj.data = varargin(2);
            end
            if nargin >= 4
                obj.info = varargin(3);
            end
            
        end
            
            
          
        
        
            
        
    end
    
    
    
    
end
        
        


        
        
        
        
        
    