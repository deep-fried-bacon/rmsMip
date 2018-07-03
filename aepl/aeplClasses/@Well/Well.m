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
            disp(name)
            obj.condit = condit;
            obj = obj.instansh();
            
            
            
            
            
            
        end
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            %outputArg = obj.Property1 + inputArg;
        end
        
        function file = makeFile(obj,subfolder,suf)
            e = obj.condit.exper;
            
            f = [e.name,'_',obj.name,suf];
            file = fullfile(e.path,subfolder,f);
            
            
        end
        
        function obj = exPlot(obj)
           for c = 1:obj.cellCount
              obj.mat = [obj.mat obj.cells(c).distance(2:end)];
           end
            
        end
        
        function obj = instansh(obj)
            %tic
            obj.xlsxFile = obj.makeFile('Xls','.csv');
            e = obj.condit.exper;
            if exist(obj.xlsxFile,'file')
                obj.raw = readtable(obj.xlsxFile);
                obj.cellCount = width(obj.raw)/e.COL_COUNT;
                
                obj.raw = obj.raw.Variables;
                
                obj.cells = Cel.empty(obj.cellCount,0);
                for i = 1:obj.cellCount
                   startCol = (i-1)*e.COL_COUNT;
                                       obj.cells(i) = Cel(obj.raw{1,startCol+1});

                for j = 1:e.COL_COUNT 
                    %disp(startCol + e.COL_LAYOUT.(e.COLS{j}))
                    obj.cells(i).(e.COLS{j}) = str2double(obj.raw(e.START_ROW:end,startCol+e.COL_LAYOUT.(e.COLS{j}))); 
                    if isnan(obj.cells(i).(e.COLS{j})(end))
                        obj.cells(i).(e.COLS{j})(end) = [];
                    end
                end
                    
                end
                
            else
                error(['missing well xlsx file -',obj.name]);
            end
            %toc
        end

        
    end
    
    
    methods (Static)
       
        
    end
end

