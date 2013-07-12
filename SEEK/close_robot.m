%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% CLOSE_ROBOT(ROBOT)
%
% takes: 
%   ROBOT is the serial-port ID from OPEN_ROBOT.
% 
% version: 1.0
% date:    Oct. 30, 2008
% author:  J. Fiene
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function close_robot(robot)

fclose(robot);
