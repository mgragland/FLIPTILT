function MaskMatrix = Get_MaskMatrixFromStimulusInfo(StimulusInfo)


BackgroundLuminance = StimulusInfo.BackgroundLuminance;
HighLuminance = StimulusInfo.HighLuminance;
LowLuminance = StimulusInfo.LowLuminance;
xcenters_circles= StimulusInfo.xcenters_circles;
ycenters_circles= StimulusInfo.ycenters_circles;
CubeSize = StimulusInfo.CubeSize;
diameters_circles=CubeSize*StimulusInfo.diameters_circles;
BlackOrWhite_circles  =StimulusInfo.BlackOrWhite_circles;

NCircles  = length(xcenters_circles);
N=StimulusInfo.StimulusSquareSideLength;
MaskMatrix = BackgroundLuminance*ones(N, N);
x = 1:N; matrix_x = repmat(x, N, 1); 
matrix_y = matrix_x';


BlackOrWhite_LuminanceValues = [LowLuminance, HighLuminance];

for i = 1:NCircles
        x0 = xcenters_circles(i);
        y0 = ycenters_circles(i);
        r0 = diameters_circles(i)/2;
        r_matrix =  sqrt((matrix_x-x0).^2 + (matrix_y-y0).^2);
        r_list = find(abs(r_matrix-r0)< CubeSize/10);
        MaskMatrix(r_list) = BlackOrWhite_LuminanceValues(BlackOrWhite_circles(i));
end


%--- make the stimulus area within the circle
x = 1:N; matrix_x = repmat(x, N, 1); 
matrix_x = matrix_x - (1+N)/2;
matrix_y = matrix_x';
matrix_r = sqrt(matrix_x.^2 + matrix_y.^2);
r_thre = max(max(matrix_x));
temlist = (matrix_r > r_thre);
MaskMatrix =temlist.* (BackgroundLuminance*ones(N, N)) + (matrix_r<=r_thre).*MaskMatrix;