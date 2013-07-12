%% Starting point
p=0;
q=0;
v_l1=80;v_r1=80;
obstcles=[];
%%
tempD=sqrt((25-p)^2+(25-q)^2);
[x y theta]=goDist(Robot,tempD,p,q,pi/4);

%% Left Snap, Right Snap, Center Snap
[x y theta]=goAngle(Robot,pi/2,x,y,theta);
obstcles=analyzeThat(filename,x,y,theta,obstcles);   
[x y theta]=goAngle(Robot,0,x,y,theta);
obstcles=analyzeThat(filename,x,y,theta,obstcles);
[x y theta]=goAngle(Robot,pi/4,x,y,theta);
obstcles=analyzeThat(filename,x,y,theta,obstcles)


%% 
[x y theta]=goDist(Robot,70,x,y,theta);
set_velocities(Robot,0,0);

%% Left Snap, Right Snap, Center Snap
[x y theta]=goAngle(Robot,pi/2,x,y,theta);
obstcles=analyzeThat(filename,x,y,theta,obstcles);   
[x y theta]=goAngle(Robot,0,x,y,theta);
obstcles=analyzeThat(filename,x,y,theta,obstcles);
[x y theta]=goAngle(Robot,pi/4,x,y,theta);
obstcles=analyzeThat(filename,x,y,theta,obstcles)

