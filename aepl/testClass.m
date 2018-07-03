classdef testClass
    %TESTCLASS Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        name
        id
        children
    end
    
    methods
        function obj = testClass()
            obj.name = 'butts';
            obj.id = 1;
            obj.children = ones(10,1);
            
            
            
        end
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
        
        
        
        
        function B = subsref(obj,S)
           
            
            B = S;
            
        end
        
        
        
        function B = subsref2(obj, S)
            disp('-----------')
            disp(S)
            most = -1;
            for s = S
                if length(s.type) > most
                    most = length(s.type);
                end
            end
            
            temp = struct();
            temp.type = {}
            temp.subs = {}
            for i = 1:length(S)
                st = S(i).type
                if length(st) < most
                    try
                        st(most) = {0}
                    catch
                        st(most) = '-'
                    end
                end
                temp.type = [temp.type; st]
                
                ss = S(i).subs
                if length(ss) < most
                    ss(most) = 0
                end
                temp.subs = [temp.subs; ss]
            end
                %temp.subs = [S(:).subs,10];
            B = temp;
            
        end
        
    end
end

