function [obstcles r]=analyzeThat(filename,x,y,theta,obstcles)

redDistBase0=[];redAngleBase0=[];
redDistFloating=[];redAngleFloating=[];
greenDistBase0=[];greenAngleBase0=[];
greenDistFloating=[];greenAngleFloating=[];
blueDistBase0=[];blueAngleBase0=[];
blueDistFloating=[];blueAngleFloating=[];
obsnew=[];r=[];g=[];b=[];

pause(0.5);
I=imread(filename);
[redStats greenStats blueStats]=getStats(I);
if(~isempty(redStats))
    [redDistBase0 redAngleBase0 redDistFloating redAngleFloating]=getInf(redStats,1)
end
if(~isempty(greenStats))
    [greenDistBase0 greenAngleBase0 greenDistFloating greenAngleFloating]=getInf(greenStats,2)
end
if(~isempty(blueStats))
    [blueDistBase0 blueAngleBase0 blueDistFloating blueAngleFloating]=getInf(blueStats,3)
end

%     obsnew=[redXYBase0;redXYFloating;greenXYBase0;greenXYFloating;blueXYBase0;blueXYFloating];
[obsnew,r,b,g]=get_obstcles(redDistBase0, redAngleBase0 ,redDistFloating, redAngleFloating,blueDistBase0 ,blueAngleBase0, blueDistFloating, blueAngleFloating,greenDistBase0, greenAngleBase0, greenDistFloating, greenAngleFloating,x,y,theta)
'is at'
x
y
theta*180/pi
if(~isempty(obstcles))
%     obsnew=check_crap(obstcles,obsnew)
end
obstcles=[obstcles ; obsnew];
figure(5);
if(~isempty(r))
    hold on;
    
    plot(r(:,1),r(:,2),'ro');
    hold on;
end

if(~isempty(b))
    hold on;
    plot(b(:,1),b(:,2),'bo');
    hold on;
end

if(~isempty(g))
    hold on;
    plot(g(:,1),g(:,2),'go');
    hold on;
end
end