mto=testClass();
subs = struct();


subs.a = mto.a;


subs.b = mto.('a');

subs.c = mto('a');
subs.d = mto('a','b');


subs.e = mto(3);

subs.f = mto(3,4,6);
subs.g = mto(3:5);

subs.h = mto{'a'};
subs.i = mto{1:3,1:4};
subs.j = mto(1:3,1:4);
subs.k = mto(1,2).(2);

%subs.l = subs.k(2)
%subs.k = subs.k(1)
%subs.m = mto.(1)

%fprintf(datastructure(subs));
datastructure(subs);




%datastructure(subs);