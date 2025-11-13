function   Instruction_Pages_Info = Set_InstructionContent

Page_count = 0;
	%------------- first page of instruction
	InstructionTrial.Type = 1;  % 1= HomoTrial 2= HeteroTrial
    InstructionTrial.Location= 1; %1=Central %2= Peripheral 
    InstructionTrial.Direction= 1; %1=Left % Right 
	Instruction(1).txt = 'During this task, you will see images like this, a collection of paired-dots within a disk surface.'
	Instruction(1).xy = [0.1, 0.1];
	Instruction(2).txt = 'Your task is to report whether the paired dots are tilted to the left or right.'
	Instruction(2).xy = [0.1, 0.1];
	Instruction(3).txt = 'Tell me what you see in this example, are the paired-dots tilted to the left or right?';
	Instruction(3).xy = [0.1, 0.1];
	%	
	This_Instruction_Page_Info.Type = InstructionTrial.Type; 
	This_Instruction_Page_Info.Location = InstructionTrial.Location; 
    This_Instruction_Page_Info.Direction = InstructionTrial.Direction;
	This_Instruction_Page_Info.Instruction_TextInfo = Instruction; 

	Page_count = Page_count+1;
	Instruction_Pages_Info{Page_count} =This_Instruction_Page_Info;
 
	
	%% --- second page of instruction, modify whatever needs to be modified from the last page
	clear Instruction;
    InstructionTrial.Type = 1;  % 1= HomoTrial 2= HeteroTrial
    InstructionTrial.Location= 1; %1=Central %2= Peripheral 
    InstructionTrial.Direction= 2; %1=Left % Right 
	Instruction(1).txt = 'Here is another example. What direction are the paired-dots tilted?';
	Instruction(1).xy = [0.1, 0.1];
		This_Instruction_Page_Info.Type = InstructionTrial.Type; 
	This_Instruction_Page_Info.Location = InstructionTrial.Location; 
    This_Instruction_Page_Info.Direction = InstructionTrial.Direction;
	This_Instruction_Page_Info.Instruction_TextInfo = Instruction; 

	Page_count = Page_count+1;
	Instruction_Pages_Info{Page_count} =This_Instruction_Page_Info;
    
    %% --- third page of instruction, modify whatever needs to be modified from the last page
    clear Instruction;
    InstructionTrial.Type = 1;  % 1= HomoTrial 2= HeteroTrial
    InstructionTrial.Location= 1; %1=Central %2= Peripheral
    InstructionTrial.Direction= 2; %1=Left % Right
    Instruction(1).txt = 'Sometimes the dot pairs are the same color';
    Instruction(1).xy = [0.1, 0.1];
    This_Instruction_Page_Info.Type = InstructionTrial.Type;
    This_Instruction_Page_Info.Location = InstructionTrial.Location;
    This_Instruction_Page_Info.Direction = InstructionTrial.Direction;
    This_Instruction_Page_Info.Instruction_TextInfo = Instruction;
    
    Page_count = Page_count+1;
    Instruction_Pages_Info{Page_count} =This_Instruction_Page_Info;

     %% --- Fourth page of instruction, modify whatever needs to be modified from the last page
    clear Instruction;
    InstructionTrial.Type = 2;  % 1= HomoTrial 2= HeteroTrial
    InstructionTrial.Location= 1; %1=Central %2= Peripheral
    InstructionTrial.Direction= 2; %1=Left % Right
    Instruction(1).txt = 'And sometimes the dot pairs are the different colors';
    Instruction(1).xy = [0.1, 0.1];

  
   This_Instruction_Page_Info.Type = InstructionTrial.Type; 
	This_Instruction_Page_Info.Location = InstructionTrial.Location; 
    This_Instruction_Page_Info.Direction = InstructionTrial.Direction;
	This_Instruction_Page_Info.Instruction_TextInfo = Instruction; 

    Page_count = Page_count+1;
    Instruction_Pages_Info{Page_count} =This_Instruction_Page_Info;
    
    %% --- Fifth page of instruction, modify whatever needs to be modified from the last page
    clear Instruction;
    InstructionTrial.Type = 1;  % 1= HomoTrial 2= HeteroTrial
    InstructionTrial.Location= 1; %1=Central %2= Peripheral
    InstructionTrial.Direction= 2; %1=Left % Right
    Instruction(1).txt = 'Finally, sometimes the fixation dot will move locations.';
    Instruction(1).xy = [0.1, 0.1];
    Instruction(2).txt = 'Sometimes it is presented in the center.';
    Instruction(2).xy = [0.1, 0.1];
    This_Instruction_Page_Info.Type = InstructionTrial.Type; 
	This_Instruction_Page_Info.Location = InstructionTrial.Location; 
    This_Instruction_Page_Info.Direction = InstructionTrial.Direction;
	This_Instruction_Page_Info.Instruction_TextInfo = Instruction; 

    Page_count = Page_count+1;
    Instruction_Pages_Info{Page_count} =This_Instruction_Page_Info;
    

     %%--- Sixth page of instruction, modify whatever needs to be modified from the last page
    clear Instruction;
    InstructionTrial.Type = 1;  % 1= HomoTrial 2= HeteroTrial
    InstructionTrial.Location= 2; %1=Central %2= Peripheral
    InstructionTrial.Direction= 2; %1=Left % Right
    Instruction(1).txt = 'And sometimes the fixation dot moves to the top of the screen'
    Instruction(1).xy = [0.1, 0.1];
    Instruction(2).txt = 'The text will help remind you where to move your eyes';
    Instruction(2).xy = [0.1, 0.1];
    
    This_Instruction_Page_Info.Type = InstructionTrial.Type; 
	This_Instruction_Page_Info.Location = InstructionTrial.Location;
    This_Instruction_Page_Info.Direction = InstructionTrial.Direction;
	This_Instruction_Page_Info.Instruction_TextInfo = Instruction; 
    
    Page_count = Page_count+1;
    Instruction_Pages_Info{Page_count} =This_Instruction_Page_Info;
   
    
    %% --- 7th page of instruction, modify whatever needs to be modified from the last page
    clear Instruction;
    InstructionTrial.Type = 1;  % 1= HomoTrial 2= HeteroTrial
    InstructionTrial.Location= 1; %1=Central %2= Peripheral
    InstructionTrial.Direction= 2; %1=Left % Right
    Instruction(1).txt = 'You must keep your gaze on the fixation dot'
    Instruction(1).xy = [0.1, 0.1];
    Instruction(2).txt = 'If you move your eyes, your answer will not count';
    Instruction(2).xy = [0.1, 0.1];
   
    This_Instruction_Page_Info.Type = InstructionTrial.Type; 
	This_Instruction_Page_Info.Location = InstructionTrial.Location;
    This_Instruction_Page_Info.Direction = InstructionTrial.Direction;
	This_Instruction_Page_Info.Instruction_TextInfo = Instruction; 
    
    Page_count = Page_count+1;
    Instruction_Pages_Info{Page_count} =This_Instruction_Page_Info;
     
    %% --- 8th page of instruction, modify whatever needs to be modified from the last page
    clear Instruction;
    InstructionTrial.Type = 1;  % 1= HomoTrial 2= HeteroTrial
    InstructionTrial.Location= 1; %1=Central %2= Peripheral
    InstructionTrial.Direction= 2; %1=Left % Right
    Instruction(1).txt = 'Now we will walk through an example of the procedures for a trial';
    Instruction(1).xy = [0.1, 0.1];
    Instruction(2).txt = 'First you will see the prompt screen to begin a new trial.';
    Instruction(2).xy = [0.1, 0.1];
    Instruction(3).txt = 'If your eyes get tired, you can take a break at this point in the trial';
    Instruction(3).xy = [0.1, 0.1];
    Instruction(4).txt = 'Press the center button when ready';
    Instruction(4).xy = [0.1, 0.1];
    Instruction(5).txt = 'Then, you will see the stimulus (it will appear and disappear very fast!)';
    Instruction(5).xy = [0.1, 0.1];
    Instruction(6).txt = 'You need to determine whether the paired-dots are tilted left or right';
    Instruction(6).xy = [0.1, 0.1];
    Instruction(7).txt = 'Then, you will see a mask which indicates that you need to record your answer';
    Instruction(7).xy = [0.1, 0.1];
    Instruction(8).txt = 'Note this is NOT the paired-dot stimulus but a reminder to record your answer';
    Instruction(8).xy = [0.1, 0.1];
    Instruction(9).txt = 'Because the paired-dots were tilted right, press the right button ';
    Instruction(9).xy = [0.1, 0.1];
    
    This_Instruction_Page_Info.Type = InstructionTrial.Type;
    This_Instruction_Page_Info.Location = InstructionTrial.Location;
    This_Instruction_Page_Info.Direction = InstructionTrial.Direction;
    This_Instruction_Page_Info.Instruction_TextInfo = Instruction;
    
    Page_count = Page_count+1;
    Instruction_Pages_Info{Page_count} =This_Instruction_Page_Info;
    
        %% --- 9th page of instruction, modify whatever needs to be modified from the last page
    clear Instruction;
    InstructionTrial.Type = 1;  % 1= HomoTrial 2= HeteroTrial
    InstructionTrial.Location= 1; %1=Central %2= Peripheral
    InstructionTrial.Direction= 1; %1=Left % Right
    Instruction(1).txt = 'Now you can try! The stimuli will present a little faster now.';
    Instruction(1).xy = [0.1, 0.1];
    
    This_Instruction_Page_Info.Type = InstructionTrial.Type;
    This_Instruction_Page_Info.Location = InstructionTrial.Location;
    This_Instruction_Page_Info.Direction = InstructionTrial.Direction;
    This_Instruction_Page_Info.Instruction_TextInfo = Instruction;
    
    Page_count = Page_count+1;
    Instruction_Pages_Info{Page_count} =This_Instruction_Page_Info;
    
    
    

    
    



	  
