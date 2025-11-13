
RT = [];
ButtonPressed = [];
StimulusDuration_AfterResponse = ExperimentInfo.InputParameters.StimulusDuration_AfterResponse;
ResponseButtons = ExperimentInfo.ResponseButtons;

StimulusDuration = condition.PresentationDuration;
xCenter =  ExperimentInfo.DisplayInfo.WindowWidthAndHeightInPixels.TotalScreenX/2;
yCenter =  ExperimentInfo.DisplayInfo.WindowWidthAndHeightInPixels.TotalScreenY/2;
%
GapDuration =  ExperimentInfo.InputParameters.GapDuration;
FixationDuration =  ExperimentInfo.InputParameters.FixationDuration;
TrialStartInstructionScreen= ExperimentInfo.DisplayPages.TrialStartInstructionScreen;
FixationOffScreen= ExperimentInfo.DisplayPages.FixationOffScreen;
BlankScreen= ExperimentInfo.DisplayPages.BlankScreen;
%BackgroundLuminance = ExperimentInfo.DisplayInfo.BackgroundLuminance;
%Screen('FillRect',  TrialStartInstructionScreen,  BackgroundLuminance);
Window_ID = ExperimentInfo.DisplayInfo.Window_ID;

Screen('CopyWindow', TrialStartInstructionScreen, Window_ID);

startSecs_NextTrialPrompt =Screen('Flip', Window_ID);
TakeKbCheck;  FlushEvents('keyDown');
Screen('CopyWindow', FixationOffScreen,  Window_ID);
FixationFrame_OnsetTime  = Screen('Flip', Window_ID);
if GapDuration>0
        Screen('CopyWindow', BlankScreen, Window_ID);
        BlankScreen_OnsetTime =  Screen('Flip', Window_ID, ...
		FixationFrame_OnsetTime +FixationDuration -0.5/ExperimentInfo.DisplayInfo.FrameRate); 
end	
	
Screen('CopyWindow', BlankScreen, Window_ID);
[imageHeight, imageWidth] = size(StimulusMatrix);
dstRect = [0 0 imageWidth imageHeight];	
% Center that rectangle on the screen center
dstRect = CenterRectOnPointd(dstRect, xCenter, yCenter);
texture = Screen('MakeTexture', Window_ID, StimulusMatrix);
Screen('DrawTexture', Window_ID, texture, [], dstRect);	

if  GapDuration>0
        Stimulus_OnsetTime =  Screen('Flip', Window_ID, ...
		BlankScreen_OnsetTime +GapDuration -0.5/ExperimentInfo.DisplayInfo.FrameRate); 
else
        Stimulus_OnsetTime =  Screen('Flip', Window_ID, ...
		FixationFrame_OnsetTime +FixationDuration -0.5/ExperimentInfo.DisplayInfo.FrameRate); 
end

%---- put on the mask
Screen('CopyWindow', BlankScreen, Window_ID);
[imageHeight, imageWidth] = size(MaskMatrix);
dstRect = [0 0 imageWidth imageHeight];	
% Center that rectangle on the screen center
dstRect = CenterRectOnPointd(dstRect, xCenter, yCenter);
texture = Screen('MakeTexture', Window_ID, MaskMatrix);
Screen('DrawTexture', Window_ID, texture, [], dstRect);	


Mask_OnsetTime =  Screen('Flip', Window_ID, ...
	Stimulus_OnsetTime +StimulusDuration -0.5/ExperimentInfo.DisplayInfo.FrameRate); 
	
while length(RT)==0 | RT(end)< 0  %--- if response is before the stimulus onset, wait for the next button press while record this button press
    TakeKbCheck;
    FlushEvents('keyDown');
    %--- button character pressed and its RT
    Response_Characters = KbName(keyCode);
    ThisRT = timeSecs-Mask_OnsetTime;
    RT = [RT, ThisRT];
    ButtonPressed = [ButtonPressed,  Response_Characters];
end

R=input('here 1, continue');

%--- 
if strcmp('esc', KbName(keyCode)) ==0
    EscapeKeyPressed =0;
    while (Response_Characters(1) ~=ResponseButtons{1} &  Response_Characters(1) ~=ResponseButtons{2} )  %--- if the button response is invalid, wait for the next button press while record this button press
        if strcmp('esc', KbName(keyCode)) ==1  % Escape key pressed
            EscapeKeyPressed =1; break;
        else
		fs = 5000; t = 0:0.00002:0.02;

	    HighToneSoundwave = sin(2*pi*fs*2*t);
            sound(HighToneSoundwave, fs);
            TakeKbCheck;
            FlushEvents('keyDown');
            Response_Characters = KbName(keyCode);
            ThisRT = timeSecs-Stimulus_OnsetTime;
            RT = [RT, ThisRT];
            ButtonPressed = [ButtonPressed, Response_Characters];
        end
    end
else
    EscapeKeyPressed =1;
end

R=input('here 2, continue');


pause(StimulusDuration_AfterResponse);
R=input('here 3, continue');

%--- Response etc Information.
%
ResponseAndMiscInfo.RT = RT;
R=input('here 4, continue');
ResponseAndMiscInfo.ButtonPressed = ButtonPressed;
R=input('here 5, continue');
ResponseAndMiscInfo.FixationDuration = round(FixationDuration*FrameRate)/FrameRate;
R=input('here 6, continue');
ResponseAndMiscInfo.GapDuration = round(GapDuration*FrameRate)/FrameRate;
R=input('here 7, continue');
ResponseAndMiscInfo.FrameRate = FrameRate;
R=input('here 8, continue');
ResponseAndMiscInfo.startSecs_NextTrialPrompt= startSecs_NextTrialPrompt;
R=input('here 9, continue');
ResponseAndMiscInfo.FixationFrame_OnsetTime = FixationFrame_OnsetTime;
R=input('here 10, continue');
ResponseAndMiscInfo.Stimulus_OnsetTime =  Stimulus_OnsetTime;
R=input('here 11, continue');
ResponseAndMiscInfo.Mask_OnsetTime =  Mask_OnsetTime;
R=input('here 12, continue');
ResponseAndMiscInfo.EscapeKeyPressed = EscapeKeyPressed;
R=input('here 13, continue');
ResponseAndMiscInfo.ResponseButtonPressed = KbName(keyCode);
R=input('here 14, continue');
ResponseAndMiscInfo.StimulusDuration_AfterResponse = StimulusDuration_AfterResponse;
R=input('here 15, continue');
