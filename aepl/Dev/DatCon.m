classdef DatCon < handle
    
    properties
        name                % chars
        parent              % DatCon or 'root'
        
        children            % DatCon[]
        childCount          % int
        childIndexMap       % Map<chars,int>
        
        top                % DatCon
        level               % int
        depth               % depth
        
        
    end
    
    
    
    methods
        
        function obj = DatCon(name,parent)
            obj.name = name;
            if ischar(parent) || isstring(parent) && strcmp(parent,'top')
                % special case constructor for root
                
                obj.parent = parent;
                
                obj.children = DatCon.empty(0);
                obj.childCount = 0;
                obj.childIndexMap = containers.Map();
                
                obj.top = obj;
                obj.level = 1;
                obj.depth = 1;
                
            else
                % normal constructor
                if ~isa(parent, 'DatCon')
                    error("parent must be a DatCon or 'top' ")
                else
                    obj.parent = parent;
                    obj.level = obj.parent.level + 1;

                    obj.depth = obj.level;

                    obj.parent.updateChildren(obj)
                    
                    obj.top = obj.parent.top;
                    %obj.depth = -1
                    
                    if obj.level > obj.top.depth
                        obj.top.depth = obj.level;
                    end
                    
                    
                    
                    
%                     if nargin >= 3
%                         obj.children = children;
%                         obj.childCount = length(obj.children);
%                         
%                         
%                         keyset = obj.children(:).name;
%                         valueset = 1:obj.childCount;
%                         
%                         obj.childIndexMap = containers.Map(keyset,valueset);
%                         
%                         obj.depth = obj.level;
                        %for i = 1:obj.childCount
                            
                           
                        
                    %else
                        obj.children = DatCon.empty(0);
                        obj.childCount = 0;
                        obj.childIndexMap = containers.Map();
                        
                    %end
                end
            end
        end
        
        
        function updateChildren(obj,child)
            %disp(obj.name)
            %disp(child.name)
            obj.childCount = obj.childCount + 1;
            obj.children(obj.childCount) = child;
            obj.childIndexMap(child.name) = obj.childCount;
            
            %while is
            p = child.parent;
            
            %disp('p==obj.parent')
            %disp(p==obj.parent)
            while ~strcmp('top',p)
                %disp(p.depth)
                %disp(child.depth)

                if child.depth > p.depth
                    %disp('k')
                    p.depth = child.depth;
                    %p.depth
                    %p.name
                end
                p = p.parent;
            end
           
        end
        
        %function recurs
        
        
        function varargout = subsref(obj, s)
            for i = 1:length(s)
                disp(s(i))
            end
            
            switch s(1).type
                case '.'
                    [varargout{1:nargout}] = builtin('subsref',obj,s);
                    
                case '()'
                    ddepth = length(s(1).subs);
                    if ddepth > obj.depth - obj.level
                        error('too many indices')
                    else
                        if isnumeric(s(1).subs{1})
                            index = s(1).subs{1};
                        elseif ischar(s(1).subs{1}) || isstring(s(1).subs{1})
                            index = obj.childIndexMap(s(1).subs{1});
                        else
                            error('index must be a number or char/string');
                        end

                        if length(s(1).subs) == 1
                            [varargout{1:nargout}] = obj.children(index);
                        else
                            s(1).subs = s(1).subs(2:end);
                            [varargout{1:nargout}] = subsref(obj.children(index), s);
                        end
                    end
                        
                case '{}'
                    [varargout{1:nargout}] = builtin('subsref',obj,s);
                    
            end
        end
        
        
        function obj = subsasgn(obj, s, varargin)
            for i = 1:length(s)
                disp(s(i))
            end
            switch s(1).type
                case '.'
                    obj = builtin('subsasgn',obj,s, varargin);
                    
                    
                case '()'
                    
                    ddepth = length(s(1).subs);
                    if ddepth > obj.depth - obj.level
                        error('too many indices')
                    else
                        if isnumeric(s(1).subs{1})
                            index = s(1).subs{1};
                        elseif ischar(s(1).subs{1}) || isstring(s(1).subs{1})
                            index = obj.childIndexMap(s(1).subs{1});
                        else
                            error('index must be a number or char/string');
                        end
                        
                        
                        if length(s(1).subs) == 1
                            obj.children(index) = varargin;
                        else
                            s(1).subs = s(1).subs(2:end);
                            
                            obj.children(index) = subsasgn(obj.children(index), s, varargin);
                        end
                        
                        
                    end
                    
                case '{}'
                    obj = builtin('subsasgn',obj,s,varargin);
                            
                    
                    
            end
            
            
            
            
        end
    
        
        function str = toString(obj)
            spcs = (obj.level-1);
            str = "";
            
            %if spcs >= 1
                %str = "|-";
            %end
            for i = 1:spcs-1
                str = str + "| ";
            end
            %i = i + 1;
            if spcs >= 1
            str = str + "\x221F-"; 
            end
            
            str = strcat(str,obj.name,'\n');
            for c = 1:obj.childCount
                str = str + obj.children(c).toString;
            end
            
        end

        function str = toString2(obj)
            spcs = (obj.level-1);
            str = "";
            for i = 1:spcs
                str = str + "   ";
            end
            
            str = strcat(str,obj.name,'\n');
            for c = 1:obj.childCount
                str = str + obj.children(c).toString2();
            end
            
        end
        
        
        
    end
end
    
    
