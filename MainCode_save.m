clear all;
close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%  Give input paramters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
InputParameters = Get_InputParameters;
ExperimentInfo.InputParameters = InputParameters;

%---- Test audio volumns for feedback
ExperimentInfo.Audio = Check_Audio;
%--- Write into ExperimentInfo.SubjectInfo
ExperimentInfo.SubjectInfo = Get_SubjectInfo;

%--- Trial, block, break, numbers, etc. to append to ExperimentInfo.
ExperimentInfo = Get_ExpMiscInfo(ExperimentInfo);
KbName('UnifyKeyNames');
%
%%%%%%%%%%%%%%%%%%% set up dispaly ---------------------------------
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
%

ExperimentInfo.DisplayPages = Prepare_DisplayPages(ExperimentInfo);


% ExperimentInfo.Instructions_DoneOrNot = 'Not done';
% if ExperimentInfo.Give_InstructionOrNot ==1
%     ExperimentInfo = Give_Instructions(CRS, ExperimentInfo);
% end
% 
% %--- do trials
% %--- 

condition_index_sequence= Get_condition_index_sequence(ExperimentInfo.InputParameters.NTrials_EachCondition);
NTrials = length(condition_index_sequence);
Trial_CorrectOrNot = zeros(1, NTrials);
Trial_RT = zeros(1, NTrials);
TrialNumbersPerBlock = round(NTrials/(1+ExperimentInfo.InputParameters.NBreaks));
Window_ID = ExperimentInfo.DisplayInfo.Window_ID;
for trial = 1:NTrials
    trial
    
    condition_index =condition_index_sequence(trial);
    condition = ExperimentInfo.InputParameters.Conditions(condition_index);
    [StimulusInfo, ResponseAndMiscInfo] = DoATrial(condition, ExperimentInfo);
    disp(ResponseAndMiscInfo.ButtonPressed);
    Trial_Info(trial).StimulusInfo = StimulusInfo;
    Trial_Info(trial).ResponseAndMiscInfo=ResponseAndMiscInfo;
    if mod(trial, TrialNumbersPerBlock) ==0 & trial ~= NTrials
	InstructionScreen =  Screen('OpenOffscreenWindow', Window_ID);
	InstructionTextSize =TextFont_sizeXY;
	Screen('FillRect',  InstructionScreen,  BackgroundLuminance);
	Screen('TextSize', InstructionScreen, InstructionTextSize);
	DrawFormattedText(InstructionScreen, 'Take a break',  'center', 'center', [0, 0, 0]);
	Screen('CopyWindow', InstructionScreen, Window_ID);
	 Screen('Flip', Window_ID);	
        GoAhead = 0;
        while GoAhead ==0
            R=input('remind subject the task, and Enter c to continue', 's');
            if length(R)>0 & R =='c'
                GoAhead =1;
            end
        end
    end
end


ExperimentInfo.SubjectReport=input('please let me know any comments and observations','s');
ExperimentInfo.ExperimentalObservations=input('write down experimental observations','s');

save(fn_out);


           
           
           
           
           
           
           
           
           
           
           
           
           
