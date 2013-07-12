%same as puma_viz, only with longer link lengths(ratios maintained), and no
%labelling, is called in bonus #2

function []=puma_viz_n(th_1,th_2,th_3,th_4,th_5,th_6)

a=13;b=3.5;c=8.0;d=3.0;e=8.0;f=2.5;
a=a*5;b=b*5;c=c*5;d=d*5;e=e*5;f=f*5;

H01=[cos(th_1) -sin(th_1)*cos(90*pi/180) sin(th_1)*sin(90*pi/180) 0;
    sin(th_1) cos(th_1)*cos(90*pi/180) -cos(th_1)*sin(90*pi/180) 0;
    0 sin(90*pi/180) cos(90*pi/180) a;
    0 0 0 1];

H12=[cos(th_2) -sin(th_2)*cos(0) sin(th_2)*sin(0) c*cos(th_2);
    sin(th_2) cos(th_2)*cos(0) -cos(th_2)*sin(0) c*sin(th_2);
    0 sin(0) cos(0) -b;
    0 0 0 1];

H23=[cos(th_3) -sin(th_3)*cos(-90*pi/180) sin(th_3)*sin(-90*pi/180) 0;
    sin(th_3) cos(th_3)*cos(-90*pi/180) -cos(th_3)*sin(-90*pi/180) 0;
    0 sin(-90*pi/180) cos(-90*pi/180) -d;
    0 0 0 1];

H34=[cos(th_4) -sin(th_4)*cos(90*pi/180) sin(th_4)*sin(90*pi/180) 0;
    sin(th_4) cos(th_4)*cos(90*pi/180) -cos(th_4)*sin(90*pi/180) 0;
    0 sin(90*pi/180) cos(90*pi/180) e;
    0 0 0 1];

H45=[cos(th_5+pi/2) -sin(th_5+pi/2)*cos(90*pi/180) sin(th_5+pi/2)*sin(90*pi/180) 0;
    sin(th_5+pi/2) cos(th_5+pi/2)*cos(90*pi/180) -cos(th_5+pi/2)*sin(90*pi/180) 0;
    0 sin(90*pi/180) cos(90*pi/180) 0;
    0 0 0 1];

H56=[cos(th_6) -sin(th_6)*cos(0) sin(th_6)*sin(0) 0;
    sin(th_6) cos(th_6)*cos(0) -cos(th_6)*sin(0) 0;
    0 sin(0) cos(0) f;
    0 0 0 1];
H06=H01*H12*H23*H34*H45*H56;

H02=H01*H12;
H03=H01*H12*H23;
H04=H01*H12*H23*H34;
H05=H01*H12*H23*H34*H45;

p0=[0 0 0];
% p1=[0 0 a];
% p2=[0 b a];
% p3=[c b a];
% p4=[c b+d a];
% p5=[c b+d a+e];
% p6=[c+f b+d a+e];
% 
% p0=p0;
p1=H01*[p0 1]';
p3=H02*[p0 1]';
p4=H03*[p0 1]';

p5=H04*[p0 1]';

p6=H06*[p0 1]';
p0_2=[0 0 -b];
p2=H01*[p0_2 1]';


p1=p1(1:3)';
p2=p2(1:3)';
p3=p3(1:3)';
p4=p4(1:3)';
p5=p5(1:3)';
p6=p6(1:3)';

P0=[p0;p1;p2;p3;p4;p5];
P1=[p1;p2;p3;p4;p5;p6];

arrow3(P0,P1)


hold on;
orig=[0 0 0;0 0 0;0 0 0];
xyz0=[1*5 0 0;0 2*5 0;0 0 3*5];



orig_6=[p6;p6;p6];
x_6=H06*[1*10 0 0 1]';x_6=x_6(1:3)';
y_6=H06*[0 2*10 0 1]';y_6=y_6(1:3)';
z_6=H06*[0 0 3*10 1]';z_6=z_6(1:3)';

xyz6=[x_6;y_6;z_6];

hold on;
 arrow3(orig_6,xyz6,'b');

xlabel('x0');ylabel('y0');zlabel('z0');

