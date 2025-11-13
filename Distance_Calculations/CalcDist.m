Calculation_prompt={'PTB?', 'Display Width (mm)', 'Display Height (mm)', 'Display Width (pixels)', 'Display Height (pixels)', 'DVA (Distance to Stimulus)', 'Size of PRL', 'FLIPTILT Size', 'Size of Trained Location', 'Location from Fixation', 'Fixation or Stimulus Center', 'Distance from observer to screen'}
Calculation_dialog_title='Give_Exp_Information';
num_lines=1;
Calculation_default_answer={'no', '698', '393',  '1920', '1080', '5', '5' '8.53', '2.5', 'Left', 'Stimulus', '700'};
Calculation_info=inputdlg(Calculation_prompt,Calculation_dialog_title,num_lines,Calculation_default_answer);
Calculation_info=Calculation_info';
ptb = Calculation_info{1};

if strcmp(ptb, 'no')
    Window_Width= str2double(Calculation_info{2});
    Window_Height= str2double(Calculation_info{3});
    Window_Width_pixels= str2double(Calculation_info{4});
    Window_Height_pixels= str2double(Calculation_info{5});
    DistancetoStimulus= str2double(Calculation_info{6});
    SizeofPRL=  str2double(Calculation_info{7});
    Disk_Diameter_Deg=str2double(Calculation_info{8});
    SizeofTrainedLocation=str2double(Calculation_info{9});
    Location = Calculation_info{10};
    Fixation_or_Stimulus = Calculation_info{11};
    distance_observer_to_screen = str2double(Calculation_info{12});
elseif strcmp(ptb, 'yes')
    PsychImaging('PrepareConfiguration');
    ScreenNumber = max(Screen('Screens'));
    ScreenResolution = Screen('Resolution', ScreenNumber);
    [ScreenWidth_in_mm, ScreenHeight_in_mm] = Screen('DisplaySize', ScreenNumber);
    Window_Width=ScreenWidth_in_mm;
    Window_Height= ScreenHeight_in_mm;
    Window_Width_pixels = ScreenResolution.width;
    Window_Height_pixels = ScreenResolution.height;
    DistancetoStimulus= str2double(Calculation_info{6});
    SizeofPRL=  str2double(Calculation_info{7});
    Disk_Diameter_Deg=str2double(Calculation_info{8});
    SizeofTrainedLocation=str2double(Calculation_info{9});
    Location = Calculation_info{10};
    Fixation_or_Stimulus = Calculation_info{11};
    distance_observer_to_screen = str2double(Calculation_info{12});
end

%% Calculate Pixels/Degree 
deg_screen_width = rad2deg(2 * atan(Window_Width / (2 * distance_observer_to_screen)));
deg_screen_height = rad2deg(2 * atan(Window_Height / (2 * distance_observer_to_screen)));
pix_degree_width= Window_Width_pixels/deg_screen_width;
pix_degree_height= Window_Height_pixels/deg_screen_height;
pix_deg= mean([pix_degree_height pix_degree_width]) 


%% Calculate how many pixels for Specified Degrees Visual Angle 
DVA_pixels_total=DistancetoStimulus * pix_deg; % 
DVA_pixels_height=DistancetoStimulus * pix_degree_height;
DVA_pixels_width=DistancetoStimulus * pix_degree_width;
Disk_Radius_Pixels=  (Disk_Diameter_Deg/2)*pix_degree_width;

%% Determine Number of Pixels for Shift 
% FLAP--> the size of the stimulus is 2.5 degrees and PRL is 5; Scotoma=10
% therefore the neurons we train are 5+1.25 degrees away or 6.25 


Distance_TrainedLocation= DistancetoStimulus + ((SizeofPRL/2)-SizeofTrainedLocation/2)
Distance_TrainedLocation_Pixels= Distance_TrainedLocation * pix_degree_width;


% Shift Needed 
Distance_from_Fixation_Deg=(Disk_Diameter_Deg/2)+Distance_TrainedLocation; 
Distance_from_Fixation_Pixels=Distance_from_Fixation_Deg*pix_degree_width;

%% Determine Location of Shift and the Scale 
% note fixation AND stimulus location is plotted based on the midpoint of
% the screen 

% Fixation/Stimulus_xCenter =  TotalScreenX/2 + FixationCenter.x_in_Pixel;
% Fixation/Stimulus_yCenter =  TotalScreenY/2 + FixationCenter.y_in_Pixel;

% for the scale: takes into account the pixels based on total pixels in x/y
%FixationCenter.x_in_Pixel = FixationCenter.x_in_Scale*TotalScreenX;
%FixationCenter.y_in_Pixel = FixationCenter.y_in_Scale*TotalScreenY;

[Fixation_Scale, Stimulus_Scale]=locationandscale(Location,Fixation_or_Stimulus, Distance_from_Fixation_Pixels, Window_Width_pixels, Window_Height_pixels)

%% Plot the Coordinates in Pixels
plot_fliptilt(Window_Width_pixels, Window_Height_pixels, Stimulus_Scale(1), Stimulus_Scale(2),Disk_Radius_Pixels , Fixation_Scale(1), Fixation_Scale(2))

