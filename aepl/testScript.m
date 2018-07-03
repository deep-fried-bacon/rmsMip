




%mto = testClass()



% subs = cell(6,1);
% celSubs = cell(6,1);
% 
% subs(1) = {mto.a};
% 
% subs(2) = {mto.('a')};
% 
% subs(3) = {mto('a')};
% subs(4) = {mto('a','b')};
% 
% 
% celSubs(1) = mto(3);
% 

% subs = struct();
% 
% 
% subs.a = mto.a;
% 
% subs.b = mto.('a');
% 
% subs.c = mto('a');
% subs.d = mto('a','b');
% 
% 
% subs.e = mto(3);
% 
% subs.f = mto(3,4,6);
% subs.g = mto(3:5);
% 
% subs.h = mto{'a'}
% 
% 
% t = struct2cell(subs)
% u = cellfun(@struct2table,t,'UniformOutput',false)
% v = cell2table(u)


subs = cell(2,10);

subs(1:2,1) = mto.('a')

subs(1:2,2) = mto.('a');

subs(1:2,3) = mto('a');
subs(1:2,4) = mto('a','b');


subs(1:2,5) = mto(3);

subs(1:2,6) = mto(3,4,6);
subs(1:2,7) = mto(3:5);

subs(1:2,8) = mto{'a'};

%celldisp(subs);
subs{:,:};
