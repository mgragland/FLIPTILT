function  GiveInstructions(InstructionInfo, Instruction_Pages_Info)

for p = 1:length(Instruction_Pages_Info)
    Instruction=Instruction_Pages_Info{p};
    if InstructionInfo.Testing_Location=="LR"
        LR_Do_A_Instruction_Page(InstructionInfo, Instruction, p);
    else
        Do_A_Instruction_Page(InstructionInfo, Instruction, p);
    end
    checkescapekey
end
end

	  
