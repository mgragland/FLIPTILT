function  DisplayInfo = Get_DisplayInfo(ExperimentInfo)

InputParameters =  ExperimentInfo.InputParameters;

BackgroundScale = InputParameters.BackgroundScale;
LowScale = InputParameters.LowScale;
HighScale = InputParameters.HighScale;
%
%------- Get monitor parameters----------------------

sca;
KbName('UnifyKeyNames');
Screen('Preference', 'SkipSyncTests', 1); %--- You are telling Psychtoolbox to skip the synchronization tests that ensure accurate timing of stimulus presentation on the screen.

PsychImaging('PrepareConfiguration');
%PsychDefaultSetup(2);

ptb_drawformattedtext_oversize = 2;
ScreenNumber = max(Screen('Screens'));

ScreenResolution = Screen('Resolution', ScreenNumber);
[ScreenWidth_in_mm, ScreenHeight_in_mm] = Screen('DisplaySize', ScreenNumber);

WhiteColor =  WhiteIndex(ScreenNumber);
BlackColor =  BlackIndex(ScreenNumber);
GrayColor =   round(WhiteColor*BackgroundScale);
Background_ColorVector = GrayColor*[1, 1, 1];

if  ExperimentInfo.Debugging_Mode  ==1 
	[Window_ID, Window_rectangle] = PsychImaging('OpenWindow', ScreenNumber, Background_ColorVector, ...
    [0 0 round(ScreenResolution.width*0.5), round(ScreenResolution.height*0.8)]);
else
    [Window_ID, Window_rectangle] = PsychImaging('OpenWindow', ScreenNumber, Background_ColorVector);
end

FrameInterval_in_Second   = Screen('GetFlipInterval', Window_ID);
Frame_Rate = Screen('FrameRate', Window_ID);
%Screen('TextSize', Window_ID, design.Text_FontSize);

if   ExperimentInfo.Debugging_Mode  ==1 %--- in real mode, hide the cursor from the screen with the visual input for experiments.
    HideCursor(ScreenNumber);   %ShowCursor(ScreenNumber)
end


TotalScreenX = Window_rectangle(3);
TotalScreenY = Window_rectangle(4);



WhiteLuminance = WhiteColor;
BlackLuminance = BlackColor;
BackgroundLuminance = round(WhiteLuminance*BackgroundScale); %--- background
HighLuminance = round(WhiteLuminance*HighScale); %--- Highest luminance scale
LowLuminance = round(WhiteLuminance*LowScale); %--- Highest luminance scale
%%%%%%%%%%%%%%%%% -----------------------------------------------------
DisplayInfo.IFI=FrameInterval_in_Second;
DisplayInfo.Frame_Rate = Frame_Rate; 
%DisplayInfo.ViewingDistance =ViewingDistance; 
DisplayInfo.WindowWidthAndHeightInPixels.TotalScreenX = TotalScreenX;
DisplayInfo.WindowWidthAndHeightInPixels.TotalScreenY = TotalScreenY;
DisplayInfo.WhiteLuminance = WhiteLuminance;
DisplayInfo.BlackLuminance = BlackLuminance;
DisplayInfo.BackgroundLuminance  = BackgroundLuminance;
DisplayInfo.HighLuminance = HighLuminance;
DisplayInfo.LowLuminance = LowLuminance;
DisplayInfo.Window_ID = Window_ID;
