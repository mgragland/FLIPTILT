function plot_fliptilt(Window_Width_pixels, Window_Height_pixels, center_x, center_y, disk_radius, fixation_x, fixation_y)

% Debug 
% Window_Width_pixels;
% Window_Height_pixels;
% center_x=Stimulus_Scale(1);
% center_y=Stimulus_Scale(2);
% disk_radius=Disk_Radius_Pixels;
% fixation_x=Fixation_Scale(1);
% fixation_y=Fixation_Scale(2);

% Fixation/Stimulus_xCenter =  TotalScreenX/2 + FixationCenter.x_in_Pixel;
% Fixation/Stimulus_yCenter =  TotalScreenY/2 + FixationCenter.y_in_Pixel;

% for the scale: takes into account the pixels based on total pixels in x/y
%FixationCenter.x_in_Pixel = FixationCenter.x_in_Scale*TotalScreenX;
%FixationCenter.y_in_Pixel = FixationCenter.y_in_Scale*TotalScreenY;

% Convert Scale to Pixels 
center_x_pixels= center_x * Window_Width_pixels;
center_x_coordinate=center_x_pixels + Window_Width_pixels/2;

center_y_pixels= center_y * Window_Height_pixels;
center_y_coordinate= abs(center_y_pixels + Window_Height_pixels/2);

fixation_x_pixels=fixation_x*Window_Width_pixels;
fixation_x_coordinate=fixation_x_pixels + Window_Width_pixels/2;

fixation_y_pixels= fixation_y * Window_Height_pixels;
fixation_y_coordinate= abs(fixation_y_pixels + Window_Height_pixels/2);


% Calculation of Circles for Plotting: 
theta= linspace(0,2*pi, 100); %angles from 0 to 2pi

%stereogram center
disk_radius_x= center_x_coordinate + disk_radius *cos(theta);
disk_radius_y= center_y_coordinate  +  disk_radius *sin(theta);


% PLOT POINTS ON THE GRID 
figure
plot(fixation_x_coordinate, fixation_y_coordinate, 'or')
hold on
plot(center_x_coordinate,center_y_coordinate, 'ok')
hold on
plot(disk_radius_x, disk_radius_y,'m-', 'LineWidth', 2)
axis([0 Window_Width_pixels 0 Window_Height_pixels])
axis equal; 
set(gca, 'YDir', 'reverse')
set(gca, 'XLimMode', 'manual', 'YLimMode', 'manual')
