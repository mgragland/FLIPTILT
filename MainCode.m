 clear all;
close all;              
  
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%  Give input paramters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
InputParameters = Get_InputParameters;
%Get_InputParameters;
ExperimentInfo.InputParameters = InputParameters;
       
   
%---- Test audio volumns for feedback 
ExperimentInfo.Audio = Check_Audio;
%--- Write into ExperimentInfo.SubjectInfo
ExperimentInfo.SubjectInfo = Get_SubjectInfo; 
 
%--- Trial, block, break, numbers, etc. to append to ExperimentInfo.
ExperimentInfo = Get_ExpMiscInfo(ExperimentInfo);
KbName('UnifyKeyNames');

%--- set up eye tracking if needed
if ExperimentInfo.Gaze_Contingent ==1
    EyeTracker_Info = SetUp_EyeTracker(); 
    SetUp_Info.EyeTracker_Info = EyeTracker_Info;
end
  
% Set up Response Box
if strcmp(ExperimentInfo.ResponseButtons.Type, 'ResponseBox')
    setupresponsebox
end
    
      
%  
%%%%%%%%%%%%%%%%%%% set up display ---------------------------------
ExperimentInfo.DisplayInfo = Get_DisplayInfo(ExperimentInfo);
ExperimentInfo=Update_InputParameters_ByDisplayInfo(ExperimentInfo); 

RandomNumber = sum(100*clock); rand('state',RandomNumber);
%
day = date; clocktime = clock;
fn_out =[ExperimentInfo.SubjectInfo.Name, num2str(ExperimentInfo.SubjectInfo.SessionNumber), '-', day, '-', num2str(clocktime(4)), '-', num2str(clocktime(5)), '.mat'];
%----------- Append  ExperimentInfo
ExperimentInfo.day = day;
ExperimentInfo.clocktime = clocktime;
ExperimentInfo.fn_out = fn_out;
% 
        
 
Size = ExperimentInfo.InputParameters.Size;  
Sizebar = ExperimentInfo.InputParameters.Sizebar;
ExperimentInfo.TextFont_sizeXY = round(Sizebar*ExperimentInfo.InputParameters.FontSize_To_Sizebar);
ExperimentInfo.FixationSize = round(ExperimentInfo.InputParameters.Fixation_Size_To_CubeSize_Ratio*Size);
ExperimentInfo.DisplayPages = Prepare_DisplayPages(ExperimentInfo);
Window_Width = ExperimentInfo.DisplayInfo.WindowWidthAndHeightInPixels.TotalScreenX;
Window_ID = ExperimentInfo.DisplayInfo.Window_ID;
Window_Height =ExperimentInfo.DisplayInfo.WindowWidthAndHeightInPixels.TotalScreenY;

%% Instructions  
if ExperimentInfo.Give_InstructionOrNot==1
    TrialStartInstructionScreen
    
    %% Practice
    InstructionTextSize =40;
    Screen('TextSize', Window_ID, InstructionTextSize);
    DrawFormattedText(Window_ID, 'Now we will do some practice trials. Press the right button to continue', ...
        0.1*Window_Width, 0.1*Window_Height, [0,0,0])
    Screen('Flip', Window_ID);
    Wait_For_RightArrowKey
    addpath('practice')
    accuracy=0;
    while accuracy<0.8
        practice_trials;
    end
    move_on_from_practice
end

%% Testing Trials 
condition_index_sequence= Get_condition_index_sequence(ExperimentInfo.InputParameters.NTrials_EachCondition);
NTrials = length(condition_index_sequence);
Trial_CorrectOrNot = zeros(1, NTrials); 
Trial_RT = zeros(1, NTrials); 
TrialNumbersPerBlock = round(NTrials/(1+ExperimentInfo.InputParameters.NBreaks));
Window_ID = ExperimentInfo.DisplayInfo.Window_ID;

for trial = 1:NTrials
    HideCursor
    trial
    if trial==NTrials/4 | trial==(NTrials/2) | trial==((3*NTrials/4))
        rest_break
    end

    condition_index =condition_index_sequence(trial);
    condition = ExperimentInfo.InputParameters.Conditions(condition_index);

    StimulusInfo = Get_TrialStimulusReady(condition, ExperimentInfo);
    
    [StimulusMatrix, RingMatrix] = Get_StimulusMatrixFromStimulusInfo(StimulusInfo, ...
        StimulusInfo.This_FrameInfo, ExperimentInfo.InputParameters.Cube_Images);
    if StimulusInfo.condition.AddMask ==1
        MaskMatrix = Get_MaskMatrixFromStimulusInfo(StimulusInfo, StimulusInfo.This_MaskInfo);
    else
    MaskMatrix = [];
end


ResponseAndMiscInfo = Execute_Trial(StimulusMatrix, MaskMatrix, RingMatrix, condition, ExperimentInfo, trial);
    
Trial_Info(trial).StimulusInfo = StimulusInfo;
Trial_Info(trial).ResponseAndMiscInfo=ResponseAndMiscInfo;

end

sca; 


ExperimentInfo.SubjectReport=input('please let me know any comments and observations','s');
ExperimentInfo.ExperimentalObservations=input('write down experimental observations','s');
save(fn_out);




           
           
           
           
           
           
           
           
           
           
           
           
           
