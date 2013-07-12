clear all
clc
close all;

%% Initialize Robot and clean encoder junk
filename='http://localhost:8888/image.jpg';
Robot=initOpen('/dev/ttyACM0','jack');

targs=[];
% Robot=initOpen('COM3','smith');
for i=1:20
    [junk junkie]=getEncoders(Robot);%clean_encoders(Robot);
    pause(0.1);
end

'Robot Initialized, Junk Cleaned'

%% Initialize Variables
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


xpts=[25:20:225];
ypts=[25:20:225];


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

%% Move to Grid Origin


% % %% Left Snap, Right Snap, Center Snap
% set_velocities(Robot,v_l1,-v_r1)
%         pause(1.25)
% %         tr=0;
%         set_velocities(Robot,0,0);
%         [obstcles target]=analyzeThat(filename,x,y,0,obstcles);    
%         targs=[targs ;target];
%         set_velocities(Robot,-v_l1,v_r1)
%         pause(1.25)
%         set_velocities(Robot,0,0)
% %         tl=pi/2;
%         [obstcles target]=analyzeThat(filename,x,y,pi/2,obstcles);
%         targs=[targs; target];
%         
%         set_velocities(Robot,-v_l1,v_r1)
%         pause(1.25)
%         set_velocities(Robot,0,0)
% %         t0=pi/4;
%         [obstcles target]=analyzeThat(filename,x,y,pi/4,obstcles);
%         targs=[targs; target];
%         set_velocities(Robot,v_l1,-v_r1)
%         pause(1.25)
%         set_velocities(Robot,0,0);
    
    
    
%% Loop until 4 targets are found
count=0;
while(1)
     
    count=count+1
    obsnew=[];
    
    
    
    if(i>0)
        %on coming to a point
%         set_velocities(Robot,0,0);
        %   'came here'
        xx(i);
        yy(i);
        x=xx(i);
        y=yy(i);
        t=th(i);
        flag=0;
    end     
   if(i>1 && x<26 && y<26)
       % %% Left Snap, Right Snap, Center Snap
set_velocities(Robot,v_l1,-v_r1)
        pause(1.25)
%         tr=0;
        set_velocities(Robot,0,0);
        [obstcles target]=analyzeThat(filename,x,y,0,obstcles);    
        targs=[targs ;target];
        set_velocities(Robot,-v_l1,v_r1)
        pause(1.25)
        set_velocities(Robot,0,0)
%         tl=pi/2;
        [obstcles target]=analyzeThat(filename,x,y,pi/2,obstcles);
        targs=[targs; target];
        
        set_velocities(Robot,-v_l1,v_r1)
        pause(1.25)
        set_velocities(Robot,0,0)
%         t0=pi/4;
        [obstcles target]=analyzeThat(filename,x,y,pi/4,obstcles);
        targs=[targs; target];
        set_velocities(Robot,v_l1,-v_r1)
        pause(1.25)
        set_velocities(Robot,0,0);

       
       
       
   end
        
    
    [obstcles,target]=analyzeThat(filename,x,y,t,obstcles);
    
    targs=[targs;target];
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
    dist_orig=0;ext=0;
    
    while(distn>5 && dist_orig<=d0max && ext==0)%&& (count~=1)*abs(x_ref-x)>1 && (count~=1)*abs(y_ref-y)>1)
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
            [obstcles,target]=analyzeThat(filename,x,y,theta,obstcles);
                targs=[targs; target];
                if(~isempty(obsnew))
                    distimmediate=sqrt((x-obsnew(:,1)).^2 + (y-obsnew(:,2)).^2);
                    [vls inds]=sort(distimmediate,'ascend');
                    if(vls(inds(1))<d0max)
                        vls(inds(1))
                        d0max
%                         pause;
                        ext=1;break;
                    else
                        'no obstacles in way'
                        flag=2;
                    end
                else
                    flag=2;obsnew=[];
                end              
%                 pause;
            end
            
            
            
            if(flag==2)
                
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
%         nT=numTargets(targs);
        
    end
    set_velocities(Robot,0,0);
    finalClose(Robot);
    
    
    
    
