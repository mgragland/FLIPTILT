NTrials = length(TrialData);
Trial_TrainingOrTesting = zeros(1, NTrials);
Trial_Condition = zeros(1, NTrials);
Trial_RT = zeros(1, NTrials);
Trial_CorrectOrNot = zeros(1, NTrials);
Trial_LaterialSide = zeros(1, NTrials);
ResponseButtons = ExperimentInfo.ResponseButtons;
Trial_TargetLocationTooCloseToThatOfTheLastTrial  = zeros(1, NTrials);
Trial_Target_i = zeros(1, NTrials);
Trial_Target_j = zeros(1, NTrials);
Trial_Eccentricity = zeros(1, NTrials);
for trial = 1:NTrials
    Trial_TrainingOrTesting(trial) = TrialData{trial}.TrainingOrTesting;
    Trial_Condition(trial) = TrialData{trial}.StimulusInfo.Condition;
    Trial_RT(trial) = TrialData{trial}.ResponseAndMiscInfo.RT(end);
    Trial_ResponseButton = TrialData{trial}.ResponseAndMiscInfo.ButtonPressed(end);
    Trial_LaterialSide(trial) = TrialData{trial}.StimulusInfo.This_Target_LateralSide;
    if Trial_ResponseButton == ResponseButtons{Trial_LaterialSide(trial)}
        Trial_CorrectOrNot(trial) = 1;
    end
    Trial_Target_i(trial) = TrialData{trial}.StimulusInfo.Target_i;
    Trial_Target_j(trial) = TrialData{trial}.StimulusInfo.Target_j;
    di = Trial_Target_i(trial) - (1+TrialData{trial}.StimulusInfo.NbX)/2;
    dj = Trial_Target_j(trial) - (1+TrialData{trial}.StimulusInfo.NbY)/2;
    Trial_Eccentricity(trial) = sqrt(di^2 + dj^2);
    if trial > 1
        di =  Trial_Target_i(trial)  -  Trial_Target_i(trial-1);
        dj = Trial_Target_j(trial)  -  Trial_Target_j(trial-1);
        ds  = sqrt(di^2 +dj^2)/TrialData{trial}.StimulusInfo.NbX;
        if ds < 0.2
            Trial_TargetLocationTooCloseToThatOfTheLastTrial(trial)  = 1;
        end
    end
end
RT_Threshold =200;
Trial_Numbers = 1:NTrials; 
MeanEccentricity = mean(Trial_Eccentricity);
NConditions = length(ExperimentInfo.StimulusItems_Sizes_Conditions.NewConditions_ForExp);
for IncludeOrNot_TargetLocationPrimingTrials = 1:2
    meanRT = zeros(1, NConditions);
    semRT = zeros(1, NConditions);
    Accuracies  = zeros(1, NConditions);
    for c  = 1:NConditions
        if IncludeOrNot_TargetLocationPrimingTrials==2
            Selected_AllTrials = find(Trial_Condition ==c & Trial_TargetLocationTooCloseToThatOfTheLastTrial ==0& Trial_RT< RT_Threshold & Trial_Numbers> 0);
        else
            Selected_AllTrials = find(Trial_Condition ==c & Trial_RT< RT_Threshold & Trial_Numbers> 0);
        end
        Selected_CorrectTrials = Selected_AllTrials(find(Trial_CorrectOrNot(Selected_AllTrials) ==1));
        RT_list = Trial_RT(Selected_CorrectTrials);
        meanRT(c) = mean(RT_list);
        semRT(c) = std(RT_list)/sqrt(length(RT_list));
        Accuracies(c) = length(Selected_CorrectTrials)/length(Selected_AllTrials);
    end
    

    
    
    figure(1+(IncludeOrNot_TargetLocationPrimingTrials-1)*10); clf;
    subplot(2, 1, 1); bar(1:NConditions, Accuracies, 0.2);  xlabel('Conditions'); title('Accuracies');
    subplot(2, 1, 2); bar(1:NConditions, meanRT, 0.2); hold on;
    errorbar(1:NConditions, meanRT, semRT, 'k.');
    xlabel('Conditions'); title('RTs (second)');
    
    meanRT_2 = zeros(1, 2);
    semRT_2 = zeros(1,  2);
    Accuracies_2 = zeros(1, 2);
    ConditionGroup{1} = [1, 2];
    ConditionGroup{2} = [3, 4];
    for cc  = 1:2
        if IncludeOrNot_TargetLocationPrimingTrials==2
            Selected_AllTrials = find(ismember(Trial_Condition, ConditionGroup{cc})==1& Trial_TargetLocationTooCloseToThatOfTheLastTrial ==0& Trial_RT< RT_Threshold & Trial_Numbers> 0);
        else
            Selected_AllTrials = find(ismember(Trial_Condition, ConditionGroup{cc})==1& Trial_RT< RT_Threshold & Trial_Numbers> 0);
        end
        Selected_CorrectTrials = Selected_AllTrials(find(Trial_CorrectOrNot(Selected_AllTrials) ==1));
        RT_list2{cc} = Trial_RT(Selected_CorrectTrials);
        meanRT_2(cc) = mean(RT_list2{cc});
        semRT_2(cc) = std(RT_list2{cc})/sqrt(length(RT_list2{cc}));
        Accuracies_2(cc) = length(Selected_CorrectTrials)/length(Selected_AllTrials);
    end
    figure(3+(IncludeOrNot_TargetLocationPrimingTrials-1)*10);  clf;
    subplot(2, 1, 1); bar(1:2, Accuracies_2, 0.2);  xlabel('Condition groups'); title('Accuracies');
    subplot(2, 1, 2); bar(1:2, meanRT_2, 0.2); hold on;
    errorbar(1:2, meanRT_2, semRT_2, 'k.');
    xlabel('Condition groups'); title('RTs (second)');
    [h,p] = ttest2(RT_list2{1}, RT_list2{2});
    txt = sprintf('h = %d, p  = %f', h, p);
    text(1.3, mean(meanRT_2), txt);
end

NewConditions_ForExp=ExperimentInfo.StimulusItems_Sizes_Conditions.NewConditions_ForExp;     
NewItemTypes = ExperimentInfo.StimulusItems_Sizes_Conditions.NewItemTypes;
NewAllCubes  = ExperimentInfo.StimulusItems_Sizes_Conditions.NewAllCubes;
figure(2); nrows = size(NewItemTypes, 1);
row_number = 0;
for c  = 1:NConditions
    NItems = length(NewConditions_ForExp{c});
    for ci = 1:NItems
        row_number = row_number +1;
        this_item = NewConditions_ForExp{c}(ci);
        for col  = 1:3
            subplot(nrows, 3, col + (row_number -1)*3);
            
            imshow(squeeze(NewAllCubes(NewItemTypes(this_item, col), :, :)), [0,1]); title(['Condition ', num2str(c)]);
            colormap(gray); axis image; axis off;
        end 
    end
end