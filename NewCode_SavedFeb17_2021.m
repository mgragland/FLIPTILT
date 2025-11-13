clear all;
close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%  Give input paramters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%---------- First get InputParameters, a structure with many things
ExperimentInfo.InputParameters = Get_InputParameters;   %---- this file Get_InputParameters.m is used for editting convenience.
%
%%%%%%%%%%%%%%%% Other kinds of inputs by dialog boxes --------------------------------------
%
%---- Test audio volumns for feedback
ExperimentInfo.Audio = Check_Audio;

%--- Write into ExperimentInfo.SubjectInfo
ExperimentInfo.SubjectInfo = Get_SubjectInfo;

%--- Trial, block, break, numbers, etc. to append to ExperimentInfo.
ExperimentInfo = Get_ExpMiscInfo(ExperimentInfo);
%
KbName('UnifyKeyNames');
%
%%%%%%%%%%%%%%%%%%% set up dispaly ---------------------------------
[CRS, ExperimentInfo.DisplayInfo] = Get_DisplayInfo(ExperimentInfo.InputParameters);

%%%%%%%%%%%%%%%%%%%%%%%%%%%% Get Stimulus Cubes, and NewConditions_ForExp, and NewAllCubes, NewItemTypes,  Size, Sizebar, 
ExperimentInfo.StimulusItems_Sizes_Conditions=GetNewItemTypesAndAllCubes(ExperimentInfo);

RandomNumber = sum(100*clock); rand('state',RandomNumber);
%
day = date; clocktime = clock;
fn_out =[ExperimentInfo.SubjectInfo.Name, num2str(ExperimentInfo.SubjectInfo.SessionNumber), '-', day, '-', num2str(clocktime(4)), '-', num2str(clocktime(5)), '.mat'];
%----------- Append  ExperimentInfo
ExperimentInfo.day = day;
ExperimentInfo.clocktime = clocktime;
ExperimentInfo.fn_out = fn_out;
%
Size = ExperimentInfo.StimulusItems_Sizes_Conditions.Size;
Sizebar = ExperimentInfo.StimulusItems_Sizes_Conditions.Sizebar;
ExperimentInfo.TextFont_sizeXY = [round(Sizebar*ExperimentInfo.InputParameters.FontSize_To_Sizebar),round(1.5*Sizebar*ExperimentInfo.InputParameters.FontSize_To_Sizebar)];
ExperimentInfo.FixationSize = round(ExperimentInfo.InputParameters.Fixation_Size_To_CubeSize_Ratio*Size);
%
ExperimentInfo.DisplayPages = Prepare_DisplayPages(CRS, ExperimentInfo);


%
ExperimentInfo.Instructions_DoneOrNot = 'Not done';
if ExperimentInfo.Give_InstructionOrNot ==1
    ExperimentInfo = Give_Instructions(CRS, ExperimentInfo);
end

%--- do trials

%
trial = 0;
TrainingOrTesting =1;
InstructionPage = ExperimentInfo.DisplayPages.Instruction.Page;
BackgroundLuminance = ExperimentInfo.DisplayInfo.BackgroundLuminance;
EscapeKeyPressed_EndOfTrainingTrials  =0;
EscapeKeyPressed_InABreak=0;
EscapeKeyPressed_InATrial=0;
while TrainingOrTesting  <=2
    if TrainingOrTesting ==1
        NTrialsEach = ExperimentInfo.NTrialsEachConditionTraining;   NBlocks = 1;
    else
        NTrialsEach = ExperimentInfo.NTrialsEachCondition;           NBlocks = ExperimentInfo.NumberOfBlocks;
        NumBreaks = ExperimentInfo.NumBreaks;
    end
    [Condition_Sequence, ItemType_Sequence, Side_Sequence] = Get_ThreeSequenceLists(ExperimentInfo.StimulusItems_Sizes_Conditions.NewConditions_ForExp, NTrialsEach, NBlocks);
    %--- Condition_sequence(i) give the condition index of the ith trial
    %--- ItemType_Sequence(i) give the ItemType index of the ith trial, such that, with 
    %------- a =  ItemType_Sequence(i),  the target and two types of distractors
    %---- in this trial is NewItemTypes(a, b), with b = 1 for target, b = 2, 3 for the two distractor type.
    %---  and its appearance is specified by the Size x Size matrix NewAllCubes(NewItemTypes(a, b), :, :) 
    %--- Size_Sequence(i) = 1 or 2 to indicate whether the target is in the left or right half of the search image.	
    NTrials = length(Condition_Sequence);
    if (TrainingOrTesting ==1 & trial ==0) |  TrainingOrTesting ==2
        crsSetDrawPage(InstructionPage); crsClearPage(InstructionPage,BackgroundLuminance+1);
        if TrainingOrTesting ==1 
            crsDrawString([0, 0], 'Enter c to continue to some practice trials');    
        else
            crsDrawString([0, 0], 'Enter c to continue to testing trials');   
        end
        crsSetDisplayPage(InstructionPage);
        TakeKbCheck; FlushEvents('keyDown'); pause(0.5); FlushEvents('keyDown');
        while strcmp('c', KbName(keyCode)) ~=1 
            TakeKbCheck; FlushEvents('keyDown'); pause(0.5); FlushEvents('keyDown');
        end
    end
    for this_trial = 1:NTrials  %--- a sequence of NTrials for training or testing.
        trial = trial +1;
        This_Condition = Condition_Sequence(this_trial);
        This_ItemType = ItemType_Sequence(this_trial);
        This_Target_LateralSide = Side_Sequence(this_trial);
        %
        BlockNumber = ceil(this_trial/sum(NTrialsEach));
        WithinBlock_TrialNumber = this_trial -(BlockNumber-1)*sum(NTrialsEach);
        txt  = sprintf('trial %d, in block %d of %d blocks ', WithinBlock_TrialNumber, BlockNumber,  NBlocks);
        if TrainingOrTesting ==1
            txt = [txt, 'in training trials'];
        else 
            txt  =[txt, 'in testing trials'];
        end
        disp(txt);
        
        [StimulusInfo, ResponseAndMiscInfo] = DoATrial(CRS, This_Condition, This_ItemType, This_Target_LateralSide, ExperimentInfo);
        %
        TrialData{trial}.StimulusInfo = StimulusInfo;
        TrialData{trial}.ResponseAndMiscInfo = ResponseAndMiscInfo;    
        TrialData{trial}.TrainingOrTesting = TrainingOrTesting;
        TrialData{trial}.trial_number = trial;
        %
        EscapeKeyPressed_InATrial = 0;
        if ResponseAndMiscInfo.EscapeKeyPressed ==1
            crsSetDrawPage(InstructionPage); crsClearPage(InstructionPage,BackgroundLuminance+1);
            crsDrawString([0, 0], 'Escape pressed in a trial, press Escape again to confirm and terminate this sequence of trials, or another key to cointinue');    
            crsSetDisplayPage(InstructionPage);
            TakeKbCheck; FlushEvents('keyDown'); pause(0.5); FlushEvents('keyDown');
            if strcmp('esc', KbName(keyCode)) ==1  % Escape key pressed
                EscapeKeyPressed_InATrial = 1;
                disp('Escape pressed in a trial, skipping the remaining trials in this training or testing trial sequence');
                break;
            end
        end
        
        if  (TrainingOrTesting ==1 | ExperimentInfo.GiveFeedbackOrNot ==1 ) &  isfield(ResponseAndMiscInfo, 'ButtonPressed') ==1%--- give feedback
            ButtonPressed = ResponseAndMiscInfo.ButtonPressed;
            ResponseButtons =  ExperimentInfo.ResponseButtons;
            if (ButtonPressed(end) == ResponseButtons{1} & This_Target_LateralSide ==1) | ...
                    (ButtonPressed(end) == ResponseButtons{2} & This_Target_LateralSide ==2)
                sound(ExperimentInfo.Audio.LowToneSoundwave, ExperimentInfo.Audio.fs);
            else
                sound(ExperimentInfo.Audio.HighToneSoundwave, ExperimentInfo.Audio.fs);
            end
        end
        pause(0.2);
        FlushEvents('keyDown');
        if TrainingOrTesting ==2 & mod(this_trial, ceil(NTrials/(NumBreaks+1))) ==0  & this_trial < NTrials
            %--- take a break    
            save(ExperimentInfo.fn_out);
            crsSetDrawPage(InstructionPage); crsClearPage(InstructionPage,BackgroundLuminance+1);
            crsDrawString([0, 0], 'Taking a break, enter c to continue to further trials, press Escape to terminate the session');    
            crsSetDisplayPage(InstructionPage);
            TemChar = 't';
            EscapeKeyPressed_InABreak  =0;
            while TemChar ~= 'c'
                TakeKbCheck; FlushEvents('keyDown'); pause(0.5); FlushEvents('keyDown');
                TemChar = KbName(keyCode);
                if strcmp('esc', KbName(keyCode)) ==1  % Escape key pressed
                    crsSetDrawPage(InstructionPage); crsClearPage(InstructionPage,BackgroundLuminance+1);
                    crsDrawString([0, 0], 'Escape pressed at break, press Escape again to confirm skipping the remaining trials, or another key to cointinue');    
                    crsSetDisplayPage(InstructionPage);
                    TakeKbCheck; FlushEvents('keyDown'); pause(0.5); FlushEvents('keyDown');
                    if strcmp('esc', KbName(keyCode)) ==1  % Escape key pressed
                        EscapeKeyPressed_InABreak  =1;
                        disp('Escape entered at the break, skipping the remaining trials');
                        break;
                    end
                end
            end
        end 
        if EscapeKeyPressed_InATrial ==1 | EscapeKeyPressed_InABreak ==1
                  break;
        end     
    end
    save(ExperimentInfo.fn_out);
    %
    if TrainingOrTesting ==1   
        %--- ask if to repeat training
        crsSetDrawPage(InstructionPage); crsClearPage(InstructionPage,BackgroundLuminance+1);
        crsDrawString([0, 0], 'Enter r for another round of training trials, enter p to proceed to testing trials, press Escape to terminate session');     
        crsSetDisplayPage(InstructionPage);
        EscapeKeyPressed_EndOfTrainingTrials  =0;
        TemChar = 't';
        while TemChar ~= 'r' & TemChar ~= 'p'
            TakeKbCheck; FlushEvents('keyDown'); pause(0.5); FlushEvents('keyDown');
            TemChar = KbName(keyCode);
            if KbName(keyCode) =='r' TrainingOrTesting=0; 
            elseif KbName(keyCode) =='p' ; 
            elseif strcmp('esc', KbName(keyCode)) ==1  % Escape key pressed
                crsSetDrawPage(InstructionPage); crsClearPage(InstructionPage,BackgroundLuminance+1);
                crsDrawString([0, 0], 'Escape pressed after training trials, press Escape again to confirm and terminate the session, or another key to cointinue');    
                crsSetDisplayPage(InstructionPage);
                TakeKbCheck; FlushEvents('keyDown'); pause(0.5); FlushEvents('keyDown');
                if strcmp('esc', KbName(keyCode)) ==1  % Escape key pressed
                    disp('At the end of the training trials, and terminating the session');
                    EscapeKeyPressed_EndOfTrainingTrials =1;
                    break;
                end
            end
        end
    end
    if ((EscapeKeyPressed_InATrial ==1 | EscapeKeyPressed_InABreak ==1) & TrainingOrTesting ==2 ) | EscapeKeyPressed_EndOfTrainingTrials ==1
        break;
    end
    TrainingOrTesting   = TrainingOrTesting+1;
    save(ExperimentInfo.fn_out);
end

Ending;  %--- save data, and enter subject report, and experimenter reports.
