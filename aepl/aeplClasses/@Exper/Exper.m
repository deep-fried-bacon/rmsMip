% addpath('./aeplClasses')
% addpath('./aeplUtil')
% addpath('./processCzi')
% addpath('./readPlotCvs')


classdef Exper
    %EXPER Summary of this class goes here
    %   Detailed explanation goes here
    
    
    properties (Constant)
       PLATE_MAP_SUF = '_plate-map.csv'
       CZI_SUF  = '.czi'
       
   
    end
    
    properties
        path            % char[]    currently called folder in struct
        name            % char[]
        plateMapFile    % char[]
        condits         % Condits[]     starts as conditDict
        conditIndexMap
        cziList         % <filenames>[]
        frameCount      % int
        groups
        COL_COUNT
        COL_LAYOUT
        COLS
        START_ROW
        
    end
    
    methods
        function obj = Exper(path)
            %EXPER Construct an instance of this class
            %   Detailed explanation goes here
            %obj.path = path;
            if strcmp(path(end),filesep)
                obj.path = path(1:end-1);
            else
                obj.path = path;
            end
            
            obj = obj.set_COL_LAYOUT();
            
            [~,obj.name] = fileparts(obj.path);
            
            obj.plateMapFile = fullfile(obj.path,[obj.name,Exper.PLATE_MAP_SUF]);
            obj.cziList = dir(fullfile(obj.path,['*',Exper.CZI_SUF]));
            
            [obj.condits, obj.conditIndexMap, obj.groups] = obj.plateMap2condits(obj.plateMapFile) ;
            
            %obj = obj.instansh();
        end
        
        
        function varargout = subsindex(obj,S)
            disp('subsindex')
            %disp(S)
            [varargout{1:nargout}] = builtin('subsindex',obj,S);
        end
        
        
        
        
        
        function obj = instansh(obj) 
           %for condit = obj.condits
           for i = 1:length(obj.condits)
               obj.condits(i) = obj.condits(i).instansh();
           end
        end
        %readInCondits(obj)
            
            [condits, conditIndexMap, groups] = plateMap2condits(obj,plateMapFile)
        
                
            function obj = set_COL_LAYOUT(obj)
                
                obj.COL_COUNT = 5;

                obj.COL_LAYOUT.xcoords = 1;
                obj.COL_LAYOUT.ycoords = 2;
                obj.COL_LAYOUT.area = 3;
                obj.COL_LAYOUT.covarience = 4;
                obj.COL_LAYOUT.distance = 5;
                obj.COLS = (fieldnames(obj.COL_LAYOUT));
                obj.START_ROW = 5;
        
            end
        
            
            
            
            obj = exPlot(obj)
        
    end
    
    methods (Static)
        
            
        
        
       
         
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
    end
end

