clf

blu =   [0.00,0.45,0.75];
ora =   [0.85,0.33,0.10];
yel =   [0.93,0.69,0.13];
purp =  [0.49,0.18,0.56];
gree =  [0.47,0.67,0.19];
lblu =  [0.30,0.75,0.93];
red =   [0.64,0.08,0.18];


x = -3*pi:.1:3*pi;
y=sin(x);

line(x,y,'LineWidth',3)
ylim([-5,5])
y2 = cos(x);
hold on
line(x,y2,'Color',ora,'LineWidth',3)
%


y3 = sin(x+pi);
line(x,y3,'Color',yel,'LineWidth',3)

y4 = cos(x+pi);
line(x,y4,'Color',gree,'LineWidth',3)