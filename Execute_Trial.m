function ResponseAndMiscInfo = Execute_Trial(StimulusMatrix, MaskMatrix, RingMatrix, condition, ExperimentInfo, trial)
trial=trial;
LowLuminance = ExperimentInfo.DisplayInfo.LowLuminance;

FixationSize = ExperimentInfo.FixationSize;

Frame_Rate = ExperimentInfo.DisplayInfo.Frame_Rate; 
RT = [];
StimulusDuration_AfterResponse = ExperimentInfo.InputParameters.StimulusDuration_AfterResponse;
ResponseButtons = ExperimentInfo.ResponseButtons;
TextFont_sizeXY = ExperimentInfo.TextFont_sizeXY;

StimulusCenter = condition.StimulusCenter;
FixationCenter = condition.FixationCenter;

TotalScreenX =  ExperimentInfo.DisplayInfo.WindowWidthAndHeightInPixels.TotalScreenX;
TotalScreenY =  ExperimentInfo.DisplayInfo.WindowWidthAndHeightInPixels.TotalScreenY;


StimulusCenter.x_in_Pixel = StimulusCenter.x_in_Scale*TotalScreenX
StimulusCenter.y_in_Pixel = StimulusCenter.y_in_Scale*TotalScreenY;
%
FixationCenter.x_in_Pixel = FixationCenter.x_in_Scale*TotalScreenX;
FixationCenter.y_in_Pixel = FixationCenter.y_in_Scale*TotalScreenY;

StimulusDuration = condition.PresentationDuration;
xCenter =  TotalScreenX/2 + StimulusCenter.x_in_Pixel 
yCenter =  TotalScreenY/1.5 + StimulusCenter.y_in_Pixel;

Fixation_xCenter =  TotalScreenX/2 + FixationCenter.x_in_Pixel;
Fixation_yCenter =  TotalScreenY/1.5 + FixationCenter.y_in_Pixel;
Fx = Fixation_xCenter;
Fy = Fixation_yCenter;


[imageHeight, imageWidth] = size(StimulusMatrix);
dstRect = [0 0 imageWidth imageHeight];	
% Center that rectangle on the screen center
dstRect = CenterRectOnPointd(dstRect, xCenter, yCenter);



%
GapDuration =  ExperimentInfo.InputParameters.GapDuration;
FixationDuration =  ExperimentInfo.InputParameters.FixationDuration;
TrialStartInstructionScreen= ExperimentInfo.DisplayPages.TrialStartInstructionScreen;
FixationOffScreen= ExperimentInfo.DisplayPages.FixationOffScreen;
BlankScreen= ExperimentInfo.DisplayPages.BlankScreen;
%BackgroundLuminance = ExperimentInfo.DisplayInfo.BackgroundLuminance;
%Screen('FillRect',  TrialStartInstructionScreen,  BackgroundLuminance);
Window_ID = ExperimentInfo.DisplayInfo.Window_ID;


Screen('CopyWindow', BlankScreen, Window_ID);
texture = Screen('MakeTexture', Window_ID, RingMatrix);
Screen('DrawTexture', Window_ID, texture, [], dstRect);	
Screen('Flip', Window_ID);
pause(0.5);

Screen('CopyWindow', BlankScreen, Window_ID);
texture = Screen('MakeTexture', Window_ID, RingMatrix);
Screen('DrawTexture', Window_ID, texture, [], dstRect);
InstructionTextSize =TextFont_sizeXY;
Screen('TextSize', Window_ID, InstructionTextSize);
DrawFormattedText(Window_ID, 'Press any button       for the next trial', ...
    Fixation_xCenter-210, Fixation_yCenter, [0,0,0]) %5 DVA
Screen('FillOval', Window_ID, LowLuminance, ...
    [Fx-FixationSize  Fy-FixationSize  Fx+FixationSize  Fy+ FixationSize]);
%% Start Trial 

% Push Button to Start Trial
startSecs_NextTrialPrompt =Screen('Flip', Window_ID);
moveon=0;
while moveon==0; 
    start_trial; 
    FlushEvents('keyDown');
end

Screen('CopyWindow', BlankScreen, Window_ID);
texture = Screen('MakeTexture', Window_ID, RingMatrix);
Screen('DrawTexture', Window_ID, texture, [], dstRect);	
Screen('FillOval', Window_ID, LowLuminance, ...
    [Fx-FixationSize  Fy-FixationSize  Fx+FixationSize  Fy+ FixationSize]);
FixationFrame_OnsetTime  = Screen('Flip', Window_ID);

EyeTracker_Gaze_Contingent_Data=[];
if ExperimentInfo.Gaze_Contingent==1
    fixation_complete=0;
    EyeTracker_Gaze_Contingent_Data=[];
    [EyeTracker_Gaze_Contingent_Data]=Check_For_Gaze_Contingency(ExperimentInfo, Fx, Fy, EyeTracker_Gaze_Contingent_Data);
end

Screen('CopyWindow', BlankScreen, Window_ID);
texture = Screen('MakeTexture', Window_ID, StimulusMatrix);
Screen('DrawTexture', Window_ID, texture, [], dstRect);	
Screen('FillOval', Window_ID, LowLuminance, ...
    [Fx-FixationSize  Fy-FixationSize  Fx+FixationSize  Fy+ FixationSize]);

if  GapDuration>0
    Stimulus_OnsetTime =  Screen('Flip', Window_ID, ...
        BlankScreen_OnsetTime +GapDuration -0.5/ExperimentInfo.DisplayInfo.Frame_Rate);
else
    Stimulus_OnsetTime =  Screen('Flip', Window_ID, ...
        FixationFrame_OnsetTime +FixationDuration -0.5/ExperimentInfo.DisplayInfo.Frame_Rate);
end


%---- put on the mask
Screen('CopyWindow', BlankScreen, Window_ID);
Screen('FillOval', Window_ID, LowLuminance, ...
    [Fx-FixationSize  Fy-FixationSize  Fx+FixationSize  Fy+ FixationSize]);
% [imageHeight, imageWidth] = size(MaskMatrix); %MGR commented out 06/27
% because causing bug in the code 
% dstRect = [0 0 imageWidth imageHeight];
% % Center that rectangle on the screen center
% aaadstRect = CenterRectOnPointd(dstRect, xCenter, yCenter);
texture = Screen('MakeTexture', Window_ID, MaskMatrix);
Screen('DrawTexture', Window_ID, texture, [], dstRect);	



Mask_OnsetTime =  Screen('Flip', Window_ID, ...
	Stimulus_OnsetTime +StimulusDuration -0.5/ExperimentInfo.DisplayInfo.Frame_Rate); 


%% Not sure if I need this in the experimental code (MGR)
% ButtonPressed=[];
% while length(RT)==0 | RT(end)< 0  %--- if response is before the stimulus onset, wait for the next button press while record this button press
%     TakeKbCheck;
% %     [ButtonPressed, Time, EyeData]= checkanswer(ExperimentInfo)
%     FlushEvents('keyDown');
%     %--- button character pressed and its RT
%     Response_Characters = KbName(keyCode);
%     ThisRT = timeSecs-Mask_OnsetTime;
%     RT = [RT, ThisRT];
%     ButtonPressed  = [ButtonPressed  Response_Characters];
% end

ButtonsPressed=[];
%% Record responses
trialdone=0;
while trialdone==0
    % 		fs = 5000; t = 0:0.00002:0.02;
    % 	    HighToneSoundwave = sin(2*pi*fs*2*t);
    %             sound(HighToneSoundwave, fs);
    [ButtonPressed, Time, EyeData,trialdone]= checkanswer(ExperimentInfo)
    FlushEvents('keyDown');
    ThisRT = Time-Stimulus_OnsetTime;
    RT = [RT, ThisRT];
    ButtonsPressed=[ButtonsPressed, ButtonPressed];
end

   
pause(StimulusDuration_AfterResponse);

%--- Response etc Information.
%
ResponseAndMiscInfo.RT = RT;
ResponseAndMiscInfo.ButtonPressed = ButtonPressed;
ResponseAndMiscInfo.FixationDuration = round(FixationDuration*Frame_Rate)/Frame_Rate;
ResponseAndMiscInfo.GapDuration = round(GapDuration*Frame_Rate)/Frame_Rate;
ResponseAndMiscInfo.Frame_Rate = Frame_Rate;
ResponseAndMiscInfo.startSecs_NextTrialPrompt= startSecs_NextTrialPrompt;
ResponseAndMiscInfo.FixationFrame_OnsetTime = FixationFrame_OnsetTime;
ResponseAndMiscInfo.Stimulus_OnsetTime =  Stimulus_OnsetTime;
ResponseAndMiscInfo.Mask_OnsetTime =  Mask_OnsetTime;
ResponseAndMiscInfo.StimulusDuration_AfterResponse = StimulusDuration_AfterResponse;
ResponseAndMiscInfo.Eyetracking=EyeTracker_Gaze_Contingent_Data;
end
