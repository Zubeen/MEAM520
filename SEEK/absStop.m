function absStop(Robot)
    
    while(1)
        set_velocities(Robot,0,0);
        [l1 r1] = getEncoders(Robot);
        pause(1);
        [l2 r2] = getEncoders(Robot);
        if(l2-l1==0 && r2-r1==0)
            break;
        end
    end
    
end