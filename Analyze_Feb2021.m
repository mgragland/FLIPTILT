%--- use ExperimentInfo and TrialData to see everything

%--- Stimulus Example in Instruction
disp('Showing the stimulus examples used in the instructions');
Instructions_StimulusExamples = ExperimentInfo.Instructions_StimulusExamples;
for trial = 1:length(Instructions_StimulusExamples)
   Show_StimulusForDebugging_FromStimulusInfo(Instructions_StimulusExamples{trial}.StimulusInfo);
   R=input('Enter to continue');
end
disp('Showing the trial examples used in the instructions');
for trial = 1:length(ExperimentInfo.Instructions_ExampleTrialData)
    Show_StimulusForDebugging_FromStimulusInfo(ExperimentInfo.Instructions_ExampleTrialData{trial}.StimulusInfo);
    disp(sprintf('ResponseAndMiscInfo from trial %d of Instructions', trial));
    disp(ExperimentInfo.Instructions_ExampleTrialData{trial}.ResponseAndMiscInfo);
    R=input('Enter to continue');
end

NTrials = length(TrialData);
TrainingOrTesting_list = zeros(1, NTrials);
for trial = 1:NTrials
    TrainingOrTesting_list(trial) = TrialData{trial}.TrainingOrTesting;
end
disp('showing the practice trials');
NTrials_Training = sum(TrainingOrTesting_list==1);
for trial = 1:NTrials_Training 
      Show_StimulusForDebugging_FromStimulusInfo(TrialData{trial}.StimulusInfo);
    disp(sprintf('ResponseAndMiscInfo from trial %d of practice trials', trial));
    disp(TrialData{trial}.ResponseAndMiscInfo);
    R=input('Enter to continue');
end
disp('showing the testing trials');
NTrials_Testing = sum(TrainingOrTesting_list==2);
for trial = 1:NTrials_Testing 
    Show_StimulusForDebugging_FromStimulusInfo(TrialData{trial+NTrials_Training}.StimulusInfo);
    disp(sprintf('ResponseAndMiscInfo from trial %d of testing trials', trial));
    disp(TrialData{trial+NTrials_Training}.ResponseAndMiscInfo);
    R=input('Enter to continue');
end