%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% SET_VELOCITIES(ROBOT,L,R)
%
% takes:
%   ROBOT is the serial-port ID from OPEN_ROBOT.
%
%   L and R are integer values between -999 and 999
%   where negative numbers represent motor reverse.
% 
% version: 1.0
% date:    Oct. 30, 2008
% author:  J. Fiene
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function set_velocities(robot,l,r)

% LEFT
ldir = 1; % assume forward
if(l<0)
    ldir = 0; % reverse
end
lmag = floor(abs(l)); % round-off
if(lmag>999) % check maximum magnitude
    lmag = 999;
    disp('WARNING: left-wheel magnitude truncated to 999')
end
lmag_string = num2str(lmag);
if(size(lmag_string,2)==2)
    lmag_string = ['0' lmag_string];
elseif(size(lmag_string,2)==1)
    lmag_string = ['00' lmag_string];
end

% RIGHT
rdir = 0; % assume forward
if(r<0)
    rdir = 1; % reverse
end
rmag = floor(abs(r)); % round-off
if(rmag>999) % check maximum magnitude
    rmag = 999;
    disp('WARNING: right-wheel magnitude truncated to 999')
end
rmag_string = num2str(rmag);
if(size(rmag_string,2)==2)
    rmag_string = ['0' rmag_string];
elseif(size(rmag_string,2)==1)
    rmag_string = ['00' rmag_string];
end

% form the velocity message

message = ['S' num2str(ldir) lmag_string num2str(rdir) rmag_string];

% send the message to the robot

fprintf(robot,message);
fprintf(robot,message);
fprintf(robot,message);