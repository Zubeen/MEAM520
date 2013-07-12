%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% [] = SET_ROBOT(NAME)
%
% takes: 
%   NAME is the name of the robot to connect to
%   is connected.  
%
% version: 1.0
% date:    Nov. 11, 2009
% author:  J. Fiene
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [] = change_robot(name)

names = {'beard';'belt';'berry';'board';'box';'diamond';'eye';'friday';'hole';'ice';'jack';'light';'magic';'mail';'market';'out';'sheep';'smith';'widow'};
address = find(strcmp(names,name));
if(size(address,1)==0)
    disp('Robot name not found');
else
    address_string = num2str(address);
    if(size(address_string,2)==1) % handle non-double-digit gains
        address_string = ['0' address_string];
    end

    message = ['R' address_string];

    % send the message to the robot
    fprintf(robot, message);
end
