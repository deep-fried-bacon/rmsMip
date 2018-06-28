classdef Well
    %WELL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        name            % char[]
        filePath        % char[]
        raw             % table
        cellCount       % int
        cells           % Cell[]
        
    end
    
    methods
        function obj = Well(name)
            %WELL Construct an instance of this class
            %   Detailed explanation goes here
            obj.name = name;
        end
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            %outputArg = obj.Property1 + inputArg;
        end
    end
end

