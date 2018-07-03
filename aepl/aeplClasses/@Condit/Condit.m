classdef Condit
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        name        % char[]
        exper
        wellNames
        wells       % Well[]

        
    end
    
    methods
        function obj = Condit(name,wellNames,exper)
            %UNTITLED Construct an instance of this class
            %   Detailed explanation goes here
            obj.name = name;
            obj.wellNames = wellNames;
            obj.exper = exper;
        end
        
        function instansh(obj)
            obj.wells = Well.empty(0);
            for i = 1:length(obj.wellNames)
                obj.wells(i) = Well(obj.wellNames(i),obj);
                obj.wells(i).instansh();
            end
        end
          
        
%         function outputArg = method1(obj,inputArg)
%             %METHOD1 Summary of this method goes here
%             %   Detailed explanation goes here
%             %outputArg = obj.Property1 + inputArg;
%         end


        function varargout = subsref(obj,S)
            [varargout{1:nargout}] = builtin('subsref',obj,S);
        end
        
       
    end
end

