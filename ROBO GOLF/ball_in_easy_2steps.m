function []=ball_in_easy_2steps(BallPosition,easy_hole)

%% from start, to the ball;
thetas_start=[0 0 0 0 0 0];
%actually make it pumaAngles;

B=BallPosition;

x=B(1);y=B(2);z=B(3); % get it  over ball

thetas_ball=mod_puma_ik_NEW(x,y,z,-pi,-pi,0,0);

change=abs((thetas_ball-thetas_start)*180/pi);
indx=max(change(:))/4.5;



th1=thetas_start(1):(thetas_ball(1)-thetas_start(1))/indx:thetas_ball(1);
th2=thetas_start(2):(thetas_ball(2)-thetas_start(2))/indx:thetas_ball(2);
th3=thetas_start(3):(thetas_ball(3)-thetas_start(3))/indx:thetas_ball(3);
th4=thetas_start(4):(thetas_ball(4)-thetas_start(4))/indx:thetas_ball(4);
th5=thetas_start(5):(thetas_ball(5)-thetas_start(5))/indx:thetas_ball(5);
th6=thetas_start(6):(thetas_ball(6)-thetas_start(6))/indx:thetas_ball(6);


run_len=length(th1);

for i=1:run_len
    puma_viz_n(th1(i),th2(i),th3(i),th4(i),th5(i),th6(i));
    hold off;
    pause(.5);
    
end

%make the gripper hold it












%% from ball to hole easy
pause
thetas_start=thetas_ball; %replace with pumaAngles;

thetas_hole=mod_puma_ik_NEW(easy_hole(1),easy_hole(2),easy_hole(3)+1,-pi,-pi,0,0);

change=abs((thetas_hole-thetas_start)*180/pi);
indx=max(change(:))/4.5;

th1=thetas_start(1):(thetas_hole(1)-thetas_start(1))/indx:thetas_hole(1);
th2=thetas_start(2):(thetas_hole(2)-thetas_start(2))/indx:thetas_hole(2);
th3=thetas_start(3):(thetas_hole(3)-thetas_start(3))/indx:thetas_hole(3);
th4=thetas_start(4):(thetas_hole(4)-thetas_start(4))/indx:thetas_hole(4);
th5=thetas_start(5):(thetas_hole(5)-thetas_start(5))/indx:thetas_hole(5);
th6=thetas_start(6):(thetas_hole(6)-thetas_start(6))/indx:thetas_hole(6);

run_len=length(th1);

for i=1:run_len
    puma_viz_n(th1(i),th2(i),th3(i),th4(i),th5(i),th6(i));
    hold off;
    pause(.5);
    
end

%open gripper to drop the ball
