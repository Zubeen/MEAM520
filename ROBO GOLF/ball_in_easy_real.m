function [changex]=ball_in_easy(BallPosition,easy_hole)

%% from start, to the ball;
%thetas_start=[0 0 0 0 0 0];
%actually make it pumaAngles;


thetas_start=pumaAngles;
B=BallPosition;

x=B(1);y=B(2);z=B(3)+4; % get it 2in over ball

thetas_ball=mod_puma_ik_NEW(x,y,z,-pi,-pi,0,0);

change=abs((thetas_ball-thetas_start)*180/pi);
indx=max(change(:))/4;



if(change(1)==0)
    th1=zeros(1,floor(indx)+1);
else
    th1=thetas_start(1):(thetas_ball(1)-thetas_start(1))/indx:thetas_ball(1);
end

if(change(2)==0)
    th2=zeros(1,floor(indx)+1);
else
th2=thetas_start(2):(thetas_ball(2)-thetas_start(2))/indx:thetas_ball(2);
end

if(change(3)==0)
    th3=zeros(1,floor(indx)+1);
else

th3=thetas_start(3):(thetas_ball(3)-thetas_start(3))/indx:thetas_ball(3);
end
if(change(4)==0)
    th4=zeros(1,floor(indx)+1);
else

th4=thetas_start(4):(thetas_ball(4)-thetas_start(4))/indx:thetas_ball(4);
end

if(change(5)==0)
    th5=zeros(1,floor(indx)+1);
else

th5=thetas_start(5):(thetas_ball(5)-thetas_start(5))/indx:thetas_ball(5);

end

if(change(6)==0)
    th6=zeros(1,floor(indx)+1);
else

th6=thetas_start(6):(thetas_ball(6)-thetas_start(6))/indx:thetas_ball(6);
end

if sum(change(:))==0
run_len=0; ' no change'
else run_len=floor(indx)+1;
end

for i=1:run_len
    pumaServo(th1(i),th2(i),th3(i),th4(i),th5(i),th6(i));
    hold off;
    pause(.1);
    
end

%make the gripper hold it

%% from over ball to the ball
%pause;
pause(0.5);
thetas_start=thetas_ball;thetas_start=pumaAngles;
B=BallPosition;

x=B(1);y=B(2);z=B(3)+0.25;

thetas_ball=mod_puma_ik_NEW(x,y,z,-pi,-pi,0,0);
%clc;
clear change;
change=abs((thetas_ball-thetas_start)*180/pi);
changex=change;
indx=max(change(:))/4



if(change(1)==0)
    th1=zeros(1,floor(indx)+1);
else
    th1=thetas_start(1):(thetas_ball(1)-thetas_start(1))/indx:thetas_ball(1);
end

if(change(2)==0)
    th2=zeros(1,floor(indx)+1);
else
th2=thetas_start(2):(thetas_ball(2)-thetas_start(2))/indx:thetas_ball(2);
end

if(change(3)==0)
    th3=zeros(1,floor(indx)+1);
else

th3=thetas_start(3):(thetas_ball(3)-thetas_start(3))/indx:thetas_ball(3);
end
if(change(4)==0)
    th4=zeros(1,floor(indx)+1);
else

th4=thetas_start(4):(thetas_ball(4)-thetas_start(4))/indx:thetas_ball(4);
end

if(change(5)==0)
    th5=zeros(1,floor(indx)+1);
else

th5=thetas_start(5):(thetas_ball(5)-thetas_start(5))/indx:thetas_ball(5);

end

if(change(6)==0)
    th6=zeros(1,floor(indx)+1);
else

th6=thetas_start(6):(thetas_ball(6)-thetas_start(6))/indx:thetas_ball(6);
end

if sum(change(:))==0
run_len=0 ;% no change
else run_len=floor(indx)+1;
end

for i=1:run_len
    pumaServo(th1(i),th2(i),th3(i),th4(i),th5(i),th6(i));
    puma_viz_n(th1(i),th2(i),th3(i),th4(i),th5(i),th6(i));
    hold off;
    pause(.1);
    
end


pumaGripper('close')





%% from ball to hole(easy)

pause(0.5);
%thetas_start=thetas_ball; %replace with pumaAngles;
thetas_start=pumaAngles;

thetas_hole=mod_puma_ik_NEW(easy_hole(1),easy_hole(2),easy_hole(3)+2,-pi,-pi,0,0);

change=abs((thetas_hole-thetas_start)*180/pi);
indx=max(change(:))/4;

if(change(1)==0)
    th1=zeros(1,floor(indx)+1);
else
    th1=thetas_start(1):(thetas_hole(1)-thetas_start(1))/indx:thetas_hole(1);
end

if(change(2)==0)
    th2=zeros(1,floor(indx)+1);
else
th2=thetas_start(2):(thetas_hole(2)-thetas_start(2))/indx:thetas_hole(2);
end

if(change(3)==0)
    th3=zeros(1,floor(indx)+1);
else

th3=thetas_start(3):(thetas_hole(3)-thetas_start(3))/indx:thetas_hole(3);
end
if(change(4)==0)
    th4=zeros(1,floor(indx)+1);
else

th4=thetas_start(4):(thetas_hole(4)-thetas_start(4))/indx:thetas_hole(4);
end

if(change(5)==0)
    th5=zeros(1,floor(indx)+1);
else

th5=thetas_start(5):(thetas_hole(5)-thetas_start(5))/indx:thetas_hole(5);

end

if(change(6)==0)
    th6=zeros(1,floor(indx)+1);
else

th6=thetas_start(6):(thetas_hole(6)-thetas_start(6))/indx:thetas_hole(6);
end

if sum(change(:))==0
run_len=0; % no change
else run_len=floor(indx)+1;
end

for i=1:run_len
     pumaServo(th1(i),th2(i),th3(i),th4(i),th5(i),th6(i));
    puma_viz_n(th1(i),th2(i),th3(i),th4(i),th5(i),th6(i));
    
    hold off;
    pause(.05);
    
end
pause(1.5);
th_curr=pumaAngles;
th5=th_curr(5);
th5end=th5+40*pi/180;
thets=th5:3*pi/180:th5end;
j=length(thets);

for i=1:j
    pumaServo(th_curr(1),th_curr(2),th_curr(3),th_curr(4),thets(i),th_curr(6));
pause(0.025);
end

pumaGripper('open');


% %% from ball to hole easy
% % pause
% thetas_start=thetas_ball; %replace with pumaAngles;
% thetas_start=pumaAngles;
% 
% thetas_hole=mod_puma_ik_NEW(easy_hole(1),easy_hole(2),easy_hole(3)+3,-pi,-pi,0,0);
% 
% change=abs((thetas_hole-thetas_start)*180/pi);
% indx=max(change(:))/4.5;
% 
% if(change(1)==0)
%     th1=zeros(1,floor(indx)+1);
% else
%     th1=thetas_start(1):(thetas_hole(1)-thetas_start(1))/indx:thetas_hole(1);
% end
% 
% if(change(2)==0)
%     th2=zeros(1,floor(indx)+1);
% else
% th2=thetas_start(2):(thetas_hole(2)-thetas_start(2))/indx:thetas_hole(2);
% end
% 
% if(change(3)==0)
%     th3=zeros(1,floor(indx)+1);
% else
% 
% th3=thetas_start(3):(thetas_hole(3)-thetas_start(3))/indx:thetas_hole(3);
% end
% if(change(4)==0)
%     th4=zeros(1,floor(indx)+1);
% else
% 
% th4=thetas_start(4):(thetas_hole(4)-thetas_start(4))/indx:thetas_hole(4);
% end
% 
% if(change(5)==0)
%     th5=zeros(1,floor(indx)+1);
% else
% 
% th5=thetas_start(5):(thetas_hole(5)-thetas_start(5))/indx:thetas_hole(5);
% 
% end
% 
% if(change(6)==0)
%     th6=zeros(1,floor(indx)+1);
% else
% 
% th6=thetas_start(6):(thetas_hole(6)-thetas_start(6))/indx:thetas_hole(6);
% end
% 
% if sum(change(:))==0
% run_len=0; % no change
% else run_len=floor(indx)+1;
% end
% 
% for i=1:run_len
%     pumaServo(th1(i),th2(i),th3(i),th4(i),th5(i),th6(i));
%     hold off;
%     pause(.2);
%     
% end
% pumaGripper('open');
% 
%open gripper to drop the ball
