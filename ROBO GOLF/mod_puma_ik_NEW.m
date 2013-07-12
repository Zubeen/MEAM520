function [thetas] = mod_puma_ik(x7,y7,z7,phi,theta,psi,mmflag)

%convert from mm to inches
if mmflag==1
 x7=x7*0.0393700787;
 y7=y7*0.0393700787;
 z7=z7*0.0393700787;
end

%link lengths
a=13.0;b=2.5;c=8.0;d=2.5;e=8.0;f=2.5;g=6.25;

%calculate tranfrom matrix from frame 0 to 7 (using Euler angles)
R=[cos(phi)*cos(theta)*cos(psi)-sin(phi)*sin(psi) -cos(phi)*cos(theta)*sin(psi)-sin(phi)*cos(psi) cos(phi)*sin(theta);
   sin(phi)*cos(theta)*cos(psi)+cos(phi)*sin(psi) -sin(phi)*cos(theta)*sin(psi)+cos(phi)*cos(psi) sin(phi)*sin(theta);
   -sin(theta)*cos(psi) sin(theta)*sin(psi) cos(theta)]

R76=[1 0 0;0 1 0;0 0 1];
R06=R*R76;

%compute center of wrist%
wrist=[x7;y7;z7]+R*[0;0;-(f+g)]%CFS

%theta1-CFS%
theta1=atan2(wrist(2),wrist(1))-atan2((b+d),sqrt(wrist(1)^2+wrist(2)^2-(b+d)^2))
th1=theta1*180/pi;
if(th1<0 && th1<-180)
    'exceeds th1 lim'
end
if(th1>110)
    'exceeds th1 lim'
end

%theta3 -CFS%
temp=(wrist(1)^2+wrist(2)^2-(b+d)^2+(wrist(3)-a)^2-c^2-e^2)/(2*e*c);%this or -v3
theta3=atan2(-sqrt(1-temp^2),temp);
th3=theta3*180/pi;
if(th3<0 && th3<-235)
    'exceeds th3 lim'
end
if(th3>60)
    'exceeds th3 lim'
end

%theta2 -CFS%
theta2= atan2(wrist(3)-a,sqrt(wrist(1)^2+wrist(2)^2-(b+d)^2))-atan2(e*sin(theta3),c+e*cos(theta3))
th2=theta2*180/pi;
if(th2<0 && th2<-75)
    'exceeds th2 lim'
end
if(th2>240)
    'exceeds th2 lim'
end

%Vertical config subtract pi/2 
theta3 = theta3-pi/2;

%Using FK to get transform from 0 to 3, and frm 3 to 6
A1=[cos(theta1) 0 sin(theta1) 0;
    sin(theta1) 0 -cos(theta1) 0;
    0 1 0 a ;
    0 0 0 1];
A2=[cos(theta2) -sin(theta2) 0 c*cos(theta2); 
    sin(theta2) cos(theta2) 0 c*sin(theta2);
    0 0 1 -b ;
    0 0 0 1];
A3=[cos(theta3) 0 -sin(theta3) 0;
    sin(theta3) 0 cos(theta3) 0;
    0 -1 0 -d;
    0 0 0 1];
R03=A1(1:3,1:3)*A2(1:3,1:3)*A3(1:3,1:3);
R30=R03.';
R36=R30(1:3,1:3)*R06;

%theta5%
temp=R36(3,3);
theta5=(atan2(sqrt(1-temp^2),-temp))-pi/2;
th5=theta5*180/pi;
if(th5>230 || th5<-30)
%theta5=(atan2(tempsin,-sqrt(1-tempsin^2)))
'exceeds th5 lims'
end 

%theta6%;
theta6=atan2(-R36(3,2),R36(3,1))
th6=theta6*180/pi;

%theta4%
theta4=atan2(R36(2,3),R36(1,3))
th4=theta4*180/pi;

thetas=[theta1 theta2 theta3 theta4 theta5 theta6];
end