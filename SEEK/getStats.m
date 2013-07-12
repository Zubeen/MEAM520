
function [statsRed statsGreen statsBlue]=getStats(I)

hsvI=rgb2hsv(I);

%% Seperate out the Red Green and Blue Regions
redMask=(hsvI(:,:,1)<=0.1|hsvI(:,:,1)>=0.74)&(hsvI(:,:,2)>=0.5 & hsvI(:,:,2)<=1 & hsvI(:,:,3)>0.1);
redMask_filled=imfill(redMask,'holes');
figure(1);
imshow(redMask_filled);


blueMask=(hsvI(:,:,1)>=0.5&hsvI(:,:,1)<=0.67& hsvI(:,:,2)>=0.5 & hsvI(:,:,2)<=1& hsvI(:,:,3)>0.1);
blueMask_filled=imfill(blueMask,'holes');
figure(3);
imshow(blueMask_filled);

% blackMask=(hsvI(:,:,2)<0.2 & hsvI(:,:,3)<0.2);
% blackMask_filled=imfill(blackMask,'holes');
% figure(3);
% imshow(blackMask_filled);

greenMask=((hsvI(:,:,1)>0 & hsvI(:,:,1)<0.5) & hsvI(:,:,2)>=0.3 & hsvI(:,:,2)<=1 & hsvI(:,:,3)>0.05);
greenMask_filled=imfill(greenMask,'holes');
figure(2);
imshow(greenMask_filled);

%% Get Info
statsRed=regionprops(redMask_filled,'PixelList','Centroid');
statsBlue=regionprops(blueMask_filled,'PixelList','Centroid');
statsGreen=regionprops(greenMask_filled,'PixelList','Centroid');

% x=find(statsRed(:).PixelList(:,2)==max(statsRed(:).PixelList(:,2)));
% if(x==240)
%     flag=1;
% else
%     flag=0;
% end

end
