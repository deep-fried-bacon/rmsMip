%Exper

function varargout = subsref(obj, S)
    %disp('subsref')
    %disp(S(1))
    switch S(1).type
        case '.'
            [varargout{1:nargout}] = builtin('subsref',obj,S);

        case {'()','{}'}

%                     switch length(subs(1).subs)
%                         case 1
            index = [];
            for i = 1:length(S(1).subs)
                switch class(S(1).subs{i})

                    case 'double'
                        disp('d')
                        index(i+1) = S(1).subs{1};
                    case {'char', 'string'}
                        index(i+1) = obj.conditIndexMap(S(1).subs{1});
                end
            end

            if length(S) == 1
                [varargout{1:nargout}] = obj.condits(index(1));
            else
                [varargout{1:nargout}] = obj.condits(index).subsref(S(2:end));
            end




    end
end
        