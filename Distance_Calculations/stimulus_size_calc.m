ptb=0; 
if ptb==1
    PsychImaging('PrepareConfiguration');
    ScreenNumber = max(Screen('Screens'));
    ScreenResolution = Screen('Resolution', ScreenNumber);
    [ScreenWidth_in_mm, ScreenHeight_in_mm] = Screen('DisplaySize', ScreenNumber);
    Window_Width=ScreenWidth_in_mm;   %SetUp_Info.ScreenWidth_in_mm; mm = 698
    Window_Height= ScreenHeight_in_mm; %SetUp_Info.ScreenHeight_in_mm; mm = 393
    Window_Width_pixels = ScreenResolution.width; %RectWidth(SetUp_Info.Window_rectangle); 1920
    Window_Height_pixels = ScreenResolution.height; %RectHeight(SetUp_Info.Window_rectangle); 1080
    distance_observer_to_screen=700;
elseif ptb==0
    Window_Width= 698;
    Window_Height= 393;
    Window_Width_pixels = 1920;
    Window_Height_pixels = 1080;
    distance_observer_to_screen=700;
end

%% Stimulus Size in ZP Version 
if ptb==1;
    Disk_Radius_in_Scale = 0.08;
    Disk_Radius=Disk_Radius_in_Scale*Window_Width_pixels*2; %8.6 degrees
    Disk_Radius_Deg=Disk_Radius/pix_deg
else 
    Disk_Radius_in_Scale = 0.15;
    Disk_Radius=Disk_Radius_in_Scale*1920*2;
    Disk_Radius_Deg=Disk_Radius/pix_deg
end
