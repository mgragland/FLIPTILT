%--- Get praction of left tilt response
N_condition = length(unique(condition_index_sequence));
Average_Responses = zeros(1, N_condition);
for c  = 1:N_condition 
    Selected_Trials = find(condition_index_sequence ==c);
    Responses = [];
    for i = 1:length(Selected_Trials)
        trial  = Selected_Trials(i);
        if ExperimentInfo.ResponseButtons{1}==Trial_Info(trial).ResponseAndMiscInfo.ButtonPressed(end)
            this_response =1;
        else
            this_response =2;
        end
        Responses=[Responses, this_response];
    end
    Conditioned_Responses{c} = Responses;
    Average_Responses(c)= mean(Responses);
end   

[(Average_Responses(1:8))', (Average_Responses(9:16))', (Average_Responses(17:24))', (Average_Responses(25:32))',(Average_Responses(33:40))',(Average_Responses(41:48))']

