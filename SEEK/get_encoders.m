%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% GET_ENCODERS(ROBOT)
%
% takes:
%   ROBOT is the serial-port ID from OPEN_ROBOT.
%
% returns:
%   [L,R] is a 2 element vector with the absolute encoder reading
%
% version: 1.0
% date:    Apr 6, 2011
% author:  J. Fiene
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [L,R] = get_encoders(robot)

% request the encoder values
message = ['E'];

% send the message to the robot

L=[];
R=[];

fprintf(robot,message);

for(i=1:2)
    string = fscanf(robot);
    if(string(1) == 'L')
        L = -str2num(string(2:end));
    elseif(string(1) == 'R')
        R = str2num(string(2:end));
    end    
end