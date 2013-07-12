clear all;
clc;

% filename='42r.jpg';
filename='trial.jpg';
I=imread(filename);

[redStats greenStats blueStats]=getStats(I);
% if(~isempty(redStats))
%     [redDistBase0 redAngleBase0 redDistFloating redAngleFloating]=getInf(redStats,1)
% end
if(~isempty(greenStats))
    [greenDistBase0 greenAngleBase0 greenDistFloating greenAngleFloating]=getInf(greenStats,2)
end
if(~isempty(blueStats))
    [blueDistBase0 blueAngleBase0 blueDistFloating blueAngleFloating]=getInf(blueStats,3)
end
% dangerZone=[[redXBase0 redYBase0];[redXFloating redYFloating];[greenXBase0 greenYBase0];[greenXFloating greenYFloating];[blueXBase0 blueYBase0];[blueXFloating blueYFloating]]