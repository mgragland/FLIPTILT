
function [EyeTracker_Gaze_Contingent_Data] = Check_For_Gaze_Contingency(ExperimentInfo, Fx, Fy, EyeTracker_Gaze_Contingent_Data)

if ExperimentInfo.Gaze_Contingent==1
    Datapixx('StartTPxSchedule');
    Datapixx('GetTPxStatus');
    Datapixx('RegWrRd');
    Datapixx('StartDinLog');                                % Turn on logging
    Datapixx('SetMarker');
end



%% Start Logging Eye Data 
Eyetracker=1;

% Check Fixation Complete
[fixating, xeye_total, yeye_total, eyedist]=IsFixatingSquareNew_MGR(ExperimentInfo, Fx, Fy)

% Save Variables 
EyeTracker_Gaze_Contingent_Data.xeye=xeye_total;
EyeTracker_Gaze_Contingent_Data.yeye=yeye_total;
EyeTracker_Gaze_Contingent_Data.fixating=fixating;
EyeTracker_Gaze_Contingent_Data.reye=eyedist;
end