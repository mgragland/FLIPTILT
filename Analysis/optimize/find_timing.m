function time_index=find_timing(trial_type, Trial_Info)

time_index_fastest=[];
time_index_fast=[];
time_index_slow=[];

for i=1:length(trial_type)
    pres_duration=Trial_Info(trial_type(i)).StimulusInfo.condition.PresentationDuration;
    if pres_duration==0.08
        time_index_fastest(end+1)=i;
    elseif pres_duration==0.2
        time_index_fast(end+1)=i;
    elseif pres_duration==1
        time_index_slow(end+1)=i;
    end
end
time_index{1}=time_index_fastest;
time_index{2}=time_index_fast;
time_index{3}=time_index_slow;


   
