response_options=ExperimentInfo.ResponseButtons.Buttons;

%% Important Variables 
% Type of Stimuli 
Trials_Answer=zeros(1,length(Trial_Info));
if Fixation_Stimulus=="Stimulus"
    left_location=ExperimentInfo.InputParameters.StimulusCenter_x_in_Scale(1);
    central_location=ExperimentInfo.InputParameters.StimulusCenter_x_in_Scale(2);
    right_location=ExperimentInfo.InputParameters.StimulusCenter_x_in_Scale(3);
    central_trials_index=[];
    left_trials_index=[];
    right_trials_index=[];
end

% Sort by Location 
for i=1:length(Trial_Info)
    if Trial_Info(i).StimulusInfo.condition.StimulusCenter.x_in_Scale==central_location
        central_trials_index(end+1)=i;
    elseif Trial_Info(i).StimulusInfo.condition.StimulusCenter.x_in_Scale==left_location
        left_trials_index(end+1)=i;
    elseif Trial_Info(i).StimulusInfo.condition.StimulusCenter.x_in_Scale==right_location
        right_trials_index(end+1)=i;
    end
end

%%  Sort by Trial Type 
% Central Homo and Hetero Trials 
[homotrials_index,heterotrials_index]=sort_by_trial_type(central_trials_index, Trial_Info);
central_homotrials_index=central_trials_index(homotrials_index);
central_heterotrials_index=central_trials_index(heterotrials_index);
clear homotrials_index heterotrials_index

% Peripheral Homo and Hetero Trials 
[homotrials_index,heterotrials_index]=sort_by_trial_type(left_trials_index,Trial_Info);
left_homotrials_index=left_trials_index(homotrials_index);
left_heterotrials_index=left_trials_index(heterotrials_index);
clear homotrials_index heterotrials_index

[homotrials_index,heterotrials_index]=sort_by_trial_type(right_trials_index,Trial_Info);
right_homotrials_index=right_trials_index(homotrials_index);
right_heterotrials_index=right_trials_index(heterotrials_index);
clear homotrials_index heterotrials_index


%% Sort by Correct or Incorrect--> Central
% HomoTrials 
[correct,incorrect]=correct_incorrect(central_homotrials_index,Trial_Info, ExperimentInfo);
correct_homotrials_central=correct;
incorrect_homotrials_central=incorrect; 

[correct,incorrect]=correct_incorrect(central_heterotrials_index,Trial_Info, ExperimentInfo);
correct_heterotrials_central=correct;
incorrect_heterotrials_central=incorrect; 

[correct,incorrect]=correct_incorrect(left_homotrials_index,Trial_Info, ExperimentInfo);
correct_homotrials_left=correct;
incorrect_homotrials_left=incorrect; 

[correct,incorrect]=correct_incorrect(left_heterotrials_index,Trial_Info, ExperimentInfo);
correct_heterotrials_left=correct;
incorrect_heterotrials_left=incorrect; 

[correct,incorrect]=correct_incorrect(right_homotrials_index,Trial_Info, ExperimentInfo);
correct_homotrials_right=correct;
incorrect_homotrials_right=incorrect; 

[correct,incorrect]=correct_incorrect(right_heterotrials_index,Trial_Info, ExperimentInfo);
correct_heterotrials_right=correct;
incorrect_heterotrials_right=incorrect; 

central_trials_homotrials=correct_homotrials_central/(correct_homotrials_central + incorrect_homotrials_central);
central_trials_heterotrials=correct_heterotrials_central/(correct_heterotrials_central+incorrect_heterotrials_central);
left_trials_homotrials=correct_homotrials_left/(correct_homotrials_left+incorrect_homotrials_left);
left_trials_heterotrials=correct_heterotrials_left/(correct_heterotrials_left+incorrect_heterotrials_left);
right_trials_homotrials=correct_homotrials_right/(correct_homotrials_right+incorrect_homotrials_right);
right_trials_heterotrials=correct_heterotrials_right/(correct_heterotrials_right+incorrect_heterotrials_right);

results=[left_trials_homotrials, left_trials_heterotrials; central_trials_homotrials, central_trials_heterotrials; right_trials_homotrials, right_trials_heterotrials];




