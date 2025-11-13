function ExperimentInfo=Update_InputParameters_ByDisplayInfo(ExperimentInfo)

%
InputParameters = ExperimentInfo.InputParameters;
Window_Width = ExperimentInfo.DisplayInfo.WindowWidthAndHeightInPixels.TotalScreenX;
Window_Height = ExperimentInfo.DisplayInfo.WindowWidthAndHeightInPixels.TotalScreenY;

%%%%%%%%%%%%%%%%%%
NbX  = InputParameters.NbX; 
NbY  = InputParameters.NbY;
if NbX ~=NbY
    error('NbX is not the same as NbY, this experimental design does not like this ');
end
    
StimulusSquareSideLength  =round(InputParameters.Disk_Radius_in_Scale *2 * Window_Width);
%--- make it even
if mod(StimulusSquareSideLength, 2) ==1
    StimulusSquareSideLength=StimulusSquareSideLength+1;
end

ItemSize = StimulusSquareSideLength/NbX
Size = round(InputParameters.Size_To_ItemSize_Ratio*ItemSize)
Sizebar = round(Size*InputParameters.Sizebar_To_Size_Ratio)
%%--- make sure that Size-Sizebar is an even number.
if mod(Size-Sizebar, 2) ~=0
	Size  = Size+1;
end

BarWidth  = round(Sizebar*InputParameters.BarWidth_To_Sizebar_Ratio); % I assume this is the size of the dot pairs
[AllCubes,  BlackOrWhiteOrBoth_AllCubes, ItemTypes] = GetAllCubes_Feb2021(Size, Sizebar, InputParameters.SmallAngle, BarWidth); %--- get AllCubes, ItemTypes, in which Conditions_ForExp are expressed.


Needed_AllCube_IndexList=InputParameters.Needed_AllCube_IndexList;

Cube_Images = zeros(length(Needed_AllCube_IndexList), Size, Size);

for i = 1:length(Needed_AllCube_IndexList)
	Cube_Images(i, :, :) = AllCubes(Needed_AllCube_IndexList(i), :, :);

end
%
%if ExperimentInfo.Debugging_Mode==1
%    figure(1); clf;
%    for i = 1:length(Needed_AllCube_IndexList)
%        Ntem = ceil(sqrt(length(Needed_AllCube_IndexList)));
%        subplot(Ntem, Ntem, i);
%        imshow(squeeze(Cube_Images(i, :, :)), [0, 1]); colormap(gray);
%        title(InputParameters.Cube_Labels{i});
%    end
%end


InputParameters.Size = Size;
InputParameters.Sizebar = Sizebar;
InputParameters.Cube_Images = Cube_Images;
InputParameters.ItemSize = ItemSize;

InputParameters.StimulusSquareSideLength = StimulusSquareSideLength;

%InputParameters.StimulusCenter.x_in_Pixel = Window_Width*InputParameters.StimulusCenter.x_in_Scale;
%InputParameters.StimulusCenter.y_in_Pixel = Window_Height*InputParameters.StimulusCenter.y_in_Scale;

ExperimentInfo.InputParameters = InputParameters;
