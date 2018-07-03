classdef Condit
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        name        % char[]
        exper
        wellNames
        wellIndexMap
        wells       % Well[]
        mat
        
    end
    
    methods
        function obj = Condit(name,wellNames,exper)
            %UNTITLED Construct an instance of this class
            %   Detailed explanation goes here
            obj.name = name;
            obj.wellNames = wellNames;
            obj.exper = exper;
            obj = obj.instansh();
        end
        
        
%         function wellIndexMap = makeWellIndexMap(obj, wellNames)
%             for
%             
%         end
        function obj = exPlot(obj)
            for w = 1:length(obj.wells)
               obj.wells(w) =  obj.wells(w).exPlot();
               obj.wells(w).name
               obj.name
               size(obj.wells(w).mat)
               obj.mat = [obj.mat obj.wells(w).mat];
            end
        end
        
        function obj=instansh(obj)
            obj.wells = Well.empty(0);
            obj.wellIndexMap = containers.Map;
            for i = 1:length(obj.wellNames)
                obj.wells(i) = Well(obj.wellNames{i},obj);
                obj.wellIndexMap(i) = obj.wellNames{i};
            
                %obj.wells(i).instansh();
            end
        end
          
        
%         function outputArg = method1(obj,inputArg)
%             %METHOD1 Summary of this method goes here
%             %   Detailed explanation goes here
%             %outputArg = obj.Property1 + inputArg;
%         end


%         function varargout = subsref(obj,S)
%             [varargout{1:nargout}] = builtin('subsref',obj,S);
%         end
        
       
    end
end

