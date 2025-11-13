function  condition_sequence_list= Get_condition_sequence_list(NTrials_EachCondition)

Nconditions = length(NTrials_EachCondition);
condition_sequence_list = [];
for i= 1:Nconditions
    condition_sequence_list = [condition_sequence_list, i*ones(1, NTrials_EachCondition(i))];
end
Nall= length(condition_sequence_list);
condition_sequence_list  = condition_sequence_list(randperm(Nall));

