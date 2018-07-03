classdef Condit
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        name        % char[]
        wellNames
        wells       % Well[]
        
    end
    
    methods
        function obj = Condit(name,wellNames)
            %UNTITLED Construct an instance of this class
            %   Detailed explanation goes here
            obj.name = name;
            obj.wellNames = wellNames;
        end
        
%         function outputArg = method1(obj,inputArg)
%             %METHOD1 Summary of this method goes here
%             %   Detailed explanation goes here
%             %outputArg = obj.Property1 + inputArg;
%         end


        function srefs = subsref(obj,S)
            srefs = builtin('subsref',obj,S);
        end
    end
end

