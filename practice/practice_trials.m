addpath('practice')

PracticeInfo=ExperimentInfo;
PracticeInfo.InputParameters.NTrials_EachCondition=[2,1,2,1,2,1]

for i=1:length(PracticeInfo.InputParameters.NTrials_EachCondition)
    PracticeInfo.InputParameters.Conditions(i).PresentationDuration=2;
end
    
practice_condition_index_sequence= Get_condition_index_sequence(PracticeInfo.InputParameters.NTrials_EachCondition);
NTrials = length(practice_condition_index_sequence);
Trial_CorrectOrNot = zeros(1, NTrials);
Trial_RT = zeros(1, NTrials);
TrialNumbersPerBlock = round(NTrials/(1+PracticeInfo.InputParameters.NBreaks));
Window_ID = PracticeInfo.DisplayInfo.Window_ID;

for trial = 1:NTrials
    trial

    condition_index =practice_condition_index_sequence(trial);
    condition = PracticeInfo.InputParameters.Conditions(condition_index);

    StimulusInfo = Get_TrialStimulusReady(condition, PracticeInfo);
    
    [StimulusMatrix, RingMatrix] = Get_StimulusMatrixFromStimulusInfo(StimulusInfo, ...
        StimulusInfo.This_FrameInfo, PracticeInfo.InputParameters.Cube_Images);
    if StimulusInfo.condition.AddMask ==1
        MaskMatrix = Get_MaskMatrixFromStimulusInfo(StimulusInfo, StimulusInfo.This_MaskInfo);
    else
    MaskMatrix = [];
end


ResponseAndMiscInfo = Execute_Trial(StimulusMatrix, MaskMatrix, RingMatrix, condition, PracticeInfo, trial);
    
Practice_Trial_Info(trial).StimulusInfo = StimulusInfo;
Practice_Trial_Info(trial).ResponseAndMiscInfo=ResponseAndMiscInfo;

end
InstructionTextSize =40;
Screen('TextSize', Window_ID, InstructionTextSize);
DrawFormattedText(Window_ID, 'Great job! Do you have any questions before proceeding?', ...
    0.1*Window_Width, 0.1*Window_Width, [0,0,0])
Screen('Flip', Window_ID);
Wait_For_RightArrowKey
DrawFormattedText(Window_ID, 'We will now move on to the testing trials. Press the right button', ...
    0.1*Window_Width, 0.1*Window_Width, [0,0,0])
Screen('Flip', Window_ID);
Wait_For_RightArrowKey;


