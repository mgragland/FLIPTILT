response_options=ExperimentInfo.ResponseButtons.Buttons;
Fixation_Stimulus="Fixation"
%% Important Variables 
% Type of Stimuli 
Trials_Answer=zeros(1,length(Trial_Info));

if Fixation_Stimulus=="Fixation"
    central_y_location=ExperimentInfo.InputParameters.Conditions(1).FixationCenter.y_in_Scale;
    peripheral1_y_location=ExperimentInfo.InputParameters.Conditions(2).FixationCenter.y_in_Scale;
    peripheral2_y_location=ExperimentInfo.InputParameters.Conditions(3).FixationCenter.y_in_Scale;
    peripheral3_y_location=ExperimentInfo.InputParameters.Conditions(4).FixationCenter.y_in_Scale;
end

central_trials_index=[];
peripheral1_trials_index=[];
peripheral2_trials_index=[];
peripheral3_trials_index=[];


% Sort by Location
for i=1:length(Trial_Info)
    if Trial_Info(i).StimulusInfo.condition.FixationCenter.y_in_Scale==central_y_location
        central_trials_index(end+1)=i;
    elseif Trial_Info(i).StimulusInfo.condition.FixationCenter.y_in_Scale==peripheral1_y_location
        peripheral1_trials_index(end+1)=i;
    elseif Trial_Info(i).StimulusInfo.condition.FixationCenter.y_in_Scale==peripheral2_y_location
        peripheral2_trials_index(end+1)=i;
    elseif Trial_Info(i).StimulusInfo.condition.FixationCenter.y_in_Scale==peripheral3_y_location
        peripheral3_trials_index(end+1)=i;
    end
end

%%  Sort by Trial Type 
% Central Homo and Hetero Trials 
[homotrials_index,heterotrials_index]=sort_by_trial_type(central_trials_index, Trial_Info);
central_homotrials_index=central_trials_index(homotrials_index);
central_heterotrials_index=central_trials_index(heterotrials_index);
clear homotrials_index heterotrials_index

% Peripheral Homo and Hetero Trials 
[homotrials_index,heterotrials_index]=sort_by_trial_type(peripheral1_trials_index,Trial_Info);
peripheral1_homotrials_index=peripheral1_trials_index(homotrials_index);
peripheral1_heterotrials_index=peripheral1_trials_index(heterotrials_index);

% Peripheral Homo and Hetero Trials 
[homotrials_index,heterotrials_index]=sort_by_trial_type(peripheral2_trials_index,Trial_Info);
peripheral2_homotrials_index=peripheral2_trials_index(homotrials_index);
peripheral2_heterotrials_index=peripheral2_trials_index(heterotrials_index);

% Peripheral Homo and Hetero Trials 
[homotrials_index,heterotrials_index]=sort_by_trial_type(peripheral3_trials_index,Trial_Info);
peripheral3_homotrials_index=peripheral3_trials_index(homotrials_index);
peripheral3_heterotrials_index=peripheral3_trials_index(heterotrials_index);

%% Sort by Correct or Incorrect--> Central
% HomoTrials 
[correct,incorrect]=correct_incorrect(central_homotrials_index,Trial_Info, ExperimentInfo);
correct_homotrials_central=correct;
incorrect_homotrials_central=incorrect; 

[correct,incorrect]=correct_incorrect(central_heterotrials_index,Trial_Info, ExperimentInfo);
correct_heterotrials_central=correct;
incorrect_heterotrials_central=incorrect; 

[correct,incorrect]=correct_incorrect(peripheral1_homotrials_index,Trial_Info, ExperimentInfo);
correct_homotrials_peripheral1=correct;
incorrect_homotrials_peripheral1=incorrect; 

[correct,incorrect]=correct_incorrect(peripheral1_heterotrials_index,Trial_Info, ExperimentInfo);
correct_heterotrials_peripheral1=correct;
incorrect_heterotrials_peripheral1=incorrect; 

[correct,incorrect]=correct_incorrect(peripheral2_homotrials_index,Trial_Info, ExperimentInfo);
correct_homotrials_peripheral2=correct;
incorrect_homotrials_peripheral2=incorrect; 

[correct,incorrect]=correct_incorrect(peripheral2_heterotrials_index,Trial_Info, ExperimentInfo);
correct_heterotrials_peripheral2=correct;
incorrect_heterotrials_peripheral2=incorrect; 

[correct,incorrect]=correct_incorrect(peripheral3_homotrials_index,Trial_Info, ExperimentInfo);
correct_homotrials_peripheral3=correct;
incorrect_homotrials_peripheral3=incorrect; 

[correct,incorrect]=correct_incorrect(peripheral3_heterotrials_index,Trial_Info, ExperimentInfo);
correct_heterotrials_peripheral3=correct;
incorrect_heterotrials_peripheral3=incorrect; 


central_trials_homotrials=correct_homotrials_central/(correct_homotrials_central + incorrect_homotrials_central);
central_trials_heterotrials=correct_heterotrials_central/(correct_heterotrials_central+incorrect_heterotrials_central);
peripheral1_trials_homotrials=correct_homotrials_peripheral1/(correct_homotrials_peripheral1+incorrect_homotrials_peripheral1);
peripheral1_trials_heterotrials=correct_heterotrials_peripheral1/(correct_heterotrials_peripheral1+incorrect_heterotrials_peripheral1);
peripheral2_trials_homotrials=correct_homotrials_peripheral2/(correct_homotrials_peripheral2+incorrect_homotrials_peripheral2);
peripheral2_trials_heterotrials=correct_heterotrials_peripheral2/(correct_heterotrials_peripheral2+incorrect_heterotrials_peripheral2);
peripheral3_trials_homotrials=correct_homotrials_peripheral3/(correct_homotrials_peripheral3+incorrect_homotrials_peripheral3);
peripheral3_trials_heterotrials=correct_heterotrials_peripheral3/(correct_heterotrials_peripheral3+incorrect_heterotrials_peripheral3);



results=[central_trials_homotrials, central_trials_heterotrials; peripheral1_trials_homotrials, peripheral1_trials_heterotrials; peripheral2_trials_homotrials, peripheral2_trials_heterotrials; peripheral3_trials_homotrials, peripheral3_trials_heterotrials];

% if Individual_Group=="Individual"
%     graph_tilt_results(results, Individual_Group, Location);
% end


