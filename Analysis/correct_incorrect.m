function [correct,incorrect]=correct_incorrect(index,Trial_Info, ExperimentInfo)
correct=0;
incorrect=0;

if strcmp(ExperimentInfo.ResponseButtons.Type, 'Keyboard')
    left_button='a';
    right_button='l';
elseif strcmp(ExperimentInfo.ResponseButtons.Type, 'ResponseBox')
    left_button='green';
    right_button='red';
end

for i=1:length(index)
    trial=Trial_Info(index(i));
    answer=trial.StimulusInfo.condition.prob_list;
    response=trial.ResponseAndMiscInfo.ButtonPressed;
    true_answer=determine_stimulus_type(answer);
    if strcmp(response, left_button) && true_answer==1
        correct=correct+1;
    elseif strcmp(response, left_button) && true_answer==2
        incorrect=incorrect+1;
    elseif strcmp(response, right_button) && true_answer==2
        correct=correct+1;
    elseif strcmp(response, right_button) && true_answer==1
        incorrect=incorrect+1;
    end
end


% 
% for i=1:length(index)
%     trial=Trial_Info(index(i));
%     answer=trial.StimulusInfo.condition.prob_list;
%     response=trial.ResponseAndMiscInfo.ButtonPressed;
%     true_answer=determine_stimulus_type(answer);
%     if strcmp(response, 'green') && true_answer==1
%         correct=correct+1;
%     elseif strcmp(response, 'green') && true_answer==2
%         incorrect=incorrect+1;
%     elseif strcmp(response, 'red') && true_answer==2
%         correct=correct+1;
%     elseif strcmp(response, 'red') && true_answer==1
%         incorrect=incorrect+1;
%     end
% end