classdef Condit
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        name        % char[]
        wells       % Well[]
        
    end
    
    methods
        function obj = Condit(name)
            %UNTITLED Construct an instance of this class
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

