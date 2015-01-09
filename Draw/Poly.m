clc
clear

%    [  1 x1   x2   x1^2  x2^2  x1x2 ]

Wa = [ -1.5 -2 0 0 1 0 ];
Wb = [ -15 -16 0 8 6 0 ]./9;

% x = [ x1 x2 y;...]
x = [  1  0 -1;
       0  1 -1;
       0 -1 -1;
      -1  0  1;
       0  2  1;
       0 -2  1;
      -2  0  1];

N = size(x,1);

plot(x(1:3,1), x(1:3,2),'rx');
hold on
plot(x(4:7,1), x(4:7,2),'+');
hold on
[x1 x2] = meshgrid(-5:0.1:5,-5:0.1:5);

za = curv(x1,x2,Wa);
zb = curv(x1,x2,Wb);

contour(x1,x2,za,[0 0],'k');
contour(x1,x2,zb,[0 0],'b');

axis([-3 5 -4 4]);


