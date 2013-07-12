%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% SET_GAINS(ROBOT,P,I,D,F)
%
% takes:
%   ROBOT is the serial-port ID from OPEN_ROBOT.
%   P is the proportional gain (0.0 to 99.9)
%   I is the integral gain (0.0 to 99.9)
%   D is the derivative gain (0.0 to 99.9)
%   F is the feedforward gain (0.0 to 99.9)
% 
%            |------------------(F)--------------|
%            |                                   |
%            |            |---------(P)--------| |
%            |            |                    | |
% desired ---|---[diff]---|----(de/dt)--(D)---[sum]--- to motor
% velocity         |      |                     |
%                  |      |---(int(edt)---(I)---|                  
%                  |        
%                  |------------------------ sensed velocity
%
% version: 1.0
% date:    Oct. 30, 2008
% author:  JPF
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function set_gains(robot,P,I,D,F)

% proportional term:
if(P<0)
    P = 0;
end
if(P>99.9)
    P = 99.9;
end
P_string = num2str(P,'%2.1f');
if(size(P_string,2)==3) % handle non-double-digit gains
    P_string = ['0' P_string];
end

% derivative term:
if(D<0)
    D = 0;
end
if(D>99.9)
    D = 99.9;
end
D_string = num2str(D,'%2.1f');
if(size(D_string,2)==3) % handle non-double-digit gains
    D_string = ['0' D_string];
end

% integral term:
if(I<0)
    I = 0;
end
if(I>99.9)
    I = 99.9;
end
I_string = num2str(I,'%2.1f');
if(size(I_string,2)==3) % handle non-double-digit gains
    I_string = ['0' I_string];
end

% feedforward term:
if(F<0)
    F = 0;
end
if(F>99.9)
    F = 99.9;
end
F_string = num2str(F,'%2.1f');
if(size(F_string,2)==3) % handle non-double-digit gains
    F_string = ['0' F_string];
end

% for the gain message
message = ['G' P_string D_string I_string F_string];

% send the message to the robot
fprintf(robot,message);