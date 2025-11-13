function MaskMatrix = Get_MaskMatrixFromStimulusInfo(StimulusInfo, MaskInfo)


BackgroundLuminance = StimulusInfo.BackgroundLuminance;
HighLuminance = StimulusInfo.HighLuminance;
LowLuminance = StimulusInfo.LowLuminance;

% xcenters_dots= MaskInfo.xcenters_dots;
% ycenters_dots= MaskInfo.ycenters_dots;
x_UpperLeftCorners_dots= double(MaskInfo.x_UpperLeftCorners_dots);
y_UpperLeftCorners_dots= double(MaskInfo.y_UpperLeftCorners_dots);

Dot_Radius = MaskInfo.Dot_Radius;
% BlackOrWhite_dots  =MaskInfo.BlackOrWhite_dots;  %--- revised Feb. 10, 2025 to the line below
BlackOrWhite_dots  =double(MaskInfo.BlackOrWhite_dots);

% NDots  = length(xcenters_dots);  %-- revised to the line below Feb. 10, 2025
NDots  = length(x_UpperLeftCorners_dots); 
N=StimulusInfo.StimulusSquareSideLength;

MaskMatrix = BackgroundLuminance*ones(N, N);
BlackOrWhite_LuminanceValues = [LowLuminance, HighLuminance];

for i = 1:NDots
%         x0 = xcenters_dots(i);
%         y0 = ycenters_dots(i);
%         x1 = round(x0-Dot_Radius);
%         x2 = x1 + 2*Dot_Radius -1;
%         y1 = round(y0-Dot_Radius);
%         y2 = y1 + 2*Dot_Radius -1;
%--- the above 6 lines are modified to the four lines below
         x1 = x_UpperLeftCorners_dots(i);
         x2 = x1 + 2*Dot_Radius -1;
         y1 = y_UpperLeftCorners_dots(i);
         y2 = y1 + 2*Dot_Radius -1;

        MaskMatrix(y1:y2, x1:x2)= BlackOrWhite_LuminanceValues(BlackOrWhite_dots(i))*ones(2*Dot_Radius, 2*Dot_Radius);
end


%--- make the stimulus area within the circle
x = 1:N; matrix_x = repmat(x, N, 1); 
matrix_x = matrix_x - (1+N)/2;
matrix_y = matrix_x';
matrix_r = sqrt(matrix_x.^2 + matrix_y.^2);
r_thre = max(max(matrix_x));
temlist = (matrix_r > r_thre);
MaskMatrix =temlist.* (BackgroundLuminance*ones(N, N)) + (matrix_r<=r_thre).*MaskMatrix;