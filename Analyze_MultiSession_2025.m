Filelist_Z={...
'Zhaoping_Li1-04-Dec-2024-22-48.mat';...  
'Zhaoping_Li2-05-Dec-2024-14-58.mat'; ...  
'Zhaoping_Li3-05-Dec-2024-21-24.mat'}; 

% %'Zhaoping_Li1-04-Dec-2024-20-46.mat'};  %--- this has Delta t >=0.03
% %'Zhaoping_Li1-10-Feb-2025-17-24.mat';  %--- only 8 trials, must be a demo session testing the code  
% % 'Zhaoping_Li1-10-Feb-2025-17-26.mat';  %--- has only the 270 homopair trials, so must be a practice session



Filelist_E = {...
'EsmaYavuz31-08-May-2025-15-45.mat';...
'EsmaYavuz30-08-May-2025-12-56.mat'; ...
'EsmaYavuz25-06-May-2025-10-35.mat';...  
'EsmaYavuz26-06-May-2025-12-45.mat'; ...  
'EsmaYavuz27-06-May-2025-15-16.mat'; ...  
'EsmaYavuz28-07-May-2025-13-7.mat';...
'EsmaYavuz29-07-May-2025-15-6.mat'};

% % 
Filelist_M = {...
'MariaPavlovic10-08-May-2025-12-13.mat'; ...
'MariaPavlovic9-08-May-2025-11-20.mat';...
'MariaPavlovic8-08-May-2025-10-6.mat'; ...
'MariaPavlovic6-06-May-2025-10-1.mat'; ...   
'MariaPavlovic7-06-May-2025-12-9.mat'};   
% % % 
Filelist_V = {...
'VladAksiotis32-09-May-2025-17-24.mat';...
'VladAksiotis31-09-May-2025-14-4.mat'; ...
'VladAksiotis30-09-May-2025-12-28.mat';...
'VladAksiotis29-08-May-2025-17-41.mat'; ...
'VladAksiotis28-08-May-2025-15-16.mat';...
'VladAksiotis27-08-May-2025-11-51.mat'; ...
'VladAksiotis26-08-May-2025-10-43.mat';...
'VladAksiotis25-07-May-2025-19-9.mat'; ...
'VladAksiotis24-07-May-2025-14-47.mat';...
'VladAksiotis23-07-May-2025-10-54.mat'};

Filelist_C = {...
        'ChristianHerm5-09-May-2025-16-48.mat';...
        'ChristianHerm4-09-May-2025-13-43.mat'; ...
   'ChristianHerm3-09-May-2025-12-3.mat'};     

Filelist  = Filelist_E;

FileRoot_Pathname = '';
Plot_PartOrAll =2;

Standard_data_filename = [FileRoot_Pathname, 'Zhaoping_Li3-05-Dec-2024-21-24.mat'];

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

% Filelist = {...
% 'Zhaoping_Li3-05-Dec-2024-21-24.mat';...
% 'Zhaoping_Li2-05-Dec-2024-14-58.mat';...
% 'MariaPavlovic1-05-Dec-2024-10-41.mat';...
% 'VladAksiotis14-02-May-2025-18-38.mat';...
% 'EsmaYavuz22-02-May-2025-16-55.mat';...
% 'VladAksiotis13-02-May-2025-13-53.mat';...
% 'VladAksiotis12-02-May-2025-12-53.mat';...
% 'MariaPavlovic5-02-May-2025-11-55.mat';...
% 'VladAksiotis11-02-May-2025-11-38.mat';...
% 'MariaPavlovic4-02-May-2025-10-18.mat';...
% 'EsmaYavuz21-01-May-2025-16-45.mat';...
% 'EsmaYavuz20-01-May-2025-14-39.mat';...
% 'VladAksiotis10-30-Apr-2025-17-6.mat';...
% 'VladAksiotis9-30-Apr-2025-15-37.mat';...
% 'VladAksiotis8-30-Apr-2025-13-17.mat';...
% 'VladAksiotis7-30-Apr-2025-10-42.mat';...
% 'VladAksiotis6-29-Apr-2025-17-24.mat';...
% 'VladAksiotis5-29-Apr-2025-13-13.mat';...
% 'MariaPavlovic3-29-Apr-2025-10-57.mat';...
% 'MariaPavlovic2-29-Apr-2025-9-56.mat';...
% 'VladAksiotis4-22-Apr-2025-17-26.mat';...
% 'EsmaYavuz19-22-Apr-2025-16-34.mat';...
% 'VladAksiotis3-22-Apr-2025-15-34.mat';...
% 'EsmaYavuz18-22-Apr-2025-14-45.mat';...
% 'VladAksiotis2-16-Apr-2025-17-54.mat';...
% 'VladAksiotis1-16-Apr-2025-16-44.mat';...
% 'EsmaYavuz17-16-Apr-2025-15-54.mat';...
% 'EsmaYavuz16-15-Apr-2025-18-12.mat';...
% 'EsmaYavuz15-15-Apr-2025-17-39.mat';...
% 'EsmaYavuz14-15-Apr-2025-15-53.mat';...
% 'EsmaYavuz13-15-Apr-2025-15-31.mat';...
% 'EsmaYavuz12-14-Apr-2025-15-43.mat';...
% 'EsmaYavuz11-14-Apr-2025-14-28.mat';...
% 'EsmaYavuz10-08-Apr-2025-17-28.mat';...
% 'EsmaYavuz9-08-Apr-2025-16-44.mat';...
% 'FaniLohrmann5-02-Apr-2025-15-23.mat';...
% 'FaniLohrmann4-02-Apr-2025-15-4.mat';...
% 'EsmaYavuz8-02-Apr-2025-12-23.mat';...
% 'EsmaYavuz7-02-Apr-2025-11-52.mat';...
% 'EsmaYavuz6-01-Apr-2025-18-43.mat';...
% 'EsmaYavuz5-01-Apr-2025-18-16.mat';...
% 'EmsaYavuz4-01-Apr-2025-17-14.mat';...
% 'EsmaYavuz3-31-Mar-2025-15-54.mat';...
% 'EsmaYavuz2-31-Mar-2025-15-17.mat';...
% 'EsmaYavuz1-31-Mar-2025-15-13.mat';...
% 'FaniLohnmann3-10-Feb-2025-18-13.mat';...
% 'FaniLohnmann2-10-Feb-2025-17-50.mat';...
% 'FaniLohnmann1-10-Feb-2025-17-46.mat';...
% 'Zhaoping_Li1-10-Feb-2025-17-26.mat';...
% 'Zhaoping_Li1-10-Feb-2025-17-24.mat'};
% 
% 
% 
% for fi = 1:length(Filelist)

% input_filename = input('give the file name of the data file', 's');


%--- accumulate trials in the Filelist
trial_count = 0;
if exist('AllTrial_Info') >0
      clear AllTrial_Info;
end
for fi = 1:length(Filelist)
    
    input_filename = Filelist{fi};
    
    input_filename=[FileRoot_Pathname, input_filename]
    
    %input_filename = '../VisualSearch_Exp_2021/FromWindowMachine/Backward_Masking2024/Zhaoping_Li2-05-Dec-2024-14-58.mat';
    %input_filename = '../VisualSearch_Exp_2021/FromWindowMachine/Backward_Masking2024/Zhaoping_Li3-05-Dec-2024-21-24.mat';
    %input_filename = '../VisualSearch_Exp_2021/FromWindowMachine/Backward_Masking2024/Zhaoping_Li1-04-Dec-2024-22-48.mat';
    %input_filename = '../VisualSearch_Exp_2021/FromWindowMachine/Backward_Masking2024/Zhaoping_Li1-10-Feb-2025-17-26.mat';
    %input_filename = '../VisualSearch_Exp_2021/FromWindowMachine/Backward_Masking2024/VladAksiotis1-16-Apr-2025-16-44.mat';
    
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
    
    NTrials = length(Trial_Info);
    for trial = 1:NTrials
        trial_count = trial_count+1;
        AllTrial_Info(trial_count) = Trial_Info(trial);
    end
end
Trial_Info  = AllTrial_Info;
NTrials = length(Trial_Info);
disp(sprintf('altogether %d trials', NTrials));

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
    if condition.AddMask ~=1  ... %no ending mask
            | condition.MaskDuration ~=0 ... %--- mask in the middle of the frames
            | condition.PresentationDuration ~= condition.PresentationPeriod   %--- more than one stimulus frame per trial
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


Trial_Response_LeftOrRight  = zeros(1, NTrials);
Trial_condition_index =  zeros(1, NTrials);
Trial_StimulusDuration=  zeros(1, NTrials);
Trial_Prob_list_index = zeros(1, NTrials);
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
end

Average_Response_Each_Condition =zeros(1, N_Conditions);
for i_condition = 1:N_Conditions
    Selected_Trials = find(Trial_condition_index == i_condition);
    Average_Response_Each_Condition(i_condition) = mean(Trial_Response_LeftOrRight(Selected_Trials));
end


Unique_Stimulus_Durations = unique(Trial_StimulusDuration);

N_Unique_StimulusDurations = length(Unique_Stimulus_Durations);
Average_Responses = zeros(N_Standard_prob_lists, N_Unique_StimulusDurations);

for i= 1:N_Standard_prob_lists
    for j= 1:N_Unique_StimulusDurations
        jj = Unique_Stimulus_Durations(j);
        Selected_Trials = find(Trial_Prob_list_index ==i & Trial_StimulusDuration == jj);
        if length(Selected_Trials)>0
            Average_Responses(i, j)=  mean(Trial_Response_LeftOrRight(Selected_Trials));
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
box off;
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
box off;
title(input_filename);
%R=input('enter to continue');
% end
