clear all
clc
close all;

%% Initialize Robot and clean encoder junk
Robot=initOpen('/dev/ttyACM0','jack');
% Robot=initOpen('COM3','smith');
for i=1:20
   [junk junkie]=getEncoders(Robot);%clean_encoders(Robot); 
   pause(0.1);
end

'Robot Initialized, Junk Cleaned'

%% Initialize Variables
redDistBase0=[];redAngleBase0=[];
redDistFloating=[];redAngleFloating=[];
greenDistBase0=[];greenAngleBase0=[];
greenDistFloating=[];greenAngleFloating=[];
blueDistBase0=[];blueAngleBase0=[];
blueDistFloating=[];blueAngleFloating=[];


x=0;y=0;theta=pi/4;
t=theta;
[l1 r1]=getEncoders(Robot);%clean_encoders(Robot);
[l1 r1]=getEncoders(Robot);%clean_encoders(Robot);
encoderValues=[0 0;l1 r1];

i=0;
flag=0;

x_ref=0; 
y_ref=0;
th_ref=atan2(y_ref-y,x_ref-x);
distn=sqrt((x_ref-x)^2+(y_ref-y)^2);


v_l1=80;
v_r1=80;
v_l=80;
v_r=80;
k_vel=1;
k_vel1=0.1;

%% mesh work


xpts=[0:20:200];
ypts=[0:20:200];


for p=1:length(xpts) %make a Nx2 matrix of centrs
    
    pointcentrsx(:,p)=[xpts(p)*ones(1,length(ypts))];
    pointcentrsy(p,:)=[ypts(p)*ones(1,length(ypts))];
    
end

pointcentrs=[pointcentrsx(:) pointcentrsy(:)];

current=[x y];
% obs_x=[50 10 56 400 50  50 56 ]; %obstcle pos
% obs_y=[20 40 89 1000 20 20 89];
% obstcles=[50 20;10 40;56 89;40 500;50 20;56 89];
% obstcles=[20 20;52 52];
obstcles=[];
prev_list=[];nex_list=[];

%% Loop until 4 targets are found
count=0;
while(1)
    
    count=count+1
    obsnew=[];
    
    
    
     if(i>0)
         %on coming to a point
       set_velocities(Robot,0,0);
     %   'came here' 
        xx(i);
        yy(i);       
        x=xx(i);
        y=yy(i);
        t=th(i);
        flag=0;
     end
     

     
     
     filename='http://localhost:8888/image.jpg';
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
[obsnew,r,b,g]=get_obstcles(redDistBase0, redAngleBase0 ,redDistFloating, redAngleFloating,blueDistBase0 ,blueAngleBase0, blueDistFloating, blueAngleFloating,greenDistBase0, greenAngleBase0, greenDistFloating, greenAngleFloating,x,y,t)

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
          
    if(count==1)
        current=[x+1 y+1];%jugaad ignore
        prev=current;
        prev_list(count,:)=prev;
        current(count,:)=prev;       
    else
        current(count,:)=[x y];
        prev=current(count-1,:);
        prev_list(count,:)=prev;
        current(count,:)=nex;
        nex;
        % always remember to remove previously noticed obstcles
    end
    
    [nex pointcentrsvalid ]=get_next_valid(xpts,ypts,pointcentrs,obstcles,current(count,:),prev,prev_list);
%     'got,showed?'
    pause(0.01);
    pointcentrs=pointcentrsvalid;
    nex_list(count,:)=nex;
    
%     obstcles=[obstcles ;obsnew];
    
    x_ref=nex(1);
    y_ref=nex(2);
    
%     x_ref
%     y_ref
%     x
%     y
    %     pause;
    distn=sqrt((x_ref-x)^2+(y_ref-y)^2);
    th_ref=atan2(y_ref-y,x_ref-x);
    
    th_ref*180/pi;
    refs(count)=th_ref*180/pi;
%     pause;
    x0=x;
    y0=y;
    
    d0max=sqrt((x_ref-x)^2+(y_ref-y)^2); %dist from the start of iteration point to end of next point
    dist_orig=0;
    
    while(distn>5 && dist_orig<=d0max)%&& (count~=1)*abs(x_ref-x)>1 && (count~=1)*abs(y_ref-y)>1)
        i=i+1;
                'here?'
        %[l2 r2]=clean_encoders(Robot)
        %     encoderValues=[encoderValues(2,:);l2 r2];
        [l2 r2]=getEncoders(Robot);%clean_encoders(Robot);
        encoderValues=[encoderValues(2,:);l2 r2];
        
        [x y theta]=getNextPosition(x,y,theta,encoderValues,0);
        
        dist_orig=sqrt((x0-x)^2+(y0-y)^2);
        hold on
        plot(x,y,'y*');xx(i)=x;yy(i)=y;th(i)=theta;
        hold on
        pause(0.01)
        distn=sqrt((x_ref-x)^2+(y_ref-y)^2);
        dd(i)=distn;
        
        err=th_ref-theta;e(i)=err;
        
        
            if(abs(err)<2*pi/180 && flag==0)
            %          set_velocities(Robot,v_l,v_r);
            set_velocities(Robot,0,0);
            set_velocities(Robot,0,0);
            flag=1;
                        'tolerable'      
                        th_ref
                        theta
%         end
        
            elseif(err>0 && flag==0)
            %set_velocities(Robot,v_l-(e*180/pi)*k_vel,v_r);
            set_velocities(Robot,-v_l1,v_r1);
        elseif(err<0 && flag==0)
            %set_velocities(Robot,v_l,v_r-(e*180/pi)*k_vel);
            set_velocities(Robot,v_l1,-v_r1);
            end
        
            
    
            
        if(flag==1)
            
            if(err<0)
                set_velocities(Robot,v_l,v_r-abs(err*180/pi)*k_vel);
                %                 '1'
            elseif(err>0)
                %                 '2'
                set_velocities(Robot,v_l-abs(err*180/pi)*k_vel,v_r);
            elseif(err==0)
                %                 '3'
                
                set_velocities(Robot,v_l,v_r);
            end
            
            
        end
        
        
        hold on;
        %pause(1);
        axis equal;
    end
    
end
set_velocities(Robot,0,0);
finalClose(Robot);




