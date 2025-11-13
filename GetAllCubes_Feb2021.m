%---- modified from GetAllCubes_Jan2021.m in Feb.  2021, to make it a function.


function [AllCubes, BlackOrWhiteOrBoth_AllCubes, ItemTypes] = GetAllCubes_Feb2021(Size, Sizebar, SmallAngle, BarWidth)

%--- July 13, 2017, modified from GetAllCubes_2013.m --- create matrices of Size x Size for
%---- items, which can be used in visual search arrays.
%--- given variables Size, Sizebar (< Size), BarWidth, SmallAngle, CloseMovePixels
%---- All these items are black in white background, with maximum value maxValue/2 =1 and minimum values = 0;
% 
%
%--- Modified Oct. 2013 by Zhaoping to add Condition A' and B' in Zhaoping & Guyader 2007, and a condition for a triangle among squres, added to the end of the code, square and triangles were adopted and checked from Mara's code.
%--- Modified March 15, 2011 to include Cubes for X shape and thin X shape as in Zhaoping and Guyader 2007 paper, and include their search conditions in ItemTypes definition.
%Modified from GetAllCubes06New.m on Jan 19, 2007, so that everytime I need
% to add new items or conditions, I can just do it in this code without
% changeing PureTracking.m

%Modified from GetAllCube06.m to make letters as black letters on grey
%background --- July 21. 2006.
% This programm created all the same items which are used to create the
% stimuli
% this programm is called by PureTracking_1


%global CubeVer CubeLeftVertical CubeRightVertical CubeHor Cube45 CubeOtherAngle CubeOtherAngle2 
%global Cubem45 CubemOtherAngle CubemOtherAngle2 
%global CubeMask CubeN CubeRN CubeZ CubeRZ CubeNclose CubeZclose CubeRNclose CubeRZclose
%global CubeNFar CubeRNFar CubeZFar CubeRZFar CubeNScrewed CubeRNScrewed CubeZScrewed CubeRZScrewed


if exist('SmallAngle') ==0
	SmallAngle  = 10;
end
if exist('CloseMovePixel') ==0
	CloseMovePixel = round(Sizebar/6);
end
if exist('InMovePixel') ==0
	InMovePixel = round(Sizebar*5/24); 
end
if exist('DownMovePixel') ==0
	DownMovePixel = round(Sizebar*5/24); 
end
if exist('OutMovePixel') ==0
	OutMovePixel = round(Sizebar*5/24); 
end


%Size=36; Sizebar = 24; BarWidth  = 2; SmallAngle = 10; 
%CloseMovePixel = Sizebar/6;

%--- define the default target and distractor types for each condition
AllItems = 1:60;   %--- increased from 1:30 in Oct. 2013.
Nitemtypes = max(size(AllItems));
ItemTypes = zeros(100, 3);   % changed from ItemTypes = zeros(40, 3) in Oct 2013;  
			    %---- ItemTypes(condition, :) = [TargetType, Distractor1, Distractor2]  of condition 
                            % Types = 1, 2, 3, 4 for N, inverse N, Z, and
                            % inverse Z.
ItemTypes(1, :) = [1, 2, 2];
ItemTypes(2, :) = [2, 1, 1];
ItemTypes(3, :) = [3, 4, 4];
ItemTypes(4, :) = [4, 3, 3];
ItemTypes(5, :) = [1, 3, 3];
ItemTypes(6, :) = [2, 4, 4];
ItemTypes(7, :) = [3, 1, 1];
ItemTypes(8, :) = [4, 2, 2];
ItemTypes(9, :) = [1, 4, 4];
ItemTypes(10, :) = [2, 3, 3];
ItemTypes(11, :) = [3, 2, 2];
ItemTypes(12, :) = [4, 1, 1];
        %---- these followings are default, switch ItemTypes(:, 2) and
        %ItemTypes(:, 3) by 50% chance randomly.
ItemTypes(13, :) = [1, 2, 3];
ItemTypes(14, :) = [4, 2, 3];
ItemTypes(15, :) = [2, 1, 4];
ItemTypes(16, :) = [3, 1, 4];
ItemTypes(17, :) = [5, 6, 7];
ItemTypes(18, :) = [8, 6, 7];
ItemTypes(19, :) = [6, 5, 8];
ItemTypes(20, :) = [7, 5, 8];
ItemTypes(21, :) = [9, 10, 11];
ItemTypes(22, :) = [12, 10, 11];
ItemTypes(23, :) = [10, 9, 12];
ItemTypes(24, :) = [11, 9, 12];
ItemTypes(25, :) = [17, 19, 19];   % target: vertical bar, distractor: left tilted (small angle) from vertical bar.
ItemTypes(26, :) = [17, 20, 20];   % target: vertical bar, distractor, right tilted (small angle) from vertical bar.
ItemTypes(27, :) = [19, 17, 17];    % target: (smal angle) left tilted (from vertical) bar, distractor: vertical bar.
ItemTypes(28, :) = [20, 17, 17];    % target: (smal angle) right tilted (from vertical) bar, distractor: vertical bar.
%-----------------------------------------------
maxValue = 2;

% Get the basic Horizontal and Vertical bars------------------------------
CubeVer = zeros(Sizebar);
CubeHor = zeros(Sizebar);
x=linspace(-1,1,Sizebar);
y=linspace(-1,1,Sizebar);
[X Y]=meshgrid(x,y);
one_bar=exp(-(X/(BarWidth/Sizebar)).^10);

CubeVer=one_bar;

CubeHor  = CubeVer';
% normalisation 
CubeVer=maxValue*CubeVer/max(max(CubeVer));
CubeHor=maxValue*CubeHor/max(max(CubeHor));




%Get the other tilted bars-------------------------------------------------
OtherAngle = 20; 
%SmallAngle = 13; Feb 6, 2007, put in SubjectTestNew.m as a parameter.
for AngleType = 1:3
    if AngleType ==1    
        Angle = 45;
    elseif AngleType ==2
        Angle = OtherAngle;
    else
        Angle = SmallAngle;
    end   
    CubeAngle= imrotate(CubeVer,Angle,'bicubic','crop');
    CubeAngle = (CubeAngle> 0).*CubeAngle;
    totallum = sum(sum(CubeVer));
    for re = 1:4
        totallumTarget = sum(sum(CubeAngle));
        CubeAngle = totallum/totallumTarget*CubeAngle;
        temMatrix = CubeAngle;
        CubeAngle = (temMatrix> maxValue).*ones(Sizebar)*maxValue + (temMatrix<=maxValue).*temMatrix;
    end
    if AngleType ==1    
        Cube45 = CubeAngle;
    elseif AngleType ==2
        CubeOtherAngle = CubeAngle;
    else CubeSmallAngle = CubeAngle;
    end 
end


CubeOtherAngle2 = CubeOtherAngle';
%Get the negative tilted bars
seq = 1:1:Sizebar;
seq2 = Sizebar:-1:1;
Cubem45(:, seq2) = Cube45(:, seq);
CubemOtherAngle(:, seq2) = CubeOtherAngle(:, seq);
CubemOtherAngle2(:, seq2) = CubeOtherAngle2(:, seq);


columnvalue45 = max(Cube45, [], 1);
for i = 1:Sizebar
    if columnvalue45(i) > maxValue*0.01
        leftcolumn = i; break;
    end
end
for i = 0:Sizebar-1
    if columnvalue45(Sizebar-i) > maxValue*0.01
        rightcolumn = Sizebar-i; break;
    end
end
columnvalueVer = max(CubeVer, [], 1);
for i = 1:Sizebar
    if columnvalueVer(i) > maxValue*0.01
        leftcolumnVer = i; break;
    end
end
rowvalue45 = max(Cube45, [], 2);
for i = 1:Sizebar
    if rowvalue45(i) > maxValue*0.01
        toprow = i; break;
    end
end

gap = leftcolumnVer-leftcolumn+1;
CubeLeftVertical = CubeVer(:, [1:leftcolumn-2,leftcolumnVer:Sizebar, 1:gap]);
%% random attempt to fix issue, PS 7/2
if leftcolumn-2 < 0
    CubeLeftVertical = CubeLeftVertical(:,1+leftcolumn:end);
end
%%
CubeLeftVertical(1:toprow, :) = zeros(toprow, Sizebar);
CubeLeftVertical(Sizebar-toprow+1:Sizebar, :) = zeros(toprow, Sizebar);
CubeRightVertical = CubeLeftVertical(:, Sizebar:-1:1);


Cube1 = max(CubeLeftVertical, CubeRightVertical);
CubeNsizebar = max(Cube1, Cube45);
%--- get CubeN from the smaller CubeNsizebar by padding on the sides from
CubeN = zeros(Size, Size); CubeVerticalBar = zeros(Size, Size); CubeSmallAngleSize = zeros(Size, Size);
SideGap = (Size-Sizebar)/2;
CubeN(SideGap+1:Size-SideGap, SideGap+1:Size-SideGap) = CubeNsizebar;
CubeVerticalBar(SideGap+1:Size-SideGap, SideGap+1:Size-SideGap) = CubeVer;
CubeSmallAngleSize(SideGap+1:Size-SideGap, SideGap+1:Size-SideGap) = CubeSmallAngle;
CubeN = maxValue/2*ones(Size) - CubeN/2;
CubeVerticalBar = maxValue/2*ones(Size) - CubeVerticalBar/2;
CubeSmallAngleSize = maxValue/2*ones(Size)  -CubeSmallAngleSize /2;
CubeRN = CubeN(:, Size:-1:1);
CubeRZ = CubeN';
CubeZ = CubeRN';

%--- now make CubeNclose, CubeRNclose, CubeZclose, CubeRZclose;

CubeLeftVerticalClose = CubeLeftVertical(:, ...
    [Sizebar-CloseMovePixel:Sizebar, 1:Sizebar-CloseMovePixel-1]);
CubeRightVerticalClose = CubeLeftVerticalClose(:, Sizebar:-1:1);
Cube1close = max(CubeLeftVerticalClose, CubeRightVerticalClose);
CubeNclosesizebar = max(Cube1close, Cube45);
CubeNclose = zeros(Size, Size);
CubeNclose(SideGap+1:Size-SideGap, SideGap+1:Size-SideGap) =CubeNclosesizebar;
CubeNclose = maxValue/2*ones(Size) - CubeNclose/2;
CubeRNclose = CubeNclose(:, Size:-1:1);
CubeRZclose = CubeNclose';
CubeZclose = CubeRNclose';

Cube45Size = zeros(Size, Size);
Cube45Size(SideGap+1:Size-SideGap, SideGap+1:Size-SideGap) =Cube45;
CubeLeftVerticalSize = zeros(Size, Size);
CubeLeftVerticalSize(SideGap+1:Size-SideGap, SideGap+1:Size-SideGap) =CubeLeftVertical;

% % %--- trying to move the vertical bars in and down/up

CubeLeftVerticalFar = CubeLeftVerticalSize(:, ...
    [Size-InMovePixel:Size, 1:Size-InMovePixel-1]);
CubeLeftVerticalFar = CubeLeftVerticalFar([Size-DownMovePixel+1:Size, 1:Size-DownMovePixel], :);
CubeRightVerticalFar = CubeLeftVerticalFar(:, Size:-1:1);
CubeRightVerticalFar = CubeRightVerticalFar(Size:-1:1, :);
Cube1Far = max(CubeLeftVerticalFar, CubeRightVerticalFar);
CubeNScrewed = max(Cube1Far, Cube45Size);
CubeNScrewed = maxValue/2*ones(Size) - CubeNScrewed/2;
CubeRNScrewed= CubeNScrewed(:, Size:-1:1);
CubeRZScrewed = CubeNScrewed';
CubeZScrewed = CubeRNScrewed';
%--------

%--- trying to move the bars out;

CubeLeftVerticalFar = CubeLeftVerticalSize(:, [OutMovePixel+1:Size, 1:OutMovePixel]);
CubeRightVerticalFar = CubeLeftVerticalFar(:, Size:-1:1);
Cube1Far = max(CubeLeftVerticalFar, CubeRightVerticalFar);
CubeNFar = max(Cube1Far, Cube45Size);
CubeNFar = maxValue/2*ones(Size) - CubeNFar/2;
CubeRNFar= CubeNFar(:, Size:-1:1);
CubeRZFar = CubeNFar';
CubeZFar = CubeRNFar';



%Get the negative tilted bars
seq = 1:1:Sizebar;
seq2 = Sizebar:-1:1;
Cubem45(:, seq2) = Cube45(:, seq);

%Get the mask cube
Cube1 = max(CubeHor, CubeVer); Cube2 = max(Cube45, Cubem45);
Cube3 = max(CubeOtherAngle, CubemOtherAngle); Cube4 = max(CubeOtherAngle2, CubemOtherAngle2);
Cube5 = max(Cube1, Cube2); Cube6 = max(Cube3, Cube4);
CubeMaskSizebar = max(Cube5, Cube6);
CubeMask = zeros(Size, Size);
CubeMask(SideGap+1:Size-SideGap, SideGap+1:Size-SideGap) =CubeMaskSizebar;
CubeMask = maxValue/2*ones(Size) - CubeMask/2;

%--- set up AllCubes
AllCubes = zeros(Nitemtypes, Size, Size);
BlackOrWhiteOrBoth_AllCubes = zeros(Nitemtypes, 1);

AllCubes(1, :, :) = CubeN;     %--- letter N
AllCubes(2, :, :) = CubeRN;    %----mirrir image of letter N
AllCubes(3, :, :) = CubeZ;     %--- letter Z
AllCubes(4, :, :) = CubeRZ;    % mirror image of letter Z
AllCubes(5, :, :) = CubeNclose;  %--- letter N with two vertical bars closer
AllCubes(6, :, :) = CubeRNclose;  %--- mirror image of CubeNclose
AllCubes(7, :, :) = CubeZclose;   %--- letter Z with two horizontal bars closer
AllCubes(8, :, :) = CubeRZclose;   % mirror image of CubeZclose
AllCubes(9, :, :) = CubeNScrewed;   % --- letter N with two vertical bars closer and up/down
AllCubes(10, :, :)= CubeRNScrewed;   %--- mirror image of CubeNScrewed
AllCubes(11, :, :)= CubeZScrewed;     %---- letter Z with two horizontal bars closer and left/right
AllCubes(12, :, :)= CubeRZScrewed;     %--- mirror image of CubeZScrewed
AllCubes(13, :, :)= CubeNFar;          %--- letter N with two vertical bars further
AllCubes(14, :, :)= CubeRNFar;     % mirror image of CubeNFar
AllCubes(15, :, :)= CubeZFar;       % letter Z with two horizontal bars further
AllCubes(16, :, :)= CubeRZFar;      % mirror image of CubeZfar
AllCubes(17, :, :)= CubeVerticalBar;   %vertical bar
AllCubes(18, :, :)= CubeVerticalBar';   %horizontal bar
AllCubes(19, :, :)=CubeSmallAngleSize;      %--- left tilted bar (from vertical) by the SmallAngle;
CubeRightSmallAngleSize(:, Size:-1:1) = CubeSmallAngleSize;
AllCubes(20, :, :)=CubeRightSmallAngleSize;  %--- right tilted bar (from vertical) by the SmallAngle;


%%%%%%%%%%%%%%%%%%%% Add March 15, 2011, to do the experiment on autistic project. 


CubeLeft45Ver = zeros(Size, Size);
CubeLeft45Versizebar = max(CubeVer, Cube45);
CubeLeft45Ver(SideGap+1:Size-SideGap, SideGap+1:Size-SideGap) = CubeLeft45Versizebar;
CubeLeft45Ver = maxValue/2*ones(Size) - CubeLeft45Ver/2;
CubeRight45Ver = CubeLeft45Ver(:, Size:-1:1);
CubeLeft45Hor = CubeLeft45Ver';
CubeRight45Hor =CubeRight45Ver';





CubeLeftVer_ThinX =  zeros(Size, Size);
CubeLeftVer_ThinXsizebar =  max(CubeVer, CubeOtherAngle);
CubeLeftVer_ThinX(SideGap+1:Size-SideGap, SideGap+1:Size-SideGap) = CubeLeftVer_ThinXsizebar;
CubeLeftVer_ThinX = maxValue/2*ones(Size) - CubeLeftVer_ThinX/2;
CubeRightVer_ThinX = CubeLeftVer_ThinX(:, Size:-1:1);
CubeLeftHor_ThinX = CubeLeftVer_ThinX';
CubeRightHor_ThinX =CubeRightVer_ThinX';




AllCubes(21, :, :) = CubeLeft45Ver;
AllCubes(22, :, :) = CubeRight45Ver;
AllCubes(23, :, :) = CubeLeft45Hor;
AllCubes(24, :, :) = CubeRight45Hor;


AllCubes(25, :, :) = CubeLeftVer_ThinX;
AllCubes(26, :, :) = CubeRightVer_ThinX;
AllCubes(27, :, :) = CubeLeftHor_ThinX;
AllCubes(28, :, :) = CubeRightHor_ThinX;


%--- 4 different variations of x shape among other x shapes, orientation singleton.
ItemTypes(29, :) = [21, 24, 22]; %--- left45-Ver, Right45-Hor, Right45-Ver.
ItemTypes(30, :) = [23, 22, 24]; %--- left45-Hor, Right45-Ver, Right45-Hor.
ItemTypes(31, :) = [22, 23, 21]; %--- Right45-Ver, Left45-Hor, Left45-Ver.
ItemTypes(32, :) = [24, 21, 23]; %--- Right45-Hor, Left45-Ver, Left45-Hor.

%--- 4 different variations of Thin x shape among fat  x shapes, orientation singleton.
ItemTypes(33, :) = [25, 24, 22]; %--- left45-Ver, Right45-Hor, Right45-Ver.
ItemTypes(34, :) = [27, 22, 24]; %--- left45-Hor, Right45-Ver, Right45-Hor.
ItemTypes(35, :) = [26, 23, 21]; %--- Right45-Ver, Left45-Hor, Left45-Ver.
ItemTypes(36, :) = [28, 21, 23]; %--- Right45-Hor, Left45-Ver, Left45-Hor.



%--- Condition A', starting to use for Palermo project, Oct, 2013
%---
% condition A' stimuli:
ItemTypes(37, :) = [21, 22, 22]; %--- left45-Ver, Right45-Ver,Right45-Ver.
ItemTypes(38, :) = [23, 24, 24]; %--- left45-Hor, Right45-Hor,Right45-Hor.
ItemTypes(39, :) = [22, 21, 21]; %--- Right45-Ver, Left45-Ver, Left45-Ver.
ItemTypes(40, :) = [24, 23, 23]; %--- Right45-Hor, Left45-Hor, Left45-Hor.

%--- Condition B', starting to use for Palermo project, added Oct, 2013, after the triangle among square conditions.
ItemTypes(45, :) = [25, 22, 22]; %--- leftOTherAngle-Ver, Right45-Ver,Right45-Ver.
ItemTypes(46, :) = [27, 24, 24]; %--- leftOtherAngle-Hor, Right45-Hor,Right45-Hor.
ItemTypes(47, :) = [26, 21, 21]; %--- RightOtherAngle-Ver, Left45-Ver, Left45-Ver.
ItemTypes(48, :) = [28, 23, 23]; %--- RightOtherAngle-Hor, Left45-Hor, Left45-Hor.



%Make cubes for procedure practice trials stimuli:, Oct, 2013
%Make square cube
CubeSquare = zeros(Size,Size);
CubeBottomHorizontal = rot90(CubeLeftVertical);
CubeTopHorizontal = rot90(CubeRightVertical);
CubeSquareSmall = max(CubeLeftVertical,CubeBottomHorizontal);
CubeSquareSmall = max(CubeSquareSmall, CubeTopHorizontal);
CubeSquareSmall = max(CubeSquareSmall, CubeRightVertical);
CubeSquare(SideGap+1:Size-SideGap, SideGap+1:Size-SideGap) = CubeSquareSmall;
%Normalization and invert contrast:
CubeSquare = maxValue/2*ones(Size) - CubeSquare/2;

% Make triangle cubes, Oct, 2013
CubeTriangleSmall = max(CubeLeftVertical, CubeBottomHorizontal);
CubeTriangleSmall = max(CubeTriangleSmall, Cube45);
CubeLeftDownPointingTriangle = zeros(Size,Size);
CubeLeftDownPointingTriangle(SideGap+1:Size-SideGap, SideGap+1:Size-SideGap) = CubeTriangleSmall;
%Normalization and invert contrast
CubeLeftDownPointingTriangle = maxValue/2*ones(Size) - CubeLeftDownPointingTriangle/2;
% Make triangles pointing in other directions
CubeRightDownPointingTriangle = rot90(CubeLeftDownPointingTriangle);
CubeRightUpPointingTriangle = rot90(CubeRightDownPointingTriangle);
CubeLeftUpPointingTriangle = rot90(CubeRightUpPointingTriangle);

%---- Add new cubes into AllCubes, Oct, 2013
AllCubes(29,:,:) = CubeSquare;
AllCubes(30,:,:) = CubeRightDownPointingTriangle;
AllCubes(31,:,:) = CubeLeftDownPointingTriangle;
AllCubes(32,:,:) = CubeRightUpPointingTriangle;
AllCubes(33,:,:) = CubeLeftUpPointingTriangle;

%4 variations of triangle among squares, add into ItemTypes, Oct, 2013
ItemTypes(41,:) = [30, 29, 29]; %--- RightDownPointingTriangle, Square,Square
ItemTypes(42,:) = [31, 29, 29]; %--- LeftDownPointingTriangle, Square,Square
ItemTypes(43,:) = [32, 29, 29]; %--- RightUpPointingTriangle, Square,Square
ItemTypes(44,:) = [33, 29, 29]; %--- LeftUpPointingTriangle, Square,Square


%--- add left and right tiled bars of 45 degree and OtherAngle (20 degrees), Oct. 19, 2013
CubeLeft45Bar = zeros(Size, Size);
CubeLeft45Barsizebar = Cube45;
CubeLeft45Bar(SideGap+1:Size-SideGap, SideGap+1:Size-SideGap) = CubeLeft45Barsizebar;
CubeLeft45Bar = maxValue/2*ones(Size) - CubeLeft45Bar/2;
CubeRight45Bar = CubeLeft45Bar(:, Size:-1:1);
%
CubeLeftOtherAngleBar = zeros(Size, Size);
CubeLeftOtherAngleBarsizebar = CubeOtherAngle;
CubeLeftOtherAngleBar(SideGap+1:Size-SideGap, SideGap+1:Size-SideGap) = CubeLeftOtherAngleBarsizebar;
CubeLeftOtherAngleBar = maxValue/2*ones(Size) - CubeLeftOtherAngleBar/2;
CubeRightOtherAngleBar = CubeLeftOtherAngleBar(:, Size:-1:1);

AllCubes(34, :, :) = CubeLeft45Bar;
AllCubes(35, :, :) = CubeRight45Bar;
AllCubes(36, :, :) = CubeLeftOtherAngleBar;
AllCubes(37, :, :) = CubeRightOtherAngleBar;

%--- Condition Asimple, added Oct. 19, 2013
ItemTypes(49, :) = [34, 35, 35]; %--- left tilt among right tilt bars.
ItemTypes(50, :) = [35, 34, 34]; %--- right tilt among left tilt bars.

%--- Condition Bsimple, added Oct. 19, 2013
ItemTypes(51, :) = [36, 35, 35]; %--- left tilt, OtherAngle, among right tilt bars.
ItemTypes(52, :) = [37, 34, 34]; %--- right tilt, OtherAngle, among left tilt bars.

%--- Added Aug.2, 2017, more for the Bsimple condition
AllCubes(38, :, :) = CubeLeftOtherAngleBar';   %--- left tilt, closer to horizontal
AllCubes(39, :, :) = CubeRightOtherAngleBar';   %--- right tilt, closer to horizontal
ItemTypes(53, :) = [38, 35, 35]; %--- left tilt, OtherAngle closer to horizontal,  among right tilt bars.
ItemTypes(54, :) = [39, 34, 34]; %--- right tilt, OtherAngle closer to horizontal, among left tilt bars.

BlackOrWhiteOrBoth_AllCubes(1:39) = 1; %--- they are all black items on white background.

%%%%%%%%%%%%%%%% Create, and append to AllCubes, below Cubes for homo pairs of white dots, homo  pairs ofblack dots, hetero  pairs of dots on gray background, vertical or horizontally aligned.
Last_AllCubes_Index = 39; 
WhiteColor = 1;
BlackColor = 0;
GrayColor = (WhiteColor+BlackColor)/2;
Contrast = (WhiteColor-BlackColor)/4;
SD = Size/6.5; 
BlobSizeToSD = 1.4;
DotPair_Images = zeros(8, Size, Size);
for VerticalOrHorizontal = 1:2
for HomoOrHetero = 1:2
for BlackOrWhiteTop = 1:2
    Cube_DotPair = zeros(Size, Size);
    for c = 1:2
        xcenter = (1+Size)/2;
        ycenter = (1+Size)/4 + (c-1)*(1+Size)/2;
        Radius  =      BlobSizeToSD*SD;
        xlist = 1:Size;
        if c ==1
            ylist =1:floor(Size/2);
        else
            ylist =(ceil((1+Size)/2)):Size;
        end
        xxlist = xlist -xcenter;
        %Xdistance = double(ones(length(ylist), 1))*double(xxlist);
        Xdistance = repmat(double(xxlist), length(ylist), 1);
        
        yylist = ylist - ycenter;
        Ydistance = repmat(double(yylist)', 1, length(xxlist));
        Rdistance = sqrt(Xdistance.^2 + Ydistance.^2);
        Mask_Matrix  =double(Rdistance < Radius);
        ContrastScale = 2 * (BlackOrWhiteTop -1.5);
        if HomoOrHetero ==2 & c ==2
            ContrastScale = -1 *ContrastScale;
        end
        Cube_DotPair(ylist, xlist) =  ContrastScale*Contrast*exp(-Rdistance.^2/double(SD^2)/2).*Mask_Matrix +GrayColor*ones(length(ylist), length(xlist));
        
    end
    %--- normalize Cube_DotPair to range [0, 0,5], [0.5, 1], or [0,1] depending
    if HomoOrHetero ==1 & BlackOrWhiteTop ==1
        LowLuminance = 0; HighLuminance = 0.5; BackLuminance =  HighLuminance;
    elseif HomoOrHetero ==1 & BlackOrWhiteTop ==2
        LowLuminance = 0.5; HighLuminance = 1.0; BackLuminance =  LowLuminance;
	else
        LowLuminance = 0; HighLuminance = 1.0;   BackLuminance =0.5;
    end
    MinCube = min(min(Cube_DotPair));MaxCube = max(max(Cube_DotPair));
    Cube_DotPair  = (Cube_DotPair  - MinCube)/(MaxCube-MinCube)*(HighLuminance-LowLuminance) + LowLuminance;
    count = BlackOrWhiteTop + (HomoOrHetero-1)*2 + (VerticalOrHorizontal-1)*4;
    if VerticalOrHorizontal ==2
        Cube_DotPair = Cube_DotPair';
    end
    DotPair_Images(count, :, :) = Cube_DotPair;
    %--- append to AllCubes and BlackOrWhiteOrBoth_AllCubes;
    AllCubes(Last_AllCubes_Index+count, :, :)  = DotPair_Images(count, :, :);
    BlackOrWhiteOrBoth_AllCubes(Last_AllCubes_Index+count) = 3; %--- BlackAndWhite on Gray background
    %--- expand, rotate 45, and cut the middle
    BackCube = BackLuminance*ones(size(Cube_DotPair));
    BigCube = repmat(BackCube, 3, 3);
    Middle_list  =(Size+1):(2*Size);
    BigCube(Middle_list, Middle_list)  = Cube_DotPair;
    Rotated_BigCube = imrotate(BigCube,45,'bicubic','crop');
    Rotated_Cube = Rotated_BigCube(Middle_list, Middle_list);
    AllCubes(Last_AllCubes_Index+8+count, :, :) =  Rotated_Cube;
    BlackOrWhiteOrBoth_AllCubes(Last_AllCubes_Index+8+count) = 3; %--- BlackAndWhite on Gray background
end
end
end

%---- define ItemTypes(54+(1:16), :) as search of hetero pairs among homo pairs
Last_ItemType_Index = 54;
for SameOrNotOrientation_TargetAndDistractor = 1:2 %1 or 2 for same or different orientation between target and distractors
for DistractorVerticalOrHorizontal = 1:2
for Target_BlackOrWhiteTop = 1:2
	TargetVerticalOrHorizontal = DistractorVerticalOrHorizontal;
	if SameOrNotOrientation_TargetAndDistractor ==2
		TargetVerticalOrHorizontal = 3-DistractorVerticalOrHorizontal;
	end
	%	
	This_ItemType_Index  = Last_ItemType_Index + Target_BlackOrWhiteTop ...
						   + (DistractorVerticalOrHorizontal-1)*2 ...
				                   + (SameOrNotOrientation_TargetAndDistractor -1)*4;
	%count = BlackOrWhiteTop + (HomoOrHetero-1)*2 + (VerticalOrHorizontal-1)*4+Last_AllCubes_Index;
	Target_CubeIndex  = Target_BlackOrWhiteTop+ 2 + (TargetVerticalOrHorizontal -1)*4 + Last_AllCubes_Index; 	
	Distractor_CubeIndex1 = 1 + (DistractorVerticalOrHorizontal -1)*4 + Last_AllCubes_Index;
	Distractor_CubeIndex2 = 2 + (DistractorVerticalOrHorizontal -1)*4 + Last_AllCubes_Index;
	ItemTypes(This_ItemType_Index, :) = [Target_CubeIndex, Distractor_CubeIndex1, Distractor_CubeIndex2]; 
	%--- 45 degree rotated version
	ItemTypes(This_ItemType_Index+8, :) = [Target_CubeIndex+8, Distractor_CubeIndex1+8, Distractor_CubeIndex2+8]; 
end
end
end


%--- define ItemTypes(70+(1:16), :) as search of homo pairs among hetero pairs
Last_ItemType_Index = 70;
for SameOrNotOrientation_TargetAndDistractor = 1:2 %1 or 2 for same or different orientation between target and distractors
for DistractorVerticalOrHorizontal = 1:2
for Target_BlackOrWhiteTop = 1:2
        TargetVerticalOrHorizontal = DistractorVerticalOrHorizontal;
        if SameOrNotOrientation_TargetAndDistractor ==2
                TargetVerticalOrHorizontal = 3-DistractorVerticalOrHorizontal;
        end
        %
        This_ItemType_Index  = Last_ItemType_Index + Target_BlackOrWhiteTop ...
                                                   + (DistractorVerticalOrHorizontal-1)*2 ...
                                                   + (SameOrNotOrientation_TargetAndDistractor -1)*4;
	%count = BlackOrWhiteTop + (HomoOrHetero-1)*2 + (VerticalOrHorizontal-1)*4+Last_AllCubes_Index;
        Target_CubeIndex  = Target_BlackOrWhiteTop+ 0 + (TargetVerticalOrHorizontal -1)*4 + Last_AllCubes_Index;
        Distractor_CubeIndex1 = 1 + 2 +(DistractorVerticalOrHorizontal -1)*4 + Last_AllCubes_Index;
        Distractor_CubeIndex2 = 2 + 2 +(DistractorVerticalOrHorizontal -1)*4 + Last_AllCubes_Index;
        ItemTypes(This_ItemType_Index, :) = [Target_CubeIndex, Distractor_CubeIndex1, Distractor_CubeIndex2];
        %--- 45 degree rotated version
        ItemTypes(This_ItemType_Index+8, :) = [Target_CubeIndex+8, Distractor_CubeIndex1+8, Distractor_CubeIndex2+8];
end
end
end



