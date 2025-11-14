function [homotrials_index_all,heterotrials_index_all]=sort_by_trial_type_optimize(index_orig, Trial_Info)


Homo_Left = [0.5, 0.5,  0, 0,  0, 0, 0, 0];  %--- homo, left tilted
Homo_Right = [0, 0, 0, 0, 0.5, 0.5, 0, 0]; %--- homo, right tilted
Hetero_Left = [0, 0,  0.5, 0.5, 0, 0, 0, 0];  %--- hetero, left tilted
Hetero_Right = [0, 0,  0, 0, 0, 0, 0.5, 0.5];  %--- hetero, right tilted

for h=1:size(index_orig,2)
    index=index_orig{h};
    heterotrials_index=[];
    homotrials_index=[];
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
    homotrials_index_all{h}=index(homotrials_index);
    heterotrials_index_all{h}=index(heterotrials_index);
end