function [x y theta]=goDist(Robot,dist,initX,initY,th_ref)
[l1 r1]=getEncoders(Robot);
encoderValues=[0 0;l1 r1];
x=initX;
y=initY;
v_l=80;
v_r=80;
k_vel=1;
covered=0;
set_velocities(Robot,v_l,v_r);
while(covered<dist)
    [l2 r2]=getEncoders(Robot);%clean_encoders(Robot);
    encoderValues=[encoderValues(2,:);l2 r2];
    [x y theta]=getNextPosition(x,y,th_ref,encoderValues,0);
    covered=sqrt((x-initX)^2+(y-initY)^2)
    err=th_ref-theta;%e(i)=err;
    if(err<0)
        set_velocities(Robot,v_l,v_r-abs(err*180/pi)*k_vel);
        %                 '1'
    elseif(err>0)
        %                 '2'
        set_velocities(Robot,v_l-abs(err*180/pi)*k_vel,v_r);
    elseif(err==0)
        %                 '3'
        
        set_velocities(Robot,v_l,v_r);
    end
end
set_velocities(Robot,0,0);
end
