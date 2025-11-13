function [Dot_Radius, Dot_DVA]=sizeparameters(StimulusSquareSideLength, NBX, Item_Size_Ratio, Size_Dot_Ratio) 

%% Calculate how many pixels for Specified Degrees Visual Angle 

ItemSize= StimulusSquareSideLength/NBX;
Size = round(Item_Size_Ratio *ItemSize);
Dot_Radius= round(Size * Size_Dot_Ratio);
NDots= NBX*NBX*40; 

%% Pixels--> DVA
PsychImaging('PrepareConfiguration');
ScreenNumber = max(Screen('Screens'));
ScreenResolution = Screen('Resolution', ScreenNumber);
[ScreenWidth_in_mm, ScreenHeight_in_mm] = Screen('DisplaySize', ScreenNumber);
Window_Width=ScreenWidth_in_mm;
Window_Height= ScreenHeight_in_mm;
Window_Width_pixels = ScreenResolution.width;
Window_Height_pixels = ScreenResolution.height;
distance_observer_to_screen = 700;

deg_screen_width = rad2deg(2 * atan(Window_Width / (2 * distance_observer_to_screen)));
deg_screen_height = rad2deg(2 * atan(Window_Height / (2 * distance_observer_to_screen)));
pix_degree_width= Window_Width_pixels/deg_screen_width;
pix_degree_height= Window_Height_pixels/deg_screen_height;
pix_deg= mean([pix_degree_height pix_degree_width]); 

%%
Dot_DVA=Dot_Radius/pix_deg;




