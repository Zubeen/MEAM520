function draw_marker(coord)


x=coord(1,1);
y=coord(1,2);

load('red_cyl.mat');

h = 10;
ra = 1;
tht = linspace(0,2*pi,100);
z = linspace(0,h,20);
xa = repmat(ra*cos(tht),20,1);
ya = repmat(ra*sin(tht),20,1);
za = repmat(z',1,100);
% surf(xa+x,ya+y,za);
% colormap(jet);
% shading interp
surface(xa+x,ya+y,za,'FaceColor','red','EdgeColor','none');
hold on;
end