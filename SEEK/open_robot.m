%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% [ROBOT] = OPEN_ROBOT(PORT,NAME)
%
% takes: 
%   Windoz:  PORT = 'COM#'
%	Mac:	 PORT = '/dev/tty.usbmodem#' (to find this, run "ls /dev/tty.*" in terminal
%   PORT is the com-port number to which the dongle
%   NAME is the 
%   is connected.  
%
% returns: 
%   ROBOT is the serial-port ID.
% 
% version: 2.0
% date:    Nov. 4, 2009
% author:  J. Fiene
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [robot] = open_robot(port,name)

robot = serial(port,'BaudRate',9600);

names = {'beard';'belt';'berry';'board';'box';'diamond';'eye';'friday';'hole';'ice';'jack';'light';'magic';'mail';'market';'out';'sheep';'smith';'widow'};
address = find(strcmp(names,name));
if(size(address,1)==0)
    disp('Robot name not found');
else
    fopen(robot);

    address_string = num2str(address);
    if(size(address_string,2)==1) % handle non-double-digit gains
        address_string = ['0' address_string];
    end

    message = ['R' address_string]

    % send the message to the robot
    fprintf(robot, message);
end

