function ExperimentInfo = Get_ExpMiscInfo(ExperimentInfo)

Exp_prompt={'Lights on?', ...
    'other info.', ...
    'Display screen width', 'Display screen height', 'Display screen descrption', 'Left tilt response button', 'Right tilt response button', ...
    'Give feedback or not to test trials 1 or 0', 'Give instructions or not 1 or 0', 'Debugging or real running mode 1 or 0', 'GazeContingent', 'Response Type', 'Location'};
Exp_dialog_title='Give_Exp_Information';
num_lines=1;
Exp_default_answer={'Indoor dim light',  'none',  '69.8 cm', '39.3 cm',  'Sony GDM-F520', 'green', 'red','0', '1', '0', '1' 'ResponseBox', 'Inferior'};
%Exp_default_answer={'Done', 'Indoor dim light', 'yes/irrelevant', 'none', '30 30 30 30', '1 1 1 1', '0', '4', '+', '1', '40 cm', '40.9 cm', '25.6 cm', 'Attwood lab display screen'};
Exp_info=inputdlg(Exp_prompt,Exp_dialog_title,num_lines,Exp_default_answer);
RoomLights = Exp_info{1};
Exp_OtherInfo = Exp_info{2};
DisplayScreenWidth = Exp_info{3}; 
DisplayScreenHeight = Exp_info{4}; 
DisplayScreenDescription = Exp_info{5};
ResponseButtons.Buttons{1} = Exp_info{6};
ResponseButtons.Buttons{2} = Exp_info{7};
GiveFeedbackOrNot = str2num(Exp_info{8});
Give_InstructionOrNot = str2num(Exp_info{9});
Debugging_Mode=str2num(Exp_info{10})
Gaze_Contingent= str2num(Exp_info{11})
ResponseButtons.Type = Exp_info{12};
Testing_Location= Exp_info{13};

ExperimentInfo.RoomLights = RoomLights;
ExperimentInfo.OtherInfo  =Exp_OtherInfo;
ExperimentInfo.PhysicalDisplay.DisplayScreenWidth = DisplayScreenWidth;
ExperimentInfo.PhysicalDisplay.DisplayScreenHeight = DisplayScreenHeight;
ExperimentInfo.ResponseButtons = ResponseButtons;
ExperimentInfo.GiveFeedbackOrNot = GiveFeedbackOrNot;
ExperimentInfo.Give_InstructionOrNot = Give_InstructionOrNot;
ExperimentInfo.Debugging_Mode =Debugging_Mode;
ExperimentInfo.Gaze_Contingent=Gaze_Contingent;
ExperimentInfo.Testing_Location=Testing_Location;