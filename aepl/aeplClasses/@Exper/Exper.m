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
            
            [~,obj.name] = fileparts(obj.path);
            
            obj.plateMapFile = fullfile(obj.path,[obj.name,Exper.PLATE_MAP_SUF]);
            obj.cziList = dir(fullfile(obj.path,['*',Exper.CZI_SUF]));
            
            [obj.condits, obj.conditIndexMap] = Exper.plateMap2condits(obj.plateMapFile) ;
        end
        
        
        
        function srefs = subsref(obj, S)
            switch S(1).type
                case '.'
                    srefs = builtin('subsref',obj,S);
                    
                case {'()','{}'}
                    switch class(S(1).subs{1})
                        case 'double'
                            disp('d')
                            index = S(1).subs{1};
                        case {'char', 'string'}
                            index = obj.conditIndexMap(S(1).subs{1});
                    end
                    
                    if length(S) == 1
                        srefs = obj.condits(index);
                    else
                        srefs = obj.condits(index).subrefs(S(2:end));
                    end
            end
        end

                
        
        
        
    end
    
    methods (Static)
        
        
       
         [condits, conditIndexMap] = plateMap2condits(plateMapFile)
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
    end
end

