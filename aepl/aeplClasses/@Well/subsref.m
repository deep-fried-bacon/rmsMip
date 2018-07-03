function varargout = subsref(obj, S)
            %disp('subsref')
            %disp(S(1))
            switch S(1).type
                case '.'
                    [varargout{1:nargout}] = builtin('subsref',obj,S);
                    
                case {'()','{}'}
                    
%                     switch length(subs(1).subs)
%                         case 1
                     [varargout{1:nargout}] = obj.cells.subsref(S);

                    
                    
                    
            end
        end