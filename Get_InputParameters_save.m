function InputParameters = Get_InputParameters()


Needed_AllCube_IndexList  = [48    49    50    51    52    53    55    54]; %--- these are the indices of the needed homo and hetero pairs of dots
									   %--- as in GetAllCubes_Feb2021.m
Cube_Labels = {'left tilted, homo-black'  'left tilted, homo-white', 'left tilted, hetero-black-top', 'left tilted, hetero-white-top', ...
		'right tilted, Homo black'  'right tilted, homo white', 'right tilted, hetero-black-top', 'right tilted, hetero-white-top'};

Prob_lists{1} = [0.5, 0.5,  0, 0, 0, 0, 0, 0];  %--- homo, left tilted
Prob_lists{2} = [0, 0, 0, 0, 0.5, 0.5, 0, 0]; %--- homo, right tilted
Prob_lists{3} = [0, 0,  0.5, 0.5, 0, 0, 0, 0];  %--- hetero, left tilted
Prob_lists{4} = [0, 0,  0, 0, 0, 0, 0.5, 0.5];  %--- hetero, right tilted
Prob_lists{5} = [0.1, 0.1,  0.4, 0.4, 0, 0, 0, 0];  %--- homo 20%, hetero 80%, left tilted
Prob_lists{6} = [0, 0, 0, 0, 0.1, 0.1, 0.4, 0.4]; %---   homo 20%, hetero 80%, right tilted
Prob_lists{7} = [0.1, 0.1,  0, 0, 0, 0, 0.4, 0.4];  %--- homo 20% left tilted, congruent hetero 80%, right tilted
Prob_lists{8} = [0, 0, 0.4, 0.4, 0.1, 0.1, 0, 0]; %---   homo 20%, right tilted, congruent hetero 80%, left tilted

BackgroundScale = 0.5; %--- background
LowScale = 0;
HighScale = 1;

Size_To_ItemSize_Ratio = 1/2;
Sizebar_To_Size_Ratio  = 0.7;
BarWidth_To_Sizebar_Ratio  = 1/10;
SmallAngle  = 10;
GapDuration = 0.2; %---- determine the Duration of gap between fixation point disappearance and search array appearance.
FixationDuration = 0.7; %---- determine the Duration of gap between fixation point disappearance and search array appearance.

Max_JitterFactor_x = 0.8;  %--- jitter by 80% of the allowed space.
Max_JitterFactor_y = 0.8;  %--- jitter by 80% of the allowed space.



NTrials = 10;

NbX = 12;
NbY = 12;
if NbX ~= NbY
    error('NbX and NbY are unequal to each other, not suitable for this project');
end
Disk_Radius_in_Scale = 0.15;
NCircles = 2*NbX;
Mininum_Circle_Diameter_to_Size=7.5;
Maximum_Circle_Diameter_to_Size=15.5;

InputParameters.NCircles = NCircles;
InputParameters.Mininum_Circle_Diameter_to_Size = Mininum_Circle_Diameter_to_Size;
InputParameters.Maximum_Circle_Diameter_to_Size = Maximum_Circle_Diameter_to_Size;



NTrials_EachCondition = [];

count  = 0;
for StaticOrDynamic = 1:2
	for prob_i = 1:8
		condition.prob_list = Prob_lists{prob_i};
		condition.PresentationDuration= 0.5;
		if StaticOrDynamic==1	
			condition.PresentationPeriod = condition.PresentationDuration;
		else
			condition.PresentationPeriod = 0.02;
		end
		count  = count+1;
		Conditions(count) = condition;
		NTrials_EachCondition = [NTrials_EachCondition, NTrials];
	end
end
NConditions = length(NTrials_EachCondition);

InputParameters.Needed_AllCube_IndexList = Needed_AllCube_IndexList;
InputParameters.Cube_Labels = Cube_Labels;
InputParameters.NTrials_EachCondition = NTrials_EachCondition;
InputParameters.Conditions = Conditions;


InputParameters.NbX = NbX;
InputParameters.NbY = NbY;

InputParameters.Disk_Radius_in_Scale = Disk_Radius_in_Scale;
%

%
InputParameters.Size_To_ItemSize_Ratio = Size_To_ItemSize_Ratio;
InputParameters.Sizebar_To_Size_Ratio = Sizebar_To_Size_Ratio;
InputParameters.BarWidth_To_Sizebar_Ratio=BarWidth_To_Sizebar_Ratio;
InputParameters.SmallAngle =SmallAngle ;
InputParameters.GapDuration =GapDuration ;
InputParameters.FixationDuration=FixationDuration;




InputParameters.BackgroundScale=BackgroundScale;
InputParameters.LowScale =LowScale;
InputParameters.HighScale=HighScale;


% Sizebar = round(Size*InputParameters.Sizebar_To_Size_Ratio);
% %%--- make sure that Size-Sizebar is an even number.
% if mod(Size-Sizebar, 2) ~=0
%         Size  = Size+1;
% end
% BarWidth  = round(Sizebar*InputParameters.BarWidth_To_Sizebar_Ratio);
% [AllCubes,  BlackOrWhiteOrBoth_AllCubes, ItemTypes] = GetAllCubes_Feb2021(Size, Sizebar, InputParameters.SmallAngle, BarWidth); %--- get AllCubes, ItemTypes, in which Conditions_ForExp are expressed.
% 
% figure(1); clf;
% Cube_Images = zeros(length(Needed_AllCube_IndexList), Size, Size);
% for i = 1:length(Needed_AllCube_IndexList)
% 	Cube_Images(i, :, :) = AllCubes(Needed_AllCube_IndexList(i), :, :);
% 	Ntem = ceil(sqrt(length(Needed_AllCube_IndexList)));
% 	subplot(Ntem, Ntem, i);
% 	imshow(squeeze(Cube_Images(i, :, :)), [0, 1]); colormap(gray);
% 	title(Cube_Labels{i});
% end
% 
% InputParameters.Size = Size;
% InputParameters.Sizebar = Sizebar;
% InputParameters.Cube_Images = Cube_Images;




InputParameters.Max_JitterFactor_x = Max_JitterFactor_x;
InputParameters.Max_JitterFactor_y = Max_JitterFactor_y;

% -------GapDuration, FixationDuration backgroundScale
%
%--- Dot_Size and Fixation Radius.

Fixation_Size_To_CubeSize_Ratio = 1.0/3;
InputParameters.Fixation_Size_To_CubeSize_Ratio = Fixation_Size_To_CubeSize_Ratio;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% -----
%---------- AllCubes, ItemTypes, NewAllCubes, NewItemTypes, NewConditions_ForExp, Dot_Size, 
%-----------FixationRadius, New2Old_ItemTypeIndices, New2Old_CubeIndices  ------
%---------
% -------------
%--- Get the AllCubes and ItemTypes using GetAllCubes_Aug2017.m, the size of each item 
%----is the same across the different conditions or set sizes.
%---



%%%%%%%%%%%%%%%%%%% Instruction text
Instructions_Page{1}{1} ='In each trial, you will see an image like this, containing many pairs of dot';
Instructions_Page{1}{2} ='Your task is to report whether on average these dot pairs are tilted to the left or right';
Instructions_Page{1}{3}= 'press a left/right button, to report if the average tilt is to the left/right';
Instructions_Page{1}{4}= 'Sit comfortably in front of the display, chin on chin stand, fingers of the left/right hand on the left/right buttons';
%--- these are the displacement of the instructions from the center of each eye display
Instructions_Page_xy{1} = [0, -400; 0, -250; 0, +40; 0, +230];

%
Instructions_Inter_Item_Distance_To_Size = 4;
%%%%%%%%%%%%%%  Example visual search condition to show in the Instruction.

InputParameters.Instructions_Page= Instructions_Page;
InputParameters.Instructions_Page_xy = Instructions_Page_xy;

InputParameters.Instructions_Inter_Item_Distance_To_Size = Instructions_Inter_Item_Distance_To_Size;
%
InputParameters.Fixation_Size_To_CubeSize_Ratio = Fixation_Size_To_CubeSize_Ratio;
InputParameters.FontSize_To_Sizebar = 1/2.5;
