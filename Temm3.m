%--- Response etc Information.
%
ResponseAndMiscInfo.RT = RT;
ResponseAndMiscInfo.ButtonPressed = ButtonPressed;
ResponseAndMiscInfo.FixationDuration = round(FixationDuration*FrameRate)/FrameRate;
ResponseAndMiscInfo.GapDuration = round(GapDuration*FrameRate)/FrameRate;
ResponseAndMiscInfo.FrameRate = FrameRate;
ResponseAndMiscInfo.startSecs_NextTrialPrompt= startSecs_NextTrialPrompt;
ResponseAndMiscInfo.FixationFrame_OnsetTime = FixationFrame_OnsetTime;
ResponseAndMiscInfo.Stimulus_OnsetTime =  Stimulus_OnsetTime;
ResponseAndMiscInfo.Mask_OnsetTime =  Mask_OnsetTime;
ResponseAndMiscInfo.EscapeKeyPressed = EscapeKeyPressed;
ResponseAndMiscInfo.ResponseButtonPressed = KbName(keyCode);
ResponseAndMiscInfo.StimulusDuration_AfterResponse = StimulusDuration_AfterResponse;
