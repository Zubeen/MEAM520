%% ballf

startFramebuffer();
img=get_frame();
imshow(img);
stopFramebuffer();


p0b=ballfinder(img);


%% use ball finder; B= p0b;
pumaGripper('open')

close all;

if(p0b(2)<=0)
B=p0b +[1 0.5 0]';
else
B=p0b+[-.5 1.75 0]';
end
easy_hole=[20.5 4 2];

if(p0b(2)>=0 && p0b(1)<=0)
    B=p0b+[-0.5 1.5 0]';
end

chg=ball_in_easy_real(B,easy_hole);

'put white ball back'
pause;


%% now for the med 

%% ball finder 

%pumaStop
%pumaStart


%%

% pumaStop;
% pumaStart;
% 
% pause;

if(p0b(2)<=0)
B=p0b +[1 0.5 0]';
else
B=p0b+[-.5 1.75 0]';
end


if(p0b(2)>=0 && p0b(1)<=0)
    B=p0b+[-0.5 1.5 0]';
end

med_hole=[-2.0, 19.0, 5.0]+[-1.5 -1.5 0];
c=ball_in_med(B,med_hole);

pause;


