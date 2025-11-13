function  condition_index_sequence= Get_condition_index_sequence(NTrials_EachCondition)

Nconditions = length(NTrials_EachCondition);
condition_index_sequence = [];
for i= 1:Nconditions
    condition_index_sequence = [condition_index_sequence, i*ones(1, NTrials_EachCondition(i))];
end
Nall= length(condition_index_sequence);
condition_index_sequence  = condition_index_sequence(randperm(Nall));

