classdef Exper
    properties (Constant)
       PLATE_MAP_SUF = '_plate-map.csv'
       CZI_SUF  = '.czi'
    end
	properties
		folder  % char[]
        name    % char[]
        plateMapFile    % char[]
        conditions      % char[][]
        conditDict      % Map
        czi             % char[][]
        figureHandles   % figures[]
        frameCount      % int
        
        
        
        
	end
	
	methods
        [conditions, conditDict] = MakeConditDict(filename)

		function obj = Exper(folder)
			obj.folder = folder;
            
            %% later make so code doesn't assume path ends with / 
            % and platform independent
            [~,obj.name] = fileparts(obj.folder(1:end-1));
            
            
            obj.plateMapFile = strcat(obj.folder,obj.name,Exper.PLATE_MAP_SUF);
            [obj.conditions,obj.conditDict] = obj.MakeConditDict();%obj.plateMapFile);

        end
        

        
        
        
	end
end

