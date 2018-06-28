


classdef DatCon
    properties
        Parent
        Children
        info
        data
    end
    
    methods 
        function obj = DatCon(aa,bb)
            obj.a = aa;
            if  nargin ~= 1
                obj.b = bb;
            end
        end
    end
end
        
        


        
        
        
        
        
    