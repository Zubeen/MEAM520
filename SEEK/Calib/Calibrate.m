function Calibrate(filename)
clc
I=imread(filename);
hsvI=rgb2hsv(I);

%% Seperate out the Red Green and Blue Regions
redMask=(hsvI(:,:,1)<=0.1|hsvI(:,:,1)>=0.74)&(hsvI(:,:,2)>=0.5 & hsvI(:,:,2)<=1 & hsvI(:,:,3)>0.1);
redMask_filled=imfill(redMask,'holes');
figure(1);
imshow(redMask_filled);


blueMask=(hsvI(:,:,1)>=0.5&hsvI(:,:,1)<=0.67& hsvI(:,:,2)>=0.5 & hsvI(:,:,2)<=1& hsvI(:,:,3)>0.1);
blueMask_filled=imfill(blueMask,'holes');
figure(2);
imshow(blueMask_filled);

greenMask=((hsvI(:,:,1)>0 & hsvI(:,:,1)<=0.5) & hsvI(:,:,2)>=0.4 & hsvI(:,:,2)<=1 & hsvI(:,:,3)>0.05);
greenMask_filled=imfill(greenMask,'holes');
figure(4);
imshow(greenMask_filled);

statsRed=regionprops(redMask_filled,'Area','PixelList','Centroid');
bigRed=find([statsRed(:).Area]==max([statsRed(:).Area]));
redCenter = statsRed(bigRed).Centroid;
redHeight = max(statsRed(bigRed).PixelList(:,2)) - min(statsRed(bigRed).PixelList(:,2))
redWidth = max(statsRed(bigRed).PixelList(:,1)) - min(statsRed(bigRed).PixelList(:,1))
redArea = redHeight * redWidth
getDist(redArea,1);

statsGreen=regionprops(greenMask_filled,'Area','PixelList','Centroid');
bigGreen=find([statsGreen(:).Area]==max([statsGreen(:).Area]));
greenCenter = statsGreen(bigGreen).Centroid;
GreenHeight = max(statsGreen(bigGreen).PixelList(:,2)) - min(statsGreen(bigGreen).PixelList(:,2))
GreenWidth = max(statsGreen(bigGreen).PixelList(:,1)) - min(statsGreen(bigGreen).PixelList(:,1))
GreenArea = GreenHeight * GreenWidth

statsBlue=regionprops(blueMask_filled,'Area','PixelList','Centroid');
bigBlue=find([statsBlue(:).Area]==max([statsBlue(:).Area]));
blueCenter = statsBlue(bigBlue).Centroid;
BlueHeight = max(statsBlue(bigBlue).PixelList(:,2)) - min(statsBlue(bigBlue).PixelList(:,2))
BlueWidth = max(statsBlue(bigBlue).PixelList(:,1)) - min(statsBlue(bigBlue).PixelList(:,1))
BlueArea = BlueHeight * BlueWidth

end