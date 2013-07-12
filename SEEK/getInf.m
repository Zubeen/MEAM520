function [distBase0 angleBase0 distFloating angleFloating] = getInf(stats,colour)
xyBase0=[];xyFloating=[];
num=length(stats);
CenterBase0=[];distBase0=[];angleBase0=[];CenterFloating=[];distFloating=[];angleFloating=[];
HeightsBase0=[];WidthsBase0=[];CentersBase0=[];
HeightsFloating=[];WidthsFloating=[];CentersFloating=[];

j=0;k=0;
for i=1:num
%     max(stats(i).PixelList(:,2))
    if(max(stats(i).PixelList(:,2))==240)
        j=j+1;
        HeightsBase0(j) = max(stats(i).PixelList(:,2)) - min(stats(i).PixelList(:,2));
        WidthsBase0(j) = max(stats(i).PixelList(:,1)) - min(stats(i).PixelList(:,1));
        CentersBase0(j,:)=stats(i).Centroid;
    else
        k=k+1;
        HeightsFloating(k) = max(stats(i).PixelList(:,2)) - min(stats(i).PixelList(:,2));
        WidthsFloating(k) = max(stats(i).PixelList(:,1)) - min(stats(i).PixelList(:,1));
        CentersFloating(k,:)=stats(i).Centroid;
    end
end
if(j>0)
    [sortedHeightsBase0,indBase0]=sort(HeightsBase0(1:j),'descend') %sort heights
    validBase0=0;
    for i=1:j
        if(isValid(sortedHeightsBase0(i),WidthsBase0(indBase0(i)),colour)==1)
%         if(aspectRatio<=0.3 && aspectRatio>=0.1)
            validBase0=validBase0+1;
            Area=WidthsBase0(indBase0(i))*sortedHeightsBase0(i);
            d=getDist(Area,colour);
            if(d~=-1)
                distBase0(validBase0)=d;
                CenterBase0(validBase0,:)=CentersBase0(indBase0(i),:);
                figure(colour);
                hold on;
                plot(CenterBase0(validBase0,1),CenterBase0(validBase0,2),'y*');
                angleBase0(validBase0)=getAngle(CenterBase0(validBase0,1));
            end
%             xBase0=yBase0 * tand(AngleBase0);
%             xyBase0(validBase0,:)=[xBase0 yBase0];
        end
    end 
end

if(k>0)
    [sortedHeightsFloating,indFloating]=sort(HeightsFloating(1:k),'descend'); %sort heights
    validFloating=0;
    for i=1:k
        if(1==isValid(sortedHeightsFloating(i),WidthsFloating(indFloating(i)),colour))
            validFloating=validFloating+1;
            Area=WidthsFloating(indFloating(i))*sortedHeightsFloating(i);
            d=getDist(Area,colour);
            if(d~=-1)
                distFloating(validFloating)=d;
                CenterFloating(validFloating,:)=CentersFloating(indFloating(i),:);
                figure(colour);
                hold on;
                plot(CenterFloating(validFloating,1),CenterFloating(validFloating,2),'y*');
                angleFloating(validFloating)=getAngle(CenterFloating(validFloating,1));
    %             xFloating=yFloating*tand(AngleFloating);
    %             xyFloating(validFloating,:)=[xFloating yFloating];
            end
        end
    end
end

end