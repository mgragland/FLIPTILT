function ResponseAndMiscInfo = Execute_TrialDisplayAndResponse(condition, ExperimentInfo)

%----- Execute stimulus displays and repsonses.
FrameRate =  ExperimentInfo.DisplayInfo.FrameRate;
FixationDuration = ExperimentInfo.InputParameters.FixationDuration;
GapDuration = ExperimentInfo.InputParameters.GapDuration;
%
ResponseButtons = ExperimentInfo.ResponseButtons;
StimulusDuration_AfterResponse=ExperimentInfo.InputParameters.StimulusDuration_AfterResponse;
%
%
RT = []; ButtonPressed = [];
FixationToTestStimulus_Latency_InSeconds = (round(FixationDuration*FrameRate) + round(GapDuration*FrameRate))/FrameRate;

%---- 'Press any button for the next trial'
crsSetDisplayPage(ExperimentInfo.DisplayPages.NextTrialInstruction.Page);
startSecs_NextTrialPrompt = GetSecs;  %Time when the next trial prompt start

AllMoviePages = repmat(MoviePages, 1, condition.StimulusDurationMultiple);
MaskPages = ExperimentInfo.DisplayPages.Mask.Page;

nframes_per_page = round(condition.PresentationPeriod*FrameRate);
nframes_mask = round(condition.MaskDuration*FrameRate);

%---
last_pagenumbers = []; last_frames = [];
count = 0; N_masks = condition.N_masks;
for rep = 1:condition.Nrepeat_MaskAndStimulus
    for i = 1:length(AllMoviePages)
        count = count +1;
        if condition.N_masks >0 & condition.AddMask ==1 & nframes_mask>0
            j = mod(count-1, N_masks)+1;
            last_pagenumbers = [last_pagenumbers, AllMoviePages(i), MaskPages(j)];
            last_frames =[last_frames, nframes_per_page, nframes_mask];
        else
            last_pagenumbers = [last_pagenumbers, AllMoviePages(i)];
            last_frames =[last_frames, nframes_per_page];
        end
    end
end
if condition.AddMask==1 & nframes_mask==0
    last_frames=  [last_frames, 1];
    last_pagenumbers =[last_pagenumbers, MaskPages(1)];
end

% last_pagenumbers = repmat(last_pagenumbers, 1, condition.Nrepeat_MaskAndStimulus);
% last_frames      =repmat(last_frames, 1, condition.Nrepeat_MaskAndStimulus);

% nFrames_MoviePages = repmat(round(condition.PresentationPeriod*FrameRate), 1, length(MoviePages));
% nFrames_MoviePages = repmat(nFrames_MoviePages, 1, condition.StimulusDurationMultiple);
% 
% 
% %------------
% last_pagenumbers = [ExperimentInfo.DisplayPages.Mask.Page, AllMoviePages];
% last_frames = [1, nFrames_MoviePages];
% 
% last_pagenumbers = repmat(last_pagenumbers, 1, condition.Nrepeat_MaskAndStimulus);
% last_frames      =repmat(last_frames, 1, condition.Nrepeat_MaskAndStimulus);
% 
% last_pagenumbers = [last_pagenumbers, ExperimentInfo.DisplayPages.Mask.Page];
% last_frames=[last_frames, 1];
%-------------    
%---   
% if condition.AddMask ==1
%     last_pagenumbers  = ExperimentInfo.DisplayPages.Mask.Page;
%     last_frames = 1;
%     if condition.AddMask_Delay >= 1/FrameRate
%         last_pagenumbers = [ExperimentInfo.DisplayPages.BlankScreen.Page, last_pagenumbers];
%         last_frames = [round(condition.AddMask_Delay*FrameRate), last_frames];
%     end
% else
%     last_pagenumbers  = ExperimentInfo.DisplayPages.BlankScreen.Page;
%     last_frames = 1;
% end


% pages = [ExperimentInfo.DisplayPages.Fixation.Page, ExperimentInfo.DisplayPages.BlankScreen.Page, AllMoviePages, last_pagenumbers];
% framesEachPage = [round(FixationDuration*FrameRate), round(GapDuration*FrameRate), nFrames_MoviePages, last_frames];
pages = [ExperimentInfo.DisplayPages.Fixation.Page, ExperimentInfo.DisplayPages.BlankScreen.Page,  last_pagenumbers];
framesEachPage = [round(FixationDuration*FrameRate), round(GapDuration*FrameRate),  last_frames];
%
pagesHalt = zeros(1, length(framesEachPage));
pagesHalt(end) = 1; %--- stop at the last page, which is the mask
pagesx = zeros(1, length(pages)); pagesy = pagesx; 
crsPageCyclingSetup(pages, pagesx, pagesy, framesEachPage, pagesHalt); %--- cycle stops 


%--- this takes the button press to start the trial.
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
    crsSetCommand(CRS.CYCLEPAGEDISABLE);
  
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
