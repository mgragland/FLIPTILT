function TrialType = Get_TrialType(InstructionInfo, Instruction, p)
if Instruction.Type==1 && Instruction.Direction==1 % HomoPairs + Left 
    TrialType.prob_list=[0.5, 0.5,  0, 0,  0, 0, 0, 0];
elseif Instruction.Type==1 && Instruction.Direction==2 % HomoPairs + Right 
    TrialType.prob_list= [0, 0, 0, 0, 0.5, 0.5, 0, 0];
elseif Instruction.Type==2 && Instruction.Direction==1 % HeteroPairs + Left 
    TrialType.prob_list= [0, 0,  0.5, 0.5, 0, 0, 0, 0];
elseif Instruction.Type==2 && Instruction.Direction==2 % HeteroPairs + Right
    TrialType.prob_list=[0, 0,  0, 0, 0, 0, 0.5, 0.5]; 
end

if Instruction.Location==1 % Central 
    TrialType.StimulusCenter.x_in_Scale=InstructionInfo.InputParameters.StimulusCenter_x_in_Scale(1);
    TrialType.StimulusCenter.y_in_Scale=InstructionInfo.InputParameters.StimulusCenter_y_in_Scale(1);
    TrialType.FixationCenter.x_in_Scale= InstructionInfo.InputParameters.FixationCenter_x_in_Scale(1);
    TrialType.FixationCenter.y_in_Scale= InstructionInfo.InputParameters.FixationCenter_y_in_Scale(1);
elseif Instruction.Location==2 % Left 
    TrialType.StimulusCenter.x_in_Scale=InstructionInfo.InputParameters.StimulusCenter_x_in_Scale(2);
    TrialType.StimulusCenter.y_in_Scale=InstructionInfo.InputParameters.StimulusCenter_y_in_Scale(2);
    TrialType.FixationCenter.x_in_Scale= InstructionInfo.InputParameters.FixationCenter_x_in_Scale(2);
    TrialType.FixationCenter.y_in_Scale= InstructionInfo.InputParameters.FixationCenter_y_in_Scale(2);
elseif Instruction.Location==3 % Right 
    TrialType.StimulusCenter.x_in_Scale=InstructionInfo.InputParameters.StimulusCenter_x_in_Scale(3);
    TrialType.StimulusCenter.y_in_Scale=InstructionInfo.InputParameters.StimulusCenter_y_in_Scale(3);
    TrialType.FixationCenter.x_in_Scale= InstructionInfo.InputParameters.FixationCenter_x_in_Scale(3);
    TrialType.FixationCenter.y_in_Scale= InstructionInfo.InputParameters.FixationCenter_y_in_Scale(3);
end

if p>=8
    TrialType.AddMask=1;
    TrialType.PresentationDuration=0.5;
else
    
    TrialType.AddMask=0;
    TrialType.PresentationDuration=10;
end
end

