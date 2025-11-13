function StimulusItems_Sizes_Conditions=GetNewItemTypesAndAllCubes(ExperimentInfo)

%
InputParameters = ExperimentInfo.InputParameters;
Window_Width = ExperimentInfo.DisplayInfo.WindowWidthAndHeightInPixels.TotalScreenX;
Window_Height = ExperimentInfo.DisplayInfo.WindowWidthAndHeightInPixels.TotalScreenY;

%%%%%%%%%%%%%%%%%%
NbX  = max(InputParameters.SetSizes_ForExp(:, 1));  
NbY  = max(InputParameters.SetSizes_ForExp(:, 2));  

ItemSize = min([Window_Width/NbX, Window_Height/NbY]);
Size = round(InputParameters.Size_To_ItemSize_Ratio*ItemSize);
Sizebar = round(Size*InputParameters.Sizebar_To_Size_Ratio);

%%--- make sure that Size-Sizebar is an even number.
if mod(Size-Sizebar, 2) ~=0
	Size  = Size+1;
end
BarWidth  = round(Sizebar*InputParameters.BarWidth_To_Sizebar_Ratio);
Conditions_ForExp = InputParameters.Conditions_ForExp_By_ItemTypes;
NConditions = length(Conditions_ForExp);


[AllCubes,  BlackOrWhiteOrBoth_AllCubes, ItemTypes] = GetAllCubes_Feb2021(Size, Sizebar, InputParameters.SmallAngle, BarWidth); %--- get AllCubes, ItemTypes, in which Conditions_ForExp are expressed.





%----- Second, the generic part, depending on specifics of the experiment.
%
%------- from AllCubes, ItemTypes, Conditions_ForExp,  
%-------build NewAllCubes, and NewItemTypes,  NewConditions_ForExp.
%
List_Of_ItemTypes = [];
List_Of_Cubes = [];

for c = 1:NConditions
	NSub_Conditions = length(Conditions_ForExp{c});	
	for cc = 1:NSub_Conditions
		tem_ItemType = Conditions_ForExp{c}(cc); 
		tem_CubeList = ItemTypes(tem_ItemType, :);  %--- ItemTypes are in GetAllCubes_Aug2017.m, defining Conditions_ForExp.
		List_Of_Cubes = [List_Of_Cubes, tem_CubeList];
		List_Of_ItemTypes = [List_Of_ItemTypes, tem_ItemType];
	end 	
end

%%%%% --- Build NewItemTypes --- 
%--- From ItemTypes, build NewItemTypes.
New2Old_ItemTypeIndices = unique(List_Of_ItemTypes); %--- this means New2Old_ItemTypeIndices(i) lists the index in ItemType of the i-th NewItemType, i.e., NewItemType(i, [1, 2, 3]) correspond to ItemType(New2Old_ItemTypeIndices(i), [1, 2, 3]), i.e., New2Old_CubeIndices(NewItemType(i, :)) = ItemType(New2Old_ItemTypeIndices(i), :); 

%%%%--- Build NewAllCubes ----
New2Old_CubeIndices= unique(List_Of_Cubes); %--- New2Old_CubeIndices(i) is the Cube Index of i-th cube in NewAllCubes in AllCubes, i.e., NewAllCubes(i, :, :) = AllCubes(New2Old_CubeIndices(i), :, :);

%%-----------------------
N_NewItemTypes = length(New2Old_ItemTypeIndices);
NewItemTypes = zeros(N_NewItemTypes, 3);   %------ this is it.
for i = 1: N_NewItemTypes
	Old_ItemType_Index = New2Old_ItemTypeIndices(i); 	
	Three_OldCube_Indices = ItemTypes(Old_ItemType_Index, :);
	temlist = zeros(1, 3);
	for j = 1:3
		temlist(j) = find(New2Old_CubeIndices ==Three_OldCube_Indices(j)); 
	end	 		
	NewItemTypes(i, :) = temlist;
end

%---- Build NewAllCubes ------
N_NewCubes = length(New2Old_CubeIndices);
NewAllCubes = zeros(N_NewCubes, Size, Size);  %--- N_NewCubes images of visual items, each SizexSize pixels.
for i = 1: N_NewCubes
	NewAllCubes(i, :, :) = squeeze(AllCubes(New2Old_CubeIndices(i), :, :));
end 


%--- From Conditions_ForExp, make the corresponding NewConditions_ForExp, expressed in terms of 
% --- NewItemTypes, and NewAllCubes
for c = 1:NConditions
	temlist  = []; % build up NewConditions_ForExp{c} using temlist 
	NSub_Conditions = length(Conditions_ForExp{c});	
	for cc = 1:NSub_Conditions
		tem =Conditions_ForExp{c}(cc);
		tem2 = find(New2Old_ItemTypeIndices == tem);
		temlist  = [temlist, tem2];
	end
	NewConditions_ForExp{c} = temlist;
end

StimulusItems_Sizes_Conditions.NewAllCubes = NewAllCubes;
StimulusItems_Sizes_Conditions.NewItemTypes= NewItemTypes;
StimulusItems_Sizes_Conditions.NewConditions_ForExp=NewConditions_ForExp;
StimulusItems_Sizes_Conditions.Size =Size;
StimulusItems_Sizes_Conditions.Sizebar=Sizebar;
