function ExperimentInfo = Give_Instructions(CRS, ExperimentInfo)


Terminate_Instruction = 0;
Instructions_Page= ExperimentInfo.InputParameters.Instructions_Page;
Instructions_Page_xy = ExperimentInfo.InputParameters.Instructions_Page_xy;
Size= ExperimentInfo.InputParameters.Size;
InstructionPage = ExperimentInfo.DisplayPages.Instruction.Page;
TextFont_sizeXY = ExperimentInfo.TextFont_sizeXY;
BackgroundLuminance = ExperimentInfo.DisplayInfo.BackgroundLuminance;
LowLuminance = ExperimentInfo.DisplayInfo.LowLuminance;
HighLuminance = ExperimentInfo.DisplayInfo.HighLuminance;
%
TotalScreenY = ExperimentInfo.DisplayInfo.WindowWidthAndHeightInPixels.TotalScreenY;

%
crsSetStringMode(TextFont_sizeXY,CRS.ALIGNCENTRETEXT,CRS.ALIGNCENTRETEXT,0,CRS.FONTNORMAL);


%----------------- Instructions ---------------------------------------
Inter_Item_Distance_Instruction = ExperimentInfo.InputParameters.Instructions_Inter_Item_Distance_To_Size*Size;  %%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%% First page, showing the task.
crsSetDrawPage(InstructionPage); crsClearPage(InstructionPage,BackgroundLuminance+1);
crsSetDisplayPage(InstructionPage);
FlushEvents('keyDown');
%--- targets and distractors displayed on screen 
for TargetOrDistractors = 1:2
    if TargetOrDistractors ==1
        ShowCubeIndices = unique(NewItemTypes(:, 1));  %--- Target
    else
        ShowCubeIndices = unique([NewItemTypes(:, 2); NewItemTypes(:, 3)]); %--- non targets.
    end
    Center_y = round(Instructions_Center_y_TargetDistractor_Factors(TargetOrDistractors)*TotalScreenY);
    for t = 1:length(ShowCubeIndices)
        Center_x = (t-(length(ShowCubeIndices)+1)/2)*Inter_Item_Distance_Instruction;
        CubeMatrix = squeeze(NewAllCubes(ShowCubeIndices(t), :, :))*(HighLuminance-LowLuminance) + LowLuminance;
        crsDrawMatrixPalettised([Center_x, Center_y], round(CubeMatrix)+1);
    end
end
for Instruction_Sentence = 1:length(Instructions_Page{1})
    crsDrawString(Instructions_Page_xy{1}(Instruction_Sentence, :), Instructions_Page{1}{Instruction_Sentence});
    pause(1.0);
    TakeKbCheck; FlushEvents('keyDown');
    disp('Enter return to continue');
    while strcmp('return', KbName(keyCode)) ==0
         if strcmp('esc', KbName(keyCode)) ==1
             Terminate_Instruction = 1;
             break;
         end
         disp(['this is entered ', KbName(keyCode)]);
        TakeKbCheck; FlushEvents('keyDown');
    end
    if Terminate_Instruction ==1
        break;
    end
end


% %%%%%%%%%%%%%%%%%%%%%%%%%%%% Second page, show some examples from the training trials. until Escape button is pressed.
if Terminate_Instruction ==0
    
    trial = 0; Show_StimulusExamples = 1;
    disp('Enter to show the first example search image, Escape to skip examples');
    TakeKbCheck; FlushEvents('keyDown');
    while strcmp('esc', KbName(keyCode)) ==0 &  strcmp('return', KbName(keyCode)) ==0
        disp(['this is entered ', KbName(keyCode)]);
        TakeKbCheck; FlushEvents('keyDown');
    end
    if strcmp('esc', KbName(keyCode)) ==1
        Show_StimulusExamples=0;
    else
        crsSetDrawPage(InstructionPage); crsClearPage(InstructionPage,BackgroundLuminance+1);
        crsDrawString([0,0], 'Let us see some search image examples');
        crsSetDisplayPage(InstructionPage);
        pause(1.0);
    end
    while Show_StimulusExamples==1
        NTrialsEach = ExperimentInfo.NTrialsEachConditionTraining;   NBlocks = 1;
        [Condition_Sequence, ItemType_Sequence, Side_Sequence] = Get_ThreeSequenceLists(ExperimentInfo.StimulusItems_Sizes_Conditions.NewConditions_ForExp, NTrialsEach, NBlocks);
        NTrials = length(Condition_Sequence);
        for this_trial = 1:NTrials
            crsClearPage(InstructionPage,BackgroundLuminance+1);
            trial = trial +1;
            This_Condition = Condition_Sequence(this_trial);
            This_ItemType = ItemType_Sequence(this_trial);
            This_Target_LateralSide = Side_Sequence(this_trial);
            %--- get StimulusMatrix
            [StimulusMatrix, StimulusInfo]  = Get_TrialStimulusReady(This_Condition, This_ItemType, This_Target_LateralSide, ExperimentInfo);
            crsClearPage(InstructionPage,BackgroundLuminance+1); 
            crsDrawMatrixPalettised([0,0], round(StimulusMatrix)+1);  
            Instructions_StimulusExamples{trial}.StimulusInfo = StimulusInfo;
            disp('Enter to show the next example search image, Escape to terminate examples');
            TakeKbCheck; FlushEvents('keyDown');
            while strcmp('esc', KbName(keyCode)) ==0 &  strcmp('return', KbName(keyCode)) ==0
                disp(['this is entered ', KbName(keyCode)]);
                TakeKbCheck; FlushEvents('keyDown');
            end
            if strcmp('esc', KbName(keyCode)) ==1
                Show_StimulusExamples =0;
                break;
            end
        end
    end
    if trial > 0
        ExperimentInfo.Instructions_StimulusExamples = Instructions_StimulusExamples;   
    else
        ExperimentInfo.Instructions_StimulusExamples ={};
    end
end

%--- Show next trial prompt, fixation, pages. 
if Terminate_Instruction ==0
    disp('Now instructions on the events in a trial');
    Instructions_TrialEvents_txts = ExperimentInfo.InputParameters.Instructions_TrialEvents_txts;
    crsClearPage(InstructionPage,BackgroundLuminance+1); 
    for Instruction_Sentence = 1:length(Instructions_Page{2})
        crsDrawString(Instructions_Page_xy{2}(Instruction_Sentence, :), Instructions_Page{2}{Instruction_Sentence});
        crsSetDisplayPage(InstructionPage);
        pause(1.0);
        disp('Enter return to continue');
        TakeKbCheck; FlushEvents('keyDown');
        
        while strcmp('return', KbName(keyCode)) ==0
            if strcmp('esc', KbName(keyCode)) ==1
                Terminate_Instruction = 1;
                break;
            end
            disp(['this is entered ', KbName(keyCode)]);
            TakeKbCheck; FlushEvents('keyDown');
        end
        if Terminate_Instruction ==1
            break;
        end
        eval(Instructions_TrialEvents_txts{Instruction_Sentence});
        pause(0.5);
        if length(Instructions_TrialEvents_txts{Instruction_Sentence})>0
            TakeKbCheck; FlushEvents('keyDown');
            disp('Enter return to continue');
            while strcmp('return', KbName(keyCode)) ==0
                if strcmp('esc', KbName(keyCode)) ==1
                    Terminate_Instruction = 1;
                    break;
                end
                disp(['this is entered ', KbName(keyCode)]);
                TakeKbCheck; FlushEvents('keyDown');
            end
        end
         if Terminate_Instruction ==1
            break;
        end
    end
end

%----
if Terminate_Instruction ==0
    crsSetDrawPage(InstructionPage); crsClearPage(InstructionPage,BackgroundLuminance+1);
    crsDrawString([0, 0], 'Let us see one or more example of a search trial');
    crsSetDisplayPage(InstructionPage);
    % %%%%%%%%%%%%%%%%%%%%%%%%%%%% Second page, show some examples from the training trials. until Escape button is pressed.
    trial = 0; Show_TrialExamples = 1;
    while Show_TrialExamples==1
        NTrialsEach = ExperimentInfo.NTrialsEachConditionTraining;   NBlocks = 1;
        [Condition_Sequence, ItemType_Sequence, Side_Sequence] = Get_ThreeSequenceLists(ExperimentInfo.StimulusItems_Sizes_Conditions.NewConditions_ForExp, NTrialsEach, NBlocks);
        NTrials = length(Condition_Sequence);
        for this_trial = 1:NTrials
            crsClearPage(InstructionPage,BackgroundLuminance+1);
            if trial ==0
                disp('Enter for the first example trial, Escape to skip examples');
            else
                disp('Enter to show the next example trial, Escape to terminate examples');
            end
            TakeKbCheck; FlushEvents('keyDown');
            while strcmp('esc', KbName(keyCode)) ==0 &  strcmp('return', KbName(keyCode)) ==0
                disp(['this is entered ', KbName(keyCode)]);
                TakeKbCheck; FlushEvents('keyDown');
            end
            if strcmp('esc', KbName(keyCode)) ==1
                Show_TrialExamples =0;
                break;
            else
                trial = trial +1;
                This_Condition = Condition_Sequence(this_trial);
                This_ItemType = ItemType_Sequence(this_trial);
                This_Target_LateralSide = Side_Sequence(this_trial);
                %
                [StimulusInfo, ResponseAndMiscInfo] = DoATrial(CRS, This_Condition, This_ItemType, This_Target_LateralSide, ExperimentInfo);
                %
                ExampleTrialData{trial}.StimulusInfo = StimulusInfo;
                ExampleTrialData{trial}.ResponseAndMiscInfo = ResponseAndMiscInfo;    
                if ResponseAndMiscInfo.EscapeKeyPressed ==1
                    Show_TrialExamples =0;
                    break;
                end
                %--- give beep feedback
                if isfield(ResponseAndMiscInfo, 'ButtonPressed') ==1%--- give feedback
                    ButtonPressed = ResponseAndMiscInfo.ButtonPressed;
                    ResponseButtons =  ExperimentInfo.ResponseButtons;
                    if (ButtonPressed(end) == ResponseButtons{1} & This_Target_LateralSide ==1) | ...
                            (ButtonPressed(end) == ResponseButtons{2} & This_Target_LateralSide ==2)
                        sound(ExperimentInfo.Audio.LowToneSoundwave, ExperimentInfo.Audio.fs);
                    else
                        sound(ExperimentInfo.Audio.HighToneSoundwave, ExperimentInfo.Audio.fs);
                    end
                end %-----------------------------
            end
        end
    end
    if trial > 0
        ExperimentInfo.Instructions_ExampleTrialData = ExampleTrialData;
    else
        ExperimentInfo.Instructions_ExampleTrialData = {};
    end
end
if Terminate_Instruction ==1
    ExperimentInfo.Instructions_DoneOrNot  = 'Terminated';
else
    ExperimentInfo.Instructions_DoneOrNot  = 'Done';
end