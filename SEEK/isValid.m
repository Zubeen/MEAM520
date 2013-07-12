function [flag] = isValid(height, width, colour)
flag=-1;
if(colour==1)
    aspectL=0.1;
    aspectU=0.5;
%     if(height>200)
%         aspectU=0.4;
%     else
%         aspectU=0.33;
%     end
    
    areaTh=51*9;
elseif(colour==2)
    aspectL=0.4;
    aspectU=0.9;
    areaTh= 58*52;
elseif(colour==3)
    aspectL=0.6;
    aspectU=0.8;
    areaTh= 58*52;
end

if(width/height >=aspectL && width/height<=aspectU && (width*height)>=areaTh)
    flag=1;
else
%     height
%     width
%     colour
%      'here'
    flag=0;
end
    
end