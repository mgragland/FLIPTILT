function DisplayPages = Prepare_DisplayPages(ExperimentInfo)

Window_ID = ExperimentInfo.DisplayInfo.Window_ID;
Window_Width =ExperimentInfo.DisplayInfo.WindowWidthAndHeightInPixels.TotalScreenX; 
Window_Height =ExperimentInfo.DisplayInfo.WindowWidthAndHeightInPixels.TotalScreenY;
BackgroundLuminance= ExperimentInfo.DisplayInfo.BackgroundLuminance;
TextFont_sizeXY = ExperimentInfo.TextFont_sizeXY;
LowLuminance = ExperimentInfo.DisplayInfo.LowLuminance;

%--- Prepare the 'Press a button for the next trial' screen
TrialStartInstructionScreen =  Screen('OpenOffscreenWindow', Window_ID);
InstructionTextSize =TextFont_sizeXY; 
Screen('FillRect',  TrialStartInstructionScreen,  BackgroundLuminance);
Screen('TextSize', TrialStartInstructionScreen, InstructionTextSize);
DrawFormattedText(TrialStartInstructionScreen, 'Press any button for the next trial',  'center', 'center', [0, 0, 0]);


DisplayPages.TrialStartInstructionScreen = TrialStartInstructionScreen;


%---- fixation screen.
FixationSize  = ExperimentInfo.FixationSize;

FixationOffScreen = Screen('OpenOffscreenWindow', Window_ID);
Screen('FillRect', FixationOffScreen, BackgroundLuminance);
Screen('FillOval', FixationOffScreen, LowLuminance, ...
    [Window_Width/2-FixationSize  Window_Height/2-FixationSize  Window_Width/2+FixationSize  Window_Height/2+ FixationSize]);


DisplayPages.FixationOffScreen = FixationOffScreen;


%--- Blank Screen

BlankScreen = Screen('OpenOffscreenWindow', Window_ID);
Screen('FillRect', BlankScreen, BackgroundLuminance);
DisplayPages.BlankScreen = BlankScreen;

