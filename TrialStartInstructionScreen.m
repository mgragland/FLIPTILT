addpath('instructions')
InstructionInfo=ExperimentInfo; 
if ExperimentInfo.Testing_Location=="LR"
    Instruction_Pages_Info = LR_Set_InstructionContent
else
    Instruction_Pages_Info = Set_InstructionContent
end

InstructionTextSize =40;
Screen('TextSize', Window_ID, InstructionTextSize);
DrawFormattedText(Window_ID, 'Hi! Welcome to the Flip-Tilt Task', ...
    0.35*Window_Width, 0.1*Window_Height, [0,0,0])
Screen('Flip', Window_ID);
HideCursor
Wait_For_RightArrowKey
GiveInstructions(InstructionInfo, Instruction_Pages_Info)
