function [StimulusInfo, ResponseAndMiscInfo] = DoATrial(condition, ExperimentInfo)

StimulusInfo = Get_TrialStimulusReady(condition, ExperimentInfo);

  [StimulusMatrix, RingMatrix] = Get_StimulusMatrixFromStimulusInfo(StimulusInfo, ...
		StimulusInfo.This_FrameInfo, ExperimentInfo.InputParameters.Cube_Images);
if StimulusInfo.condition.AddMask ==1
    MaskMatrix = Get_MaskMatrixFromStimulusInfo(StimulusInfo, StimulusInfo.This_MaskInfo);
else
    MaskMatrix = [];	
end


ResponseAndMiscInfo = Execute_Trial(StimulusMatrix, MaskMatrix, RingMatrix, condition, ExperimentInfo);
return;
if ExperimentInfo.Debugging_Mode ==1
    disp(ResponseAndMiscInfo);
end
                            
