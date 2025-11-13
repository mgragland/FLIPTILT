function   Give_OnePage_Instructions(ExperimentInfo, Instruction);

Window_ID = SetUp_Info.Window_ID;
BlackColor = SetUp_Info.BlackColor;
Window_Width = SetUp_Info.Window_rectangle(3);
Window_Height = SetUp_Info.Window_rectangle(4);

TrialType = Get_TrialType(design, a, b, c, DepthOrder);
% TrialType= prob list

StimulusInfo = Get_TrialStimulusReady(TrialType, ExperimentInfo);

[StimulusMatrix, RingMatrix] = Get_StimulusMatrixFromStimulusInfo(StimulusInfo, ...
    StimulusInfo.This_FrameInfo, ExperimentInfo.InputParameters.Cube_Images);
% Fixation Information
Screen('FillOval', Window_ID, LowLuminance, ...
    [Fx-FixationSize  Fy-FixationSize  Fx+FixationSize  Fy+ FixationSize]);
