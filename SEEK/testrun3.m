clear all
clc
close all;

 Robot=initOpen('/dev/ttyACM0','jack');
% Robot=initOpen('COM3','jack');
x=0;y=0;theta=0;
[l1 r1]=getEncoders(Robot);%clean_encoders(Robot)
% encoderValues=[0 0;l1 r1];
[l1 r1]=getEncoders(Robot);%clean_encoders(Robot)
encoderValues=[0 0;l1 r1];
set_velocities(Robot,80,120);
i=0;

th_ref=90*pi/180;

v_l=80;
v_r=80;
while(i<=100)
    i=i+1
    %[l2 r2]=clean_encoders(Robot)
%     encoderValues=[encoderValues(2,:);l2 r2];
    [l2 r2]=getEncoders(Robot);%
    encoderValues=[encoderValues(2,:);l2 r2]
    
    [x y theta]=getNextPosition(x,y,theta,encoderValues,0)
    plot(x,y,'r*');xx(i)=x;yy(i)=y;th(i)=theta;
    
    
    
    hold on;
     %pause(1);
    axis equal;
end
set_velocities(Robot,0,0);
finalClose(Robot);




