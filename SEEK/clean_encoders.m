function [L, R] = clean_encoders(robot)

    [L, R] = get_encoders(robot);
    
    good_messages=2;
    
    while((isempty(L) || isempty(R)) || good_messages<2 )
        set_velocities(robot,0,0);
        if(isempty(L))
            disp('missing both');
            good_messages=0;
            pause(.1);
            [L, R] = get_encoders(robot);
        elseif(isempty(R))
            garbage = fscanf(robot,'%d');
            disp('missing right');
            good_messages=0;
            pause(.1);
            [L, R] = get_encoders(robot);
        else
            good_messages=good_messages+1
            [L, R] = get_encoders(robot);
        end
    end


    
        
