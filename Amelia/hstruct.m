classdef hstruct < handle
	properties
		data
	end
	
	methods
		function obj = hstruct(data)
			obj.data = data;
		end
	end
end


% 
% > a.b.c = hstruct(1);
% >> d = a.b.c;
% >> d.data = 2;
% >> a.b.c.data
% ans =
%   2