Robot=initOpen('/dev/ttyACM0','jack');

[l1 r1]=getEncoders(Robot)
encoderValues=[0 0;l1 r1];
v_l1=80;v_r1=80;

x=0;y=0;theta=0;
set_velocities(Robot,-v_l1,v_r1)
        
pause(1.25)
        
set_velocities(Robot,0,0);

[l2 r2]=getEncoders(Robot)
    encoderValues=[encoderValues(2,:);l2 r2]
    
    [x y theta]=getNextPosition(x,y,theta,encoderValues,0)

finalClose(Robot);