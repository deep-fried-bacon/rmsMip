classdef testClass2 < handle
    %TESTCLASS2 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        a
        b
        c
    end
    
    methods
        function obj = testClass2(a)
            %TESTCLASS2 Construct an instance of this class
            %   Detailed explanation goes here
            obj.a = a;
        end
        
        function changeB(obj,b)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            obj.b = b;
        end
    end
end

