
InstructionPage = ExperimentInfo.DisplayPages.Instruction.Page;
BackgroundLuminance = ExperimentInfo.DisplayInfo.BackgroundLuminance;
TotalScreenY = ExperimentInfo.DisplayInfo.WindowWidthAndHeightInPixels.TotalScreenY;
fn_out = ExperimentInfo.fn_out; 
%
crsSetDrawPage(InstructionPage); crsClearPage(InstructionPage,BackgroundLuminance+1);
crsDrawString([0,0],'Trials completed --- Thank you very much!!');
 
crsDrawString([0,TotalScreenY/4],'please tell the experimentalist your comments/observations');   
crsSetDisplayPage(InstructionPage);
save(fn_out);

SubjectReport{1}= input('Have you any observations or comments about this experiment to tell me? ', 's');
SubjectReport{2} = input('Do you have any strategies in this task?', 's');

ExperimentalObservation = input('write experimenter observation', 's');
clear CRS;
save(fn_out);