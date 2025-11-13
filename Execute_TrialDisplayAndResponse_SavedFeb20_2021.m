function ResponseAndMiscInfo = Execute_TrialDisplayAndResponse(CRS, StimulusMatrix, ExperimentInfo)

%----- Execute stimulus displays and repsonses.
FrameRate =  ExperimentInfo.DisplayInfo.FrameRate;
FixationDuration = ExperimentInfo.InputParameters.FixationDuration;
GapDuration = ExperimentInfo.InputParameters.GapDuration;
StimulusDuration_AfterResponse = ExperimentInfo.InputParameters.StimulusDuration_AfterResponse;
BackgroundLuminance = ExperimentInfo.DisplayInfo.BackgroundLuminance;
ResponseButtons = ExperimentInfo.ResponseButtons;
%
%
RT = []; ButtonPressed = [];
FixationToTestStimulus_Latency_InSeconds = (round(FixationDuration*FrameRate) + round(GapDuration*FrameRate))/FrameRate;

%---- 'Press any button for the next trial'
crsSetDisplayPage(ExperimentInfo.DisplayPages.NextTrialInstruction.Page);
startSecs_NextTrialPrompt = GetSecs;  %Time when the next trial prompt start

%---- Display Stuff
TestStimulusPage = ExperimentInfo.DisplayPages.TestStimulus.Page;
crsSetDrawPage(TestStimulusPage); crsClearPage(TestStimulusPage,BackgroundLuminance+1); 
crsDrawMatrixPalettised([0,0], round(StimulusMatrix)+1);                            
%---
pages = [ExperimentInfo.DisplayPages.Fixation.Page, ExperimentInfo.DisplayPages.BlankScreen.Page, TestStimulusPage];
framesEachPage = [round(FixationDuration*FrameRate), round(GapDuration*FrameRate), 1];
pagesHalt = [0, 0, 1];
pagesx = zeros(1, length(pages)); pagesy = pagesx; 
crsPageCyclingSetup(pages, pagesx, pagesy, framesEachPage, pagesHalt); %--- cycle stops 



TakeKbCheck;  FlushEvents('keyDown'); pause(0.2);
if strcmp('esc', KbName(keyCode)) ==1  % Escape key pressed
    EscapeKeyPressed =1; 
    ResponseAndMiscInfo.EscapeKeyPressed = EscapeKeyPressed;
else
    
    crsSetCommand(CRS.CYCLEPAGEENABLE);  
    startSecs_Fixation = GetSecs;  %Stimulus displayed
    startSecs_StimulusOnset = startSecs_Fixation + FixationToTestStimulus_Latency_InSeconds;
    while length(RT)==0 | RT(end)< 0  %--- if response is before the stimulus onset, wait for the next button press while record this button press
        TakeKbCheck;
        FlushEvents('keyDown');
        %--- button character pressed and its RT
        Response_Characters = KbName(keyCode);
        ThisRT = timeSecs-startSecs_StimulusOnset;
        RT = [RT, ThisRT];
        ButtonPressed = [ButtonPressed,  Response_Characters];
    end
    %--- 
    if strcmp('esc', KbName(keyCode)) ==0
        EscapeKeyPressed =0;
        while (Response_Characters(1) ~=ResponseButtons{1} &  Response_Characters(1) ~=ResponseButtons{2} )  %--- if the button response is invalid, wait for the next button press while record this button press
            if strcmp('esc', KbName(keyCode)) ==1  % Escape key pressed
                EscapeKeyPressed =1; break;
            else
                sound(ExperimentInfo.Audio.HighToneSoundwave, ExperimentInfo.Audio.fs);
                crsSetDisplayPage(ExperimentInfo.DisplayPages.Warning.Page);
                TakeKbCheck;
                FlushEvents('keyDown');
                Response_Characters = KbName(keyCode);
                ThisRT = timeSecs-startSecs_StimulusOnset;
                RT = [RT, ThisRT];
                ButtonPressed = [ButtonPressed, Response_Characters];
            end
        end
    else
        EscapeKeyPressed =1;
    end
    pause(StimulusDuration_AfterResponse);
    crsSetDisplayPage(ExperimentInfo.DisplayPages.BlankScreen.Page);
    %--- Response etc Information.
    %
    ResponseAndMiscInfo.RT = RT;
    ResponseAndMiscInfo.ButtonPressed = ButtonPressed;
    ResponseAndMiscInfo.FixationDuration = round(FixationDuration*FrameRate)/FrameRate;
    ResponseAndMiscInfo.GapDuration = round(GapDuration*FrameRate)/FrameRate;
    ResponseAndMiscInfo.FrameRate = FrameRate;
    ResponseAndMiscInfo.startSecs_NextTrialPrompt= startSecs_NextTrialPrompt;
    ResponseAndMiscInfo.startSecs_Fixation = startSecs_Fixation;
    ResponseAndMiscInfo.startSecs_StimulusOnset=startSecs_StimulusOnset;
    ResponseAndMiscInfo.FixationToTestStimulus_Latency_InSeconds = FixationToTestStimulus_Latency_InSeconds;
    ResponseAndMiscInfo.EscapeKeyPressed = EscapeKeyPressed;
    ResponseAndMiscInfo.ResponseButtonPressed = KbName(keyCode);
    ResponseAndMiscInfo.StimulusDuration_AfterResponse = StimulusDuration_AfterResponse;
end