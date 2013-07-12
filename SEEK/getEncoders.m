function [L R] = getEncoders(Robot)

    [L R]=get_encoders(Robot);
    while(length(L)==0 || length(R)==0)
        [L R]=get_encoders(Robot);
    end


end
