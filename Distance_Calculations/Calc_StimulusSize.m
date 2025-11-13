StimulusSize_prompt={'PTB?', 'Display Width (mm)', 'Display Height (mm)', 'Display Width (pixels)', 'Display Height (pixels)', 'Distance from observer to screen', 'Disk Radius (scale)', 'Desired DVA: DOTS'}
Calculation_dialog_title='Give_Exp_Information';
num_lines=1;
StimulusSize_default_answer={'no', '698', '393',  '1920', '1080', '700', '0.08' '5', '5', '12', '0.5'};
StimulusSize_info=inputdlg(StimulusSize_prompt,StimulusSize_dialog_title,num_lines,StimulusSize_default_answer);
StimulusSize_info=StimulusSize_info';
ptb = StimulusSize_info{1};

if strcmp(ptb, 'no')
    Window_Width= str2double(Calculation_info{2});
    Window_Height= str2double(Calculation_info{3});
    Window_Width_pixels= str2double(Calculation_info{4});
    Window_Height_pixels= str2double(Calculation_info{5});
    distance_observer_to_screen = str2double(Calculation_info{6});
elseif strcmp(ptb, 'yes')
    PsychImaging('PrepareConfiguration');
    ScreenNumber = max(Screen('Screens'));
    ScreenResolution = Screen('Resolution', ScreenNumber);
    [ScreenWidth_in_mm, ScreenHeight_in_mm] = Screen('DisplaySize', ScreenNumber);
    Window_Width=ScreenWidth_in_mm;
    Window_Height= ScreenHeight_in_mm;
    Window_Width_pixels = ScreenResolution.width;
    Window_Height_pixels = ScreenResolution.height;
    distance_observer_to_screen = str2double(Calculation_info{6});
end
StimulusSquareSideLength= str2double(Calculation_info{7}) * 2 * Window_Width_pixels; 
DVA_Dots=str2double(Calculation_info{8});


%% Calculate Pixels/Degree 
deg_screen_width = rad2deg(2 * atan(Window_Width / (2 * distance_observer_to_screen)));
deg_screen_height = rad2deg(2 * atan(Window_Height / (2 * distance_observer_to_screen)));
pix_degree_width= Window_Width_pixels/deg_screen_width;
pix_degree_height= Window_Height_pixels/deg_screen_height;
pix_deg= mean([pix_degree_height pix_degree_width]) 


%% Calculate how many pixels for Specified Degrees Visual Angle 
% ItemSize = StimulusSquareSideLength/NbX; %25 pixels  
% Size = round(Size_To_ItemSize_Ratio=0.5*ItemSize); = 12.5 pixels  
% Dot_Radius = round(Size * Dot_Radius_To_Size=0.2); * 2.5 pixels 

% Calculate how many pixels for Dots 
Dots_Pixels= DVA_Dots*pix_deg; 
Size=Dots_Pixels*2;

% Number of Dots: 
NDots = NbX*NbY *40;