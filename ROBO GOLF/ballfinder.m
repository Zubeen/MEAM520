function [Wreal] = ballfinder(filename)
%%
I=imread('img.jpeg');
figure(1)
imshow(I);
hsvI=rgb2hsv(I);
tic
%%
figure(2)
greenMask=((hsvI(:,:,1)>0.22 & hsvI(:,:,1)<0.4) & hsvI(:,:,2)>=0.4 & hsvI(:,:,2)<=1 & hsvI(:,:,3)>0.1);
greenMask_filled=imfill(greenMask,'holes');
imshow(greenMask_filled)
%%
blueMask=(hsvI(:,:,1)>=0.45&hsvI(:,:,1)<=0.67&greenMask_filled& hsvI(:,:,2)>=0.5 & hsvI(:,:,2)<=1& hsvI(:,:,3)>0.1);
blueMask_filled=imfill(blueMask,'holes');
statsBlue=regionprops(blueMask_filled,'PixelIdxList','Area','PixelList','Centroid');
bigBlue=find([statsBlue(:).Area]==max([statsBlue(:).Area]));
blueCenter = statsBlue(bigBlue).Centroid;
figure(3)
imshow(blueMask_filled)
hold on
plot(blueCenter(1,1),blueCenter(1,2),'m.')
%%
yellowMask=(hsvI(:,:,1)>=0.13&hsvI(:,:,1)<=0.19)&greenMask_filled&(hsvI(:,:,2)>=0.6 & hsvI(:,:,2)<=1 & hsvI(:,:,3)>0.1);
figure(1)
imshow(yellowMask);
yellowMask=bwmorph(yellowMask,'erode',5);
yellowMask_filled=imfill(yellowMask,'holes');

statsYellow=regionprops(yellowMask_filled,'PixelIdxList','Area','PixelList','Centroid');
bigYellow=find([statsYellow(:).Area]==max([statsYellow(:).Area]));
yellowCenter = statsYellow(bigYellow).Centroid;
figure(4)
imshow(yellowMask_filled);
hold on;
plot(yellowCenter(1,1),yellowCenter(1,2),'m.')
imagesc((hsvI(:,:,1)>=0.11&hsvI(:,:,1)<=0.22)&(hsvI(:,:,2)>=0.5 & hsvI(:,:,2)<=1));
%%
redMask=(hsvI(:,:,1)<=0.1|hsvI(:,:,1)>=0.91)&greenMask_filled&(hsvI(:,:,2)>=0.55 & hsvI(:,:,2)<=1 & hsvI(:,:,3)>0.1);
redMask_filled=imfill(redMask,'holes');
statsRed=regionprops(redMask_filled,'PixelIdxList','Area','PixelList','Centroid');
bigRed=find([statsRed(:).Area]==max([statsRed(:).Area]));
redCenter = statsRed(bigRed).Centroid;
% figure(5)
% imshow(redMask_filled);
% hold on;
% plot(redCenter(1,1),redCenter(1,2),'m.')
%%
whiteMask=(hsvI(:,:,3)>=0.9 & hsvI(:,:,2)<=0.1)&greenMask_filled;
statsWhite=regionprops(whiteMask,'PixelIdxList','Area','PixelList','Centroid');
bigWhite=find([statsWhite(:).Area]==max([statsWhite(:).Area]));
WhiteCenter = statsWhite(bigWhite).Centroid;
% figure(6)
% imshow(whiteMask);
% hold on;
% plot(WhiteCenter(1,1),WhiteCenter(1,2),'m.')
%%
figure(7)
imshow(I)
hold on;
plot(WhiteCenter(1,1),WhiteCenter(1,2),'m.')
hold on;
plot(redCenter(1,1),redCenter(1,2),'m.')
hold on;
plot(yellowCenter(1,1),yellowCenter(1,2),'m.')
hold on;
plot(blueCenter(1,1),blueCenter(1,2),'m.')

%
RYBvirtual=[redCenter(1,1) yellowCenter(1,1) blueCenter(1,1);
            redCenter(1,2) yellowCenter(1,2) blueCenter(1,2);
            1 1 1];
RYBreal=[18.5 -4.25 6.5;
         13.5 7.5 -24;
          1 1 1];
Wvirtual=[WhiteCenter(1,1);WhiteCenter(1,2);1];
Ratios= inv(RYBvirtual) * Wvirtual;
Wreal=RYBreal*Ratios;
toc
end