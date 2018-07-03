classdef Well
    %WELL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        name            % char[]
        condit
        %filePath        % char[]
        raw             % table
        mat
        cellCount       % int
        cells           % Cell[]
        xlsxFile
        
        
        
    end
    
    methods
        function obj = Well(name,condit)
            %WELL Construct an instance of this class
            %   Detailed explanation goes here
            obj.name = name;
            obj.condit = condit;
            
            
            
            
            
            
        end
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            %outputArg = obj.Property1 + inputArg;
        end
        
        function file = makeFile(obj,subfolder,suf)
            e = obj.condit.exper;
            
            file = fullfile(e.path,subfolder,horzcat(e.name,'_',obj.name,suf));
            
            
        end
        
        function instansh(obj)
            obj.xlsxFile = obj.makeFile('Xls','.xlsx');
            e = obj.condit.exper;
            if exist(obj.xlsxFile,'file')
                obj.raw = readtable(condits(c).wells(w).path);
                obj.cellCount = width(condits(c).wells(w).raw)/e.COL_COUNT;
                
                obj.raw = obj.raw.Variables;
                
                obj.cells = Cel.empty(obj.cellCount,0);
                for i = 1:obj.cellCount
                   startCol = (i-1)*e.COL_COUNT;
                   
                for j = 1:e.COL_COUNT 
                    obj.cells.(e.COLS{j}) = str2double(obj.raw(e.START_ROW,startCol+e.COL_LAYOUT(e.COLS{j}))); 
                    if isnan(obj.cells.(e.COLS{j}(end)))
                        obj.cells.(e.COLS{j}(end)) = [];
                    end
                end
                    
                end
                
            else
                error(['missing well xlsx file -',obj.name]);
            end
        end

        
    end
    
    
    methods (Static)
       
        
    end
end

