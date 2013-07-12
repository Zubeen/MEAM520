function[nex,pointcentrsvalid]= get_next_valid(x,y,pointcentrs,obstcles,current,prev,prev_list)

size_grid=20;dif=10;
%  x=[0:50:100];
%  y=[0:50:100];
% 
% for p=1:length(x) %make a Nx2 matrix of centrs
% 
% pointcentrsx(:,p)=[x(p)*ones(1,length(y))];
% pointcentrsy(p,:)=[y(p)*ones(1,length(y))];
% 
% end
% 
% pointcentrs=[pointcentrsx(:) pointcentrsy(:)];

 x_centrs=x;
 y_centrs=y;

 flag=0;

inval=[];
x_current=current(1);y_current=current(2); %current pos

pointcentrsvalid=pointcentrs;

if(~isempty(obstcles))
obs_x=obstcles(:,1);%[50 10 56 40]; %obstcle pos
obs_y=obstcles(:,2);%[20 40 89 100];


%check where the obstacles lie and make centrs invalid

for j=1:length(obs_x)

vec1=obs_x(j)>=x_centrs-dif;
vec2=obs_x(j)<=x_centrs+size_grid/2;

invx=vec1&vec2;

[v,i]=sort(invx,'descend');

invalx(j)=x_centrs(i(1));

vec3=(obs_y(j)>=y_centrs-dif);
vec4=(obs_y(j)<y_centrs+size_grid/2);

invy=vec3&vec4;

[v,i]=sort(invy,'descend');

invaly(j)=y_centrs(i(1));

inval(j,1:2)=[invalx(j) invaly(j)];

%inval=inval';
end

inval=unique(inval,'rows');

te=size(inval);
t=size(pointcentrs);a=0;

pointcentrsvalid=pointcentrs; %the valid centrs
%make a shortened N-m x 2 for valid centrs where m are now invalid

store_val=0;a=0;shift_dwn=0;

%smartly reduce the size of the N-m x 2, make sure to keep indexing
%correct
% for i=1:t(1)
%    for j=1:te(1)%length(invaly)
%        if(sum(pointcentrs(i,:)==inval(j,:))==2)
%            if(a==0)
%            pointcentrsvalid(i,:)=[];a=a+1;store_val(a)=i;prevs=i;
%            else
%                if(prevs>i && a~=0)
%                pointcentrsvalid(i,:)=[];a=a+1;store_val(a)=i;
%                else
%                    n=sum(store_val(:)<i);
%                   if(n-i>0)
%                    pointcentrsvalid(i-n,:)=[];a=a+1;store_val(a)=i-n;
%                   else
%                       'could not'
%                       inval(j,:)
%                   end
%                end
%            end
%        end
%        
%    end

for i=1:t(1)
   for j=1:te(1)%length(invaly)
       if(sum(pointcentrs(i,:)==inval(j,:))==2)
           if(a==0)
           pointcentrsvalid(i,:)=[];a=a+1;store_val(a)=i;prevs=i;
           else
               if(prevs>i && a~=0)
               pointcentrsvalid(i,:)=[];a=a+1;store_val(a)=i;
               else
                  
                   n=sum(store_val(:)<i);
                    if(n-i~=0)
                   pointcentrsvalid(i-n,:)=[];a=a+1;store_val(a)=i-n;
                    else
                        'cudnt'
                    end
               
               end
           end
       end
       
   end

  
end

end
%find distances of all valid centrs from the current point
d=((x_current-pointcentrsvalid(:,1)).^2+(y_current-pointcentrsvalid(:,2)).^2);
[val,ind]=sort(d);
sel=0;
%next point to go is the closest valid point
if(val(1)~=0)
nex=pointcentrsvalid(ind(1),:);sel=1;
else
    nex=pointcentrsvalid(ind(2),:);sel=2;
end

if(val(sel)==val(sel+1))
    sel=sel+( uint8(random('unif',1,2,1))-1);
    nex=pointcentrsvalid(ind(sel),:);
end


if(nex==prev)
    nex=pointcentrsvalid(ind(sel+1),:);
end

l=size(prev_list);

for j=1:l(1)
    if(sum(nex==prev_list(j,:))==2)
        sel=sel+1;
        nex=pointcentrsvalid(ind(sel),:);
    end
end

l1=size(obstcles);
for j=1:l1(1)
    if(sum(nex==obstcles(j,:))==2)
        sel=sel+1;
        nex=pointcentrsvalid(ind(sel),:);
    end
end

if(sel>9)
    nex=pointcentrsvalid(ind(sel-1),:);
end

if(~isempty(inval))
l=size(inval);
p=size(current);
 invs=[inval 1*ones(l(1),1)];


 curr=[current(p(1),:) 1];
 nexx=[nex 1];
 crs=cross(curr,nexx);
 for i=1:l(1)
     
    dt= dot(crs,invs(i,:));
 if(dt==0)
     %curr 
    % nex
    dos= sqrt(abs(invs(i,1)-curr(:,1))^2+abs(invs(i,2)-curr(:,2))^2);
    dnex=sqrt(abs(nex(:,1)-curr(:,1))^2+abs(nex(:,2)-curr(:,2))^2);
    
    %[dos dnex]
    
    if(dos<dnex)
        flag=1;
      curr;
      nex;
     invs(i,:);
     [dos dnex];
    end
 end
 end
    
 bb=size(prev_list);

if(flag>0)
%     'flagged move'
%     nex
%     curr
    nex=prev_list(bb(1),:);
    nex;
    prev;
    
end
% pointcentrsvalid(ind(1),:)=[];
end

% 
% nex=pointcentrs(ind(1))
% for i=1:length(invaly)
%    if pointcentrs(ind(1)
%     
%     
%     
% end
% figure;
 hold on;

 plot(pointcentrs(:,1),pointcentrs(:,2),'r*')
hold on
if(~isempty(obstcles) && ~isempty(inval))
plot(inval(:,1),inval(:,2),'b*')
end
plot(x_current,y_current,'mo')
hold on
plot(nex(1),nex(2),'g*')
hold on;
