input_filename = fn_out;
FileRoot_Pathname = '';
Plot_PartOrAll =1;

Standard_data_filename = [FileRoot_Pathname, 'Zhaoping_Li1-15-May-2025-22-50.mat'];

Standard_data_filename = [FileRoot_Pathname, 'Madeline_Ragland1-15-May-2025-23-23.mat'];
Standard_data_filename = [FileRoot_Pathname, 'Madeline_Ragland2-15-May-2025-23-52.mat'];

load(Standard_data_filename);
Standard_Cube_Labels =ExperimentInfo.InputParameters.Cube_Labels;
Standard_Cube_Images = ExperimentInfo.InputParameters.Cube_Images;

Standard_Prob_lists{1} = [0.5, 0.5,  0, 0,  0, 0, 0, 0];  %--- homo, left tilted
Standard_Prob_lists{2} = [0, 0, 0, 0, 0.5, 0.5, 0, 0]; %--- homo, right tilted
Standard_Prob_lists{3} = [0, 0,  0.5, 0.5, 0, 0, 0, 0];  %--- hetero, left tilted
Standard_Prob_lists{4} = [0, 0,  0, 0, 0, 0, 0.5, 0.5];  %--- hetero, right tilted
Standard_Prob_lists{5} = [0.25, 0.25,  0.25, 0.25, 0, 0, 0, 0];  %--- homo 50%, hetero 50%, left tilted
Standard_Prob_lists{6} = [0, 0, 0, 0, 0.25, 0.25, 0.25, 0.25]; %---   homo 50%, hetero 50%, right tilted
Standard_Prob_lists{7} = [0.25, 0.25,  0, 0, 0, 0, 0.25, 0.25];  %--- homo 50% left tilted, congruent hetero 50%, right tilted
Standard_Prob_lists{8} = [0, 0, 0.25, 0.25, 0.25, 0.25, 0, 0]; %---   homo 50%, right tilted, congruent hetero 50%, left tilted


Standard_CommonExp_Info = Get_Common_ExpInfo(ExperimentInfo);
%--- remove specific date, time, filename, SubjectInfo, etc
N_Standard_prob_lists = length(Standard_Prob_lists);



input_filename=[FileRoot_Pathname, input_filename]


if exist(input_filename) ~=2
    error(sprintf('the file %s does not exist', input_filename));
end
load(input_filename);
CommonExp_Info = Get_Common_ExpInfo(ExperimentInfo);
if isequal(CommonExp_Info, Standard_CommonExp_Info) ==1
    disp('This data file has its ExperimentInfo the same as that in the Standard ones');
else
    error('This data file has its ExperimentInfo unequal to that in the Standard ones');
end

if isequal(Standard_Cube_Labels, ExperimentInfo.InputParameters.Cube_Labels) ~=1 | ...
		isequal(Standard_Cube_Images, ExperimentInfo.InputParameters.Cube_Images) ~=1
	error('The labels and images of the input items are not the same as the standard');
end

PlotCubesOrNot = 2;
if PlotCubesOrNot==1
figure(1); clf;
N_Cubes = length(ExperimentInfo.InputParameters.Cube_Labels);

Lum_max = max(max(max(ExperimentInfo.InputParameters.Cube_Images)));
Lum_min = min(min(min(ExperimentInfo.InputParameters.Cube_Images)));

for c = 1:N_Cubes
    subplot(2, 4, c);
    imshow(squeeze(ExperimentInfo.InputParameters.Cube_Images(c, :, :)), [Lum_min, Lum_max]);
    title(ExperimentInfo.InputParameters.Cube_Labels{c});
end
subplot(2, 4, 1);
xlims = get(gca, 'xlim');
ylims = get(gca, 'ylim');
text(xlims(1), ylims(2)+ (ylims(2)-ylims(1))*0.2, 'The standard items, 1, 2, 3, ...8, from top-left to lower-right for defining the Prob_list for various conditions');
%R=input('enter to continue');
end


%--- categorize the conditions into the categories as in Standard_Prob_lists, plus the presentation duration
N_Conditions = length(ExperimentInfo.InputParameters.Conditions);
Prob_list_index_EachCondition = zeros(1, N_Conditions);
Duration_EachCondition = zeros(1, N_Conditions);
for i_condition = 1:N_Conditions
    condition = ExperimentInfo.InputParameters.Conditions(i_condition);
    if condition.AddMask ~=1   %no ending mask
        error('this data analysis code restricts to data with conditions only  one frame per trial, and masked at the end of the stimulus only');
    end
    Found_It = 0;
    for i_prob_list = 1:N_Standard_prob_lists
        if isequal(condition.prob_list, Standard_Prob_lists{i_prob_list}) ==1
            Prob_list_index_EachCondition(i_condition) = i_prob_list;
            Found_It = 1;
            break;
        end
    end
    if Found_It ==0
        error('This condition does not have one of the standard prob_list');
    end
    Duration_EachCondition(i_condition) = condition.PresentationDuration;
end

NTrials = length(Trial_Info);
Trial_Response_LeftOrRight  = zeros(1, NTrials);
Trial_condition_index =  zeros(1, NTrials);
Trial_StimulusDuration=  zeros(1, NTrials);
Trial_Prob_list_index = zeros(1, NTrials);
Trial_FixationLocations = zeros(1, NTrials);
Trial_RT = zeros(1, NTrials);

for trial = 1:NTrials
    %---  from StimulusInfo.
    condition = Trial_Info(trial).StimulusInfo.condition;
    for i_condition = 1:N_Conditions
        if isequal(condition, ExperimentInfo.InputParameters.Conditions(i_condition)) ==1
            Trial_condition_index(trial) =i_condition;
            break;
        end
    end
    if Trial_condition_index(trial) ==0
        error('something wrong, this trial has a condition not listed in ExperimentInfo.InputParameters.Conditions');
    else
        Trial_Prob_list_index(trial) = Prob_list_index_EachCondition(i_condition);
        Trial_StimulusDuration(trial) = Duration_EachCondition(i_condition);
    end
    %---  from Responses
    Trial_RT(trial) = Trial_Info(trial).ResponseAndMiscInfo.RT(length(Trial_Info(trial).ResponseAndMiscInfo.ButtonPressed));
    for i_button = 1:length(ExperimentInfo.ResponseButtons)
        if strcmp(Trial_Info(trial).ResponseAndMiscInfo.ResponseButtonPressed, ExperimentInfo.ResponseButtons{i_button}) ==1
            Trial_Response_LeftOrRight(trial) = i_button;
            break;
        end
    end
    if Trial_Response_LeftOrRight(trial) ==0
        error('something is wrong, no valid button response entry')
    end

    if isequal(condition.StimulusCenter, condition.FixationCenter) ==1
		Trial_FixationLocations(trial) =1;
    else
		Trial_FixationLocations(trial) =2;
    end
end

Average_Response_Each_Condition =zeros(1, N_Conditions);
for i_condition = 1:N_Conditions
    Selected_Trials = find(Trial_condition_index == i_condition);
    Average_Response_Each_Condition(i_condition) = mean(Trial_Response_LeftOrRight(Selected_Trials));
end


Unique_Stimulus_Durations = unique(Trial_StimulusDuration);

N_Unique_StimulusDurations = length(Unique_Stimulus_Durations);
Average_Responses = zeros(N_Standard_prob_lists, 2, N_Unique_StimulusDurations);

for i= 1:N_Standard_prob_lists
   for k= 1:2
    for j= 1:N_Unique_StimulusDurations
        jj = Unique_Stimulus_Durations(j);
        Selected_Trials = find(Trial_Prob_list_index ==i & Trial_StimulusDuration == jj & Trial_FixationLocations == k);
        if length(Selected_Trials)>0
            Average_Responses(i,k, j)=  mean(Trial_Response_LeftOrRight(Selected_Trials));
        end
    end
   end
end

colors_prob_list_indices = 'bbrrccmm';


if Plot_PartOrAll ==1
	N_Plotted_Standard_prob_lists=2;
	NPair_Plotted_Standard_prob_lists = 1;
else
	N_Plotted_Standard_prob_lists=N_Standard_prob_lists;
	NPair_Plotted_Standard_prob_lists = N_Standard_prob_lists/2;
end


figure;
subplot(2, 1, 1);
for i= 1:N_Plotted_Standard_prob_lists
    ylist = Average_Responses(i, :);
    tlist = find(ylist > 0);
    if length(tlist)>0
        if mod(i, 2) ==1
            plot(Unique_Stimulus_Durations(tlist), ylist(tlist), colors_prob_list_indices(i)); hold on;
        else
            plot(Unique_Stimulus_Durations(tlist), ylist(tlist), [colors_prob_list_indices(i), '--']); hold on;
        end
    end
end 
xlabel('Delta t (second)');
ylabel('Response value');
title(input_filename);
subplot(2, 1, 2);
for i= 1:NPair_Plotted_Standard_prob_lists
    i1  = (i-1)*2+1;	
    i2  = (i-1)*2+2;	
    ylist1= Average_Responses(i1, :);
    ylist2= Average_Responses(i2, :);
    tlist1 = find(ylist1 > 0);
    tlist2 = find(ylist2 > 0);
    if length(tlist1)>0 & isequal(tlist1, tlist2) ==1
	dylist = ylist2(tlist1)-ylist1(tlist1);
        plot(Unique_Stimulus_Durations(tlist1), dylist, colors_prob_list_indices(i1)); hold on;
    end	 	
end
plot(Unique_Stimulus_Durations, zeros(1, N_Unique_StimulusDurations), 'k--');
xlabel('Delta t (second)');
ylabel('accuracy');
title(input_filename);
%R=input('enter to continue');
% end
