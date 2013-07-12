function [obsnew,reds,blues,greens]=get_obstcles(r1,rang1,r2,rang2,b1,bang1,b2,bang2,g1,gang1,g2,gang2,x,y,th)
% 
% r1=redDistBase0 
% rang1=redAngleBase0 
% r2=redDistFloating 
% rang2=redAngleFloating
% b1=[];
% bang1=[];
% b2=[];
% bang2=[];
% g1=[];
% gang1=[];
% g2=[];
% gang2=[];
% x=0;y=0;th=0;
obsnew=[];
reds=[];
blues=[];
greens=[];


rang1=rang1*pi/180;
rang2=rang2*pi/180;
bang1=bang1*pi/180;
bang2=bang2*pi/180;
gang1=gang1*pi/180;
gang2=gang2*pi/180;



if(~isempty(r1))
   red1x=x*cos(th)+r1.*cos(rang1).*cos(th-rang1);
   red1y=y*sin(th)+r1.*cos(rang1).*sin(th-rang1);
else
    red1x=[];
    red1y=[];
end

if(~isempty(r2))
   red2x=x*cos(th)+r2.*cos(rang2).*cos(th-rang2);
   red2y=y*sin(th)+r2.*cos(rang2).*sin(th-rang2);
   else
    red2x=[];
    red2y=[];

   
end

reds=[[red1x';red2x'] [red1y';red2y']];


if(~isempty(b1))
   blue1x=x*cos(th)+b1.*cos(bang1).*cos(th-bang1);
   blue1y=y*sin(th)+b1.*cos(bang1).*sin(th-bang1);
      else
    blue1x=[];
    blue1y=[];

end

if(~isempty(b2))
   blue2x=x*cos(th)+b2.*cos(bang2).*cos(th-bang2);
   blue2y=y*sin(th)+b2.*cos(bang2).*sin(th-bang2);
   else
    blue2x=[];
    blue2y=[];

      
end

blues=[[blue1x';blue2x'] [blue1y';blue2y']];

if(~isempty(g1))
   green1x=x*cos(th)+g1.*cos(gang1).*cos(th-gang1);
   green1y=y*sin(th)+g1.*cos(gang1).*sin(th-gang1);
      else
    green1x=[];
    green1y=[];

end

if(~isempty(g2))
   green2x=x*cos(th)+g2.*cos(gang2).*cos(th-gang2);
   green2y=y*sin(th)+g2.*cos(gang2).*sin(th-gang2);
   
      else
    green2x=[];
    green2y=[];
end


greens=[[green1x';green2x'] [green1y';green2y']];

obsnew=[reds;blues;greens];


