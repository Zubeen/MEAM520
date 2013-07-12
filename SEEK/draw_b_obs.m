function draw_b_obs(coord)

x=coord(:,1);
y=coord(:,2);

h = 11.5;
ra = 4.5;
tht = linspace(0,2*pi,100);
z = linspace(0,h,20);
xa = repmat(ra*cos(tht),20,1);
ya = repmat(ra*sin(tht),20,1);
za = repmat(z',1,100);
%surf(xa+x,ya+y,za,'FaceColor');
%shading interp
surface(xa+x,ya+y,za,'FaceColor','blue','EdgeColor','none');
hold on;
end