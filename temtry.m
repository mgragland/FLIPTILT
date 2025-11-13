  if ((EscapeKeyPressed_InATrial ==1 | EscapeKeyPressed_InABreak ==1) & TrainingOrTesting ==2 ) | EscapeKeyPressed_EndOfTrainingTrials ==1
        crsSetDisplayPage(ExperimentInfo.DisplayPages.EscapeOrContinueNotification.Page);
        FlushEvents('keyDown');  pause(0.5);
        TakeKbCheck; FlushEvents('keyDown'); pause(0.5); FlushEvents('keyDown');
        disp(KbName(keyCode));
        if strcmp('esc', KbName(keyCode)) ==1  % Escape key pressed
            break;
        else
            EscapeKeyPressed_EndOfTrainingTrials  =0;
            EscapeKeyPressed_InABreak=0;
            EscapeKeyPressed_InATrial=0;
        end
    end