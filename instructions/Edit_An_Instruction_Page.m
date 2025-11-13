function   [This_Instruction_Page_Info, Page_Deleted_Or_Not] = Edit_An_Instruction_Page(This_Instruction_Page_Info, design)
%
num_lines = 1;
%--- initialize
Exp_prompt = [];
Exp_default_answer = [];
entry_count = 0;
%
entry_count = entry_count +1;
txt.prompt= 'Change this entry from 0 to 1 if you want to delete this instruction page (and ignore the rest of this dialog box)';
txt.default_answer= '0';
Exp_prompt = [Exp_prompt, {txt.prompt}]; Exp_default_answer = [Exp_default_answer, {txt.default_answer}];
Delete_info_index = entry_count;


%
entry_count = entry_count +1;
txt.prompt= 'Instruction Type: 1 (text with images and/or sound) or 2  (Do a demo trial)';
txt.default_answer= num2str(This_Instruction_Page_Info.Type);
Exp_prompt = [Exp_prompt, {txt.prompt}]; Exp_default_answer = [Exp_default_answer, {txt.default_answer}];
Type_index = entry_count;
%
entry_count = entry_count +1;
txt.prompt= 'enter 1 (include a RDS stimulus frame), 2 (include sound), or  3 (nothing)  for this instruction page'
txt.default_answer= num2str(This_Instruction_Page_Info.Have_Image_Sound_Or_Nothing);
Exp_prompt = [Exp_prompt, {txt.prompt}]; Exp_default_answer = [Exp_default_answer, {txt.default_answer}];
Image_Sound_Or_Nothing_index = entry_count;

%
Trial_Character = This_Instruction_Page_Info.Trial_Character;
Stimulus_character_index = zeros(1, 4);
for j = 1:4
    entry_count = entry_count +1;
    if j ==1
        temlist = design.Prob_DiskDotIsSameAcrossEyes;
        tem_txt = 'If showing a RDS stimulus frame or do a demo trial, enter an option (for binocular match probability) as ';
        txt.default_answer= num2str(Trial_Character.RDS_BinocularMatchingProb_Index);
    elseif j ==2
        temlist = design.RDS_frame_durations_in_Second;
        tem_txt = 'enter an option (for each RDS frame duration in second as  ';
        txt.default_answer= num2str(Trial_Character.RDS_FrameDuration_Index);
    elseif j ==3
        temlist = design.Stimulus_center_xy_in_Scale;
        tem_txt = 'for RDS x-y location (as fraction of window width)  enter an option ';
        txt.default_answer= num2str(Trial_Character.RDS_Location_Index);
    elseif j ==4
        tem_txt = 'enter an option 1 or -1 for disk in front or behind';
        txt.default_answer= num2str(Trial_Character.DepthOrder);
    end
    if j < 4
        max_i = length(temlist);
        if j ==3 max_i = size(temlist, 1); end
        for i= 1: max_i
            if j<3
                txt2  = [num2str(i), '(for ', num2str(temlist(i)), '), '];
            else
                txt2  = [num2str(i), '(for ', num2str(temlist(i, :)), '), '];
            end
            tem_txt = [tem_txt, txt2];
        end
    end
    txt.prompt= tem_txt;
    Exp_prompt = [Exp_prompt, {txt.prompt}]; Exp_default_answer = [Exp_default_answer, {txt.default_answer}];
    Stimulus_character_index(j) = entry_count;
end
%
Instruction =This_Instruction_Page_Info.Instruction_TextInfo;
Instruction_txt_index = zeros(1, length(Instruction));
for i  = 1:length(Instruction)
    entry_count = entry_count +1;
    if i==1
        tem_txt = 'If give instrutcion texts, ';
    else
        tem_txt = [];
    end
    tem_txt2 = sprintf('the %d-th sentence is ', i);
    tem_txt = [tem_txt, tem_txt2];
    txt.prompt= tem_txt;
    txt.default_answer = Instruction(i).txt;
    Exp_prompt = [Exp_prompt, {txt.prompt}]; Exp_default_answer = [Exp_default_answer, {txt.default_answer}];
    Instruction_txt_index(i) = entry_count;
    %
    entry_count = entry_count +1;
    tem_txt =  'its x-y location (as fraction of the window width-height ) are ';
    txt.prompt= tem_txt;
    txt.default_answer = num2str(Instruction(i).xy);
    Exp_prompt = [Exp_prompt, {txt.prompt}]; Exp_default_answer = [Exp_default_answer, {txt.default_answer}];
    Instruction_xy_index(i) = entry_count;
end


Exp_info_1=inputdlg(Exp_prompt,'Edit this instruction page', [1, 150], Exp_default_answer, 'on');

Page_Deleted_Or_Not = str2num(Exp_info_1{Delete_info_index});
if Page_Deleted_Or_Not ~=1
    
    This_Instruction_Page_Info.Type = str2num(Exp_info_1{Type_index}); %
    This_Instruction_Page_Info.Have_Image_Sound_Or_Nothing = str2num(Exp_info_1{Image_Sound_Or_Nothing_index});
    
    Trial_Character.RDS_BinocularMatchingProb_Index = str2num(Exp_info_1{Stimulus_character_index(1)});
    Trial_Character.RDS_FrameDuration_Index = str2num(Exp_info_1{Stimulus_character_index(2)});
    Trial_Character.RDS_Location_Index = str2num(Exp_info_1{Stimulus_character_index(3)});
    Trial_Character.DepthOrder = str2num(Exp_info_1{Stimulus_character_index(4)});
    
    This_Instruction_Page_Info.Trial_Character = Trial_Character;
    
    
    for  i  = 1:length(Instruction)
        Instruction(i).txt = Exp_info_1{Instruction_txt_index(i)};
        Instruction(i).xy = str2num(Exp_info_1{Instruction_xy_index(i)});
    end
    This_Instruction_Page_Info.Instruction_TextInfo = Instruction;
    
else
    This_Instruction_Page_Info =[];
end
