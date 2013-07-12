function generate_map(markers,obs_g,obs_b) %,x_curr,y_curr)
% markers :: x*y*n matrix of coordinates and number of markers
%     obs :: x*y*n matrix of coordinates and number of obstacles
% x_curr,y_curr :: current values of robot centroid

%% TEST DATA

% markers = [11 10
%            30 40
%            60 70];
%        
% obs_g = [ 8  20
%          10  41
%           30  8];
%      
% obs_b = [110 7
%           6 120
%          12 90];

%%   
% all_x = max([markers(:,1) obs_g(:,1) obs_b(:,1)]);
% x_max = max(all_x(1,:))
% 
% all_y = max([markers(:,2) obs_g(:,2) obs_b(:,2)]);
% y_max = max(all_y(1,:))

%% Make floor

xdata = [0 0 250 250];
          
     
ydata = [0 250 250 0];
        
zdata = zeros(4,1);
p = patch(xdata',ydata',zdata,'b');
set(p,'FaceColor',[0.85 0.411 0.117]);
alpha(.8);


%%


% plot3(x_curr,y_curr,0,'.b','LineWidth',4);     % Plot current position of robot
axis image;
grid on;
grid minor;
hold on;
view([-15 45]); 
% zlim([0 60]);

% Plot marker (RED CYLINDER)
    for i=1:size(markers,1)
        draw_marker(markers(i,:));
    end
        
    for j=1:size(obs_g,1)     % Plot GREEN obstacles
        draw_g_obs(obs_g(j,:));
    end
    
    for k=1:size(obs_b,1)     % Plot BLUE obstacles
        draw_b_obs(obs_b(k,:));
    end

    pause(2);
    
% axis vis3d
for ii=1:36
   camorbit(1,0,'data',[0 0 1])
   drawnow
   pause(0.1)
end
    
%%
    
end