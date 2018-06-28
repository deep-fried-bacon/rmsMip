
X={1 2 3 4 5};
Y={1 4 9 16 25};

x = cell2mat(X);
y = cell2mat(Y);


figure
hold on
p = cellfun(@plot,X,Y);
for i = 1:size(p,2)
    p(1,i).Marker = 'o';
    p(1,i).MarkerFaceColor = p(i).Color;
end
%[p.Marker] = deal('o');
%p.MarkerFaceColor = {p.Color}
%arrayfun(@(a) set(a.Marker) 'o', p(:);
% p(1).Marker = 'o';
% p(2).Marker = '+';
% p(3).Marker = 's';
hold off

