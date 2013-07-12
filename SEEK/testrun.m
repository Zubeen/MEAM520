clear all
clc
close all;

% Robot=initOpen('COM3','widow');
Robot=initOpen('/dev/ttyACM0','smith');
[l1 r1]=clean_encoders(Robot);
pause(0.5);
[l1 r1]=clean_encoders(Robot)
pause(0.5);
set_velocities(Robot,80,80);
set_velocities(Robot,80,80);
pause(5);
set_velocities(Robot,0,0);
pause(0.5);
[l2 r2]=clean_encoders(Robot);
pause(0.5);
[l2 r2]=clean_encoders(Robot)
[l2-l1 r2-r1]

finalClose(Robot);
% [x y theta]=getNextPosition(0,0,0,[l1 r1;l2 r2],0)


