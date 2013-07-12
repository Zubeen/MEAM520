function [distance]=getDist(area,colour)

% area=area;
distance=-1;
if(colour==1)%red
    Area_17o5 = 195*73;
    Area_20 = 207*57;
    Area_25 = 201*62;
    Area_30 = 188*66;
    Area_35 = 171*37;
    Area_40 = 147*28;
    Area_50 = 116*22;
    Area_60 = 94*16;
    Area_70 = 79*14;
    Area_80 = 68*11;
    Area_90 = 59*9;
    Area_100 = 54*8;
    
    
    if(area<200*80 && area >=Area_35)
        D1=sqrt(Area_17o5/area)*17.5;
        D2=sqrt(Area_20/area)*20;
        D3=sqrt(Area_25/area)*25;
        D4=sqrt(Area_30/area)*30;
        D5=sqrt(Area_35/area)*35;
        distance = (D1 + D2 + D3 + D4 + D5)/5;
    end
    
elseif(colour==2)%green
    Area_25 = 229*172;
    Area_30 = 210*138;
    Area_35 = 183*116;
    Area_40 = 160*88;
    Area_50 = 124*74;
    Area_60 = 105*59;
    Area_70 = 84*51;
    Area_80 = 75*48;
    Area_90 = 66*41;
    Area_100 = 58*36;
    
    if(area<230*180 && area >=Area_35)
        D3=sqrt(Area_25/area)*25;
        D4=sqrt(Area_30/area)*30;
        D5=sqrt(Area_35/area)*35;
        distance = (D3 + D4 +D5 )/2;
    end
    
else%blue
    Area_25 = 229*173;
    Area_30 = 215*147;
    Area_35 = 191*125;
    Area_40 = 166*109;
    Area_50 = 133*89;
    Area_60 = 107*73;
    Area_70 = 88*59;
    Area_80 = 77*52;
    Area_90 = 68*46;
    Area_100 = 60*41;
    if(area<230*180 && area >=Area_35)
        D3=sqrt(Area_25/area)*25;
        D4=sqrt(Area_30/area)*30;
        D5=sqrt(Area_35/area)*35;
        distance = (D3 + D4 +D5 )/2;
    end
end

if(area<Area_35 && area >=Area_60)
    D1=sqrt(Area_40/area)*40;
    D2=sqrt(Area_50/area)*50;
    D3=sqrt(Area_60/area)*60;
    distance = (D1 + D2 + D3)/3;
elseif(area<Area_60 && area >=Area_100)
    D1=sqrt(Area_70/area)*70;
    D2=sqrt(Area_80/area)*80;
    D3=sqrt(Area_90/area)*90;
    D4=sqrt(Area_100/area)*100;
    distance = (D1 + D2 + D3 + D4)/4;
end
distance
end