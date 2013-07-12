function [x y th_ref]=goAngle(Robot,theta,initX,initY,th_ref)
v_l1=80;
v_r1=80;
[l1 r1]=getEncoders(Robot);
encoderValues=[0 0;l1 r1];
x=initX;
y=initY;
flag=0;
while(flag==0)
    
    err=theta-th_ref
    
    
    [l2 r2]=getEncoders(Robot);%clean_encoders(Robot);
    encoderValues=[encoderValues(2,:);l2 r2];
    [x y th_ref]=getNextPosition(x,y,th_ref,encoderValues,0)
    
    if(abs(err)<2*pi/180)
        %          set_velocities(Robot,v_l,v_r);
        set_velocities(Robot,0,0);
        set_velocities(Robot,0,0);
        flag=1;
        'tolerable'
        th_ref
        theta
        flag==1
        %         end
        
    elseif(err>0 && flag~=1)
        %set_velocities(Robot,v_l-(e*180/pi)*k_vel,v_r);
        set_velocities(Robot,-v_l1,v_r1);
    elseif(err<0 && flag~=1)
        %set_velocities(Robot,v_l,v_r-(e*180/pi)*k_vel);
        set_velocities(Robot,v_l1,-v_r1);
    end
end







end
