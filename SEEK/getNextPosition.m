function [x2 y2 theta2] = getNextPosition(x1, y1, theta1, encoderValues, tau)%phiL1, phiR1, phiL2, phiR2, tau)

% r= 4.5;
% l= 10.5;

r= 4.5;
l= 14.0;
countsperRev=564;%518.36;%33.9;

A=(r/2)*cos(theta1);
B=(r/2)*sin(theta1);
C=(r/l);

deltaL=encoderValues(2,1)-encoderValues(1,1);
deltaR=encoderValues(2,2)-encoderValues(1,2);
phiL=(deltaL/countsperRev)*2*pi;
phiR=(deltaR/countsperRev)*2*pi;
    
x2=x1+ A*(phiL) + A*(phiR);
y2=y1+ B*(phiL) + B*(phiR);
theta2=theta1- C*(phiL) + C*(phiR);


end