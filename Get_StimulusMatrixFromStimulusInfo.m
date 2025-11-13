function [StimulusMatrix, RingMatrix] = Get_StimulusMatrixFromStimulusInfo(StimulusInfo, FrameInfo,  Cube_Images);


BackgroundLuminance = StimulusInfo.BackgroundLuminance;
HighLuminance = StimulusInfo.HighLuminance;
LowLuminance = StimulusInfo.LowLuminance;
NbX = StimulusInfo.NbX;
NbY = StimulusInfo.NbY;

% xcenters = FrameInfo.xcenters;
% ycenters = FrameInfo.ycenters;
%--- revised from the two lines above to the two lines below Feb. 10, 2025
x_UpperLeftCorners =  double(FrameInfo.x_UpperLeftCorners);
y_UpperLeftCorners =  double(FrameInfo.y_UpperLeftCorners);

N=StimulusInfo.StimulusSquareSideLength;

StimulusContent = FrameInfo.StimulusContent;

StimulusMatrix = BackgroundLuminance*ones(N, N);

Size = size(Cube_Images, 2);

for i = 1:NbX
    for j = 1:NbY
        ItemMatrix  = squeeze(Cube_Images(StimulusContent(j, i), :,  :));
        ItemMatrix = ItemMatrix*(HighLuminance-LowLuminance) + LowLuminance;
       
%       x1 = round(xcenters(j, i)  - ((Size+1)/2-1)); 
        x1 = x_UpperLeftCorners(j,i);  %--- revised from the line above on Feb. 10, 2025;
        x2  = x1+Size -1;
%         y1 = round(ycenters(j, i)  - ((Size+1)/2-1)); 
        y1 = y_UpperLeftCorners(j,i);  %--- revised from the line above on Feb. 10, 2025;
        y2  = y1+Size -1;
        
        
        StimulusMatrix(y1:y2, x1:x2) = ItemMatrix;
	%--- each ItemMatrix has minimum 0 and maximum 1, so this gives teach item 
	%--- with highest luminance at HighLuminance and lowest luminance at LowLuminance.
    end
end

%--- make the stimulus area within the circle
x = 1:N; matrix_x = repmat(x, N, 1); 
matrix_x = matrix_x - (1+N)/2;
matrix_y = matrix_x';
matrix_r = sqrt(matrix_x.^2 + matrix_y.^2);

Ring_Width = StimulusInfo.CubeSize*0.1;


r_thre = max(max(matrix_x))- Ring_Width;
temlist = (matrix_r > r_thre);

StimulusMatrix =temlist.* (BackgroundLuminance*ones(N, N)) + (matrix_r<=r_thre).*StimulusMatrix;

temlist2 = (matrix_r> r_thre & matrix_r <=r_thre + Ring_Width);

RingMatrix = BackgroundLuminance*ones(N, N);
RingMatrix = temlist2.* LowLuminance*ones(N, N) + (temlist2 ==0).*RingMatrix;

StimulusMatrix = temlist2.* LowLuminance*ones(N, N) + (temlist2 ==0).*StimulusMatrix;

