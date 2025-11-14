function accuracy=calc_accuracy(correct_trials, incorrect_trials)

accuracy=NaN(1,length(correct_trials));
for i=1:length(correct_trials)
    total_trials = correct_trials(i) + incorrect_trials(i);
    accuracy(i) = correct_trials(i) / total_trials;
end