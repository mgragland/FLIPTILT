
response_options=ExperimentInfo.ResponseButtons.Buttons;
Fixation_Stimulus="Fixation"
%% Important Variables 
% Type of Stimuli 
Trials_Answer=zeros(1,length(Trial_Info));

if Fixation_Stimulus=="Fixation"
    central_y_location=ExperimentInfo.InputParameters.Conditions(1).FixationCenter.y_in_Scale;
    peripheral1_y_location=ExperimentInfo.InputParameters.Conditions(3).FixationCenter.y_in_Scale;
    peripheral2_y_location=ExperimentInfo.InputParameters.Conditions(2).FixationCenter.y_in_Scale;
end

central_trials_index=[];
peripheral1_trials_index=[];
peripheral2_trials_index=[];


% Sort by Location
for i=1:length(Trial_Info)
    if Trial_Info(i).StimulusInfo.condition.FixationCenter.y_in_Scale==central_y_location
        central_trials_index(end+1)=i;
    elseif Trial_Info(i).StimulusInfo.condition.FixationCenter.y_in_Scale==peripheral1_y_location
        peripheral1_trials_index(end+1)=i;
    elseif Trial_Info(i).StimulusInfo.condition.FixationCenter.y_in_Scale==peripheral2_y_location
        peripheral2_trials_index(end+1)=i;
    end
end

central_trials_index_timing=find_timing(central_trials_index, Trial_Info)
peripheral1_trials_index_timing=find_timing(peripheral1_trials_index, Trial_Info)
peripheral2_trials_index_timing=find_timing(peripheral2_trials_index, Trial_Info)


%%  Sort by Trial Type 
% Central Homo and Hetero Trials 
[homotrials_index,heterotrials_index]=sort_by_trial_type_optimize(central_trials_index_timing, Trial_Info);
central_homotrials_index=homotrials_index;
central_heterotrials_index=heterotrials_index;

% Peripheral Homo and Hetero Trials 
[homotrials_index,heterotrials_index]=sort_by_trial_type_optimize(peripheral1_trials_index_timing,Trial_Info);
peripheral1_homotrials_index=homotrials_index;
peripheral1_heterotrials_index=heterotrials_index;

% Peripheral Homo and Hetero Trials 
[homotrials_index,heterotrials_index]=sort_by_trial_type_optimize(peripheral2_trials_index_timing,Trial_Info);
peripheral2_homotrials_index=homotrials_index;
peripheral2_heterotrials_index=heterotrials_index;

%% Sort by Correct or Incorrect
% Central
[correct,incorrect]=correct_incorrect_optimize(central_homotrials_index,Trial_Info, ExperimentInfo);
correct_homotrials_central=correct;
incorrect_homotrials_central=incorrect; 

[correct,incorrect]=correct_incorrect_optimize(central_heterotrials_index,Trial_Info, ExperimentInfo);
correct_heterotrials_central=correct;
incorrect_heterotrials_central=incorrect; 

% Peripheral 1

[correct,incorrect]=correct_incorrect_optimize(peripheral1_homotrials_index,Trial_Info, ExperimentInfo);
correct_homotrials_peripheral1=correct;
incorrect_homotrials_peripheral1=incorrect; 

[correct,incorrect]=correct_incorrect_optimize(peripheral1_heterotrials_index,Trial_Info, ExperimentInfo);
correct_heterotrials_peripheral1=correct;
incorrect_heterotrials_peripheral1=incorrect; 

% Peripheral 2

[correct,incorrect]=correct_incorrect_optimize(peripheral2_homotrials_index,Trial_Info, ExperimentInfo);
correct_homotrials_peripheral2=correct;
incorrect_homotrials_peripheral2=incorrect; 

[correct,incorrect]=correct_incorrect_optimize(peripheral2_heterotrials_index,Trial_Info, ExperimentInfo);
correct_heterotrials_peripheral2=correct;
incorrect_heterotrials_peripheral2=incorrect; 

% central 
central_homotrials_accuracy=calc_accuracy(correct_homotrials_central, incorrect_homotrials_central);
central_heterotrials_accuracy=calc_accuracy(correct_heterotrials_central, incorrect_heterotrials_central);

% peripheral 1
peripheral1_homotrials_accuracy=calc_accuracy(correct_homotrials_peripheral1, incorrect_homotrials_peripheral1);
peripheral1_heterotrials_accuracy=calc_accuracy(correct_heterotrials_peripheral1, incorrect_heterotrials_peripheral1);

% peripheral 2
peripheral2_homotrials_accuracy=calc_accuracy(correct_homotrials_peripheral2, incorrect_homotrials_peripheral2);
peripheral2_heterotrials_accuracy=calc_accuracy(correct_heterotrials_peripheral2, incorrect_heterotrials_peripheral2);

results_heterotrials=[central_heterotrials_accuracy; peripheral1_heterotrials_accuracy; peripheral2_heterotrials_accuracy];
results_homotrials= [central_homotrials_accuracy; peripheral1_homotrials_accuracy; peripheral2_homotrials_accuracy];

