function [homotrials_index,heterotrials_index]=sort_by_trial_type(index, Trial_Info)
heterotrials_index=[];
homotrials_index=[];

Homo_Left = [0.5, 0.5,  0, 0,  0, 0, 0, 0];  %--- homo, left tilted
Homo_Right = [0, 0, 0, 0, 0.5, 0.5, 0, 0]; %--- homo, right tilted
Hetero_Left = [0, 0,  0.5, 0.5, 0, 0, 0, 0];  %--- hetero, left tilted
Hetero_Right = [0, 0,  0, 0, 0, 0, 0.5, 0.5];  %--- hetero, right tilted

for i=1:length(index)
    trial=Trial_Info(index(i));
    answer=trial.StimulusInfo.condition.prob_list;
    if answer==Homo_Left
        homotrials_index(end+1)=i;
    elseif answer==Homo_Right
        homotrials_index(end+1)=i;
    elseif answer==Hetero_Left
        heterotrials_index(end+1)=i;
    elseif answer==Hetero_Right
        heterotrials_index(end+1)=i;
    end
end