response_options=ExperimentInfo.ResponseButtons.Buttons

%% Important Variables 
% Type of Stimuli 
Trials_Answer=zeros(1,length(Trial_Info));

% Location of Stimuli 
sortbasedonlocation

central_y_location=ExperimentInfo.InputParameters.Conditions(1).FixationCenter.y_in_Scale;
peripheral_y_location=ExperimentInfo.InputParameters.Conditions(2).FixationCenter.y_in_Scale;
central_trials_index=[];
peripheral_trials_index=[];

% Sort by Location 
for i=1:length(Trial_Info)
    if Trial_Info(i).StimulusInfo.condition.FixationCenter.y_in_Scale==central_y_location
        central_trials_index(end+1)=i;
    elseif Trial_Info(i).StimulusInfo.condition.FixationCenter.y_in_Scale==peripheral_y_location
        peripheral_trials_index(end+1)=i;
    end
end

%%  Sort by Trial Type 
% Central Homo and Hetero Trials 
[homotrials_index,heterotrials_index]=sort_by_trial_type(central_trials_index, Trial_Info)
central_homotrials_index=central_trials_index(homotrials_index);
central_heterotrials_index=central_trials_index(heterotrials_index);
clear homotrials_index heterotrials_index

% Peripheral Homo and Hetero Trials 
[homotrials_index,heterotrials_index]=sort_by_trial_type(peripheral_trials_index,Trial_Info)
peripheral_homotrials_index=peripheral_trials_index(homotrials_index);
peripheral_heterotrials_index=peripheral_trials_index(heterotrials_index);

%% Sort by Correct or Incorrect--> Central
% HomoTrials 
[correct,incorrect]=correct_incorrect(central_homotrials_index,Trial_Info, ExperimentInfo)
correct_homotrials_central=correct;
incorrect_homotrials_central=incorrect; 

[correct,incorrect]=correct_incorrect(central_heterotrials_index,Trial_Info, ExperimentInfo)
correct_heterotrials_central=correct;
incorrect_heterotrials_central=incorrect; 

[correct,incorrect]=correct_incorrect(peripheral_homotrials_index,Trial_Info, ExperimentInfo)
correct_homotrials_peripheral=correct;
incorrect_homotrials_peripheral=incorrect; 

[correct,incorrect]=correct_incorrect(peripheral_heterotrials_index,Trial_Info, ExperimentInfo)
correct_heterotrials_peripheral=correct;
incorrect_heterotrials_peripheral=incorrect; 

central_trials_homotrials=correct_homotrials_central/(correct_homotrials_central + incorrect_homotrials_central)
central_trials_heterotrials=correct_heterotrials_central/(correct_heterotrials_central+incorrect_heterotrials_central)
peripheral_trials_homotrials=correct_homotrials_peripheral/(correct_homotrials_peripheral+incorrect_homotrials_peripheral)
peripheral_trials_heterotrials=correct_heterotrials_peripheral/(correct_heterotrials_peripheral+incorrect_heterotrials_peripheral)





