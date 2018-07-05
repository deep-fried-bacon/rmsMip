classdef DatCon < handle
    
    properties
        name                % chars
        id                  % int[]
        parent              % DatCon or 'root'
        
        children            % DatCon[]
        childCount          % int
        childIndexMap       % Map<chars,int>
        
        top                 % DatCon
        level               % int
        depth               % depth
        
        
    end
    
    
    
    methods
        
        function obj = DatCon(name,parent)
            obj.name = name;
            if ischar(parent) || isstring(parent) && strcmp(parent,'top')
                % special case constructor for root
                
                obj.id = [1];
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

                    
                    obj.top = obj.parent.top;
                 
                    obj.children = DatCon.empty(0);
                    obj.childCount = 0;
                    obj.childIndexMap = containers.Map();
                        
                    
                    obj.parent.updateChildren(obj)
                    
                    obj.id = [obj.parent.id obj.parent.childCount];

                  
                end
            end
        end
        
        
        function updateChildren(obj,child)
            obj.childCount = obj.childCount + 1;
            obj.children(obj.childCount) = child;
            obj.childIndexMap(child.name) = obj.childCount;
            
            p = child.parent;          
            while ~strcmp('top',p)
                if child.depth > p.depth
                    p.depth = child.depth;
                end
                p = p.parent;
            end
           
        end
        
      
        function varargout = subsref(obj, s)
%             for i = 1:length(s)
%                 disp(s(i))
%             end
            switch s(1).type
                case '.'
                    [varargout{1:nargout}] = builtin('subsref',obj,s);
                    
                case '()'
                    if length(obj) > 1
                        [varargout{1:nargout}] = builtin('subsref',obj,s);
                    else

                    ddepth = length(s(1).subs);
                    if ddepth > obj.depth - obj.level
                        disp('too many indices?')
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
                    
                    end
                        
                case '{}'
                    [varargout{1:nargout}] = builtin('subsref',obj,s);
                    
            end
        end
        
        
        function obj = subsasgn(obj, s, varargin)
%             for i = 1:length(s)
%                 disp(s(i))
%             end
            for i = 1:length(s)
                disp(s(i))
            end
            switch s(1).type
                case '.'
                    obj = builtin('subsasgn',obj,s, varargin);
                    
                    
                case '()'
                    if length(obj) > 1
                        obj = builtin('subsasgn',obj,s,varargin);
                    else

                    
                    ddepth = length(s(1).subs);
                    if ddepth > obj.depth - obj.level
                        disp('too many indices?')
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
                        
                    end
                    
                case '{}'
                    obj = builtin('subsasgn',obj,s,varargin); 
            end
        end
    
        
        function str = toString(obj)
            spcs = (obj.level-1);
            str = "";
            for i = 1:spcs-1
                str = str + "| ";
            end
            if spcs >= 1
            str = str + "\x221F-"; 
            end
            
            str = strcat(str,obj.name,'\n');
            for c = 1:obj.childCount
                str = str + obj.children(c).toString();
            end
            
        end

        function [fore,cur,aft] = toStringParts(obj,curId)
            spcs = (obj.level-1);
            str = "";
            for i = 1:spcs-1
                str = str + "| ";
            end
            if spcs >= 1
            str = str + "\x221F-"; 
            end
            str = strcat(str,obj.name,'\n');
            for c = 1:obj.childCount
                if length(obj.children(c).id) == length(curId) && all(obj.children(c).id == curId)
                   fore = str;
                   cur = obj.children(c).toString();
                   str = "";
                   
                else
                    str = str + obj.children(c).toString();
                end
            end
            aft = str;
            
        end
        
        
        function disp(obj)
            if length(obj) == 1
                fprintf(1,obj.toString());
            else
               for o = obj
                   disp(o.name)
               end
            end
        end
        
        
        function dispCur(obj) 
           [fore,cur,aft] = obj.top.toStringParts(obj.id);
           fprintf(1,fore)
           cprintf('red',cur)
           fprintf(1,aft)
        end
        
        
    end
end
    
    
