 function[obsnewt]= check_crap(obstcles,obsnew)
%checks for 20 x 20 around
'in check crap' 
obstcles
 obsnewt=[];
 
%  if(isempty)

% a=[10 10;12 11;23 45;26 47;56 78;60 80];
 a=obstcles;

% b=[20 60;120 200;70 90;150 150];
 b=obsnew;

l=size(a);flag=0;
l1=size(b);
invs=[];
tot=[];
val=[];

for i=1:l(1)
   for j=1:l1(1)
  tot=[tot j];  
   if(((b(j,1)<a(i,1)+20)) && (b(j,1)>a(i,1)-20) && ((b(j,2)<a(i,2)+20)) && (b(j,2)>a(i,2)-20))
%        'crap'
%        j
%        i
   flag=1;
    
       invs=[invs j];
   
   end
   end
    
    
end
flg=0;keep=[];

tot=unique(tot);
invs=unique(invs);
bot=tot;
val=[];

for j=1:length(unique(tot))
    sum=0;
for i=1:length(unique(invs))
    
   if(tot(j)==invs(i))
       sum=1;
   end
    
   
   
end
if(sum==0)
   val=[val j]; 
end
end

if(~isempty(val))
    for i=1:length(val)
    obsnewt=[obsnewt; b(val(i),:)];
        
    end
end
