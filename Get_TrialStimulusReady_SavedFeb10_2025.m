function StimulusInfo  = Get_TrialStimulusReady(condition, ExperimentInfo)

%----- Copy relevant variables from ExperimentInfo
NbX = ExperimentInfo.InputParameters.NbX;
NbY = ExperimentInfo.InputParameters.NbY;
Size = ExperimentInfo.InputParameters.Size;
ItemSize = ExperimentInfo.InputParameters.ItemSize;
StimulusSquareSideLength = ExperimentInfo.InputParameters.StimulusSquareSideLength;

prob_list = condition.prob_list;
%--- in case not normalized
prob_list = prob_list/sum(prob_list);
cum_list = cumsum(prob_list);
cum_minus_list = [0, cum_list(1:end-1)];

%--- get the center locations of the items
temlist_x =1:NbX;
temlist_x = (temlist_x - 0.5)/NbX*StimulusSquareSideLength;
mean_xcenters = ones(NbY, 1)*temlist_x;
temlist_y = 1:NbY;
temlist_y = (temlist_y - 0.5)/NbY*StimulusSquareSideLength;
mean_ycenters = temlist_y'*ones(1, NbX);

Max_Jitter_x  = ExperimentInfo.InputParameters.Max_JitterFactor_x *(ItemSize - Size); 
Max_Jitter_y  = ExperimentInfo.InputParameters.Max_JitterFactor_y *(ItemSize - Size); 


N_images = round(condition.PresentationDuration/condition.PresentationPeriod);
for ii=1:N_images
    %--- add jitter
    xcenters = mean_xcenters+ Max_Jitter_x* (rand(NbY, NbX) - 0.5* ones(NbY, NbX));
    ycenters = mean_ycenters+ Max_Jitter_y* (rand(NbY, NbX) - 0.5* ones(NbY, NbX));
    
    StimulusContent = zeros(NbY, NbX);
    random_number_forContent = rand(NbY, NbX);
    for i = 1:NbX
        for j = 1:NbY
            this_random_number= random_number_forContent(j, i);
            content_index = find(cum_list>=this_random_number & cum_minus_list < this_random_number);
            StimulusContent(j,i) = content_index;
        end
    end
    This_FrameInfo.xcenters = xcenters;
    This_FrameInfo.ycenters = ycenters;
    This_FrameInfo.StimulusContent = StimulusContent;
    FrameInfo{ii} = This_FrameInfo;
end

%---- record StimulusInfo.
StimulusInfo.BackgroundLuminance =  ExperimentInfo.DisplayInfo.BackgroundLuminance;
StimulusInfo.HighLuminance =  ExperimentInfo.DisplayInfo.HighLuminance;
StimulusInfo.LowLuminance =  ExperimentInfo.DisplayInfo.LowLuminance;
StimulusInfo.NbX = NbX;
StimulusInfo.NbY = NbY;

StimulusInfo.MaxJitter_x= Max_Jitter_x;
StimulusInfo.MaxJitter_y= Max_Jitter_y;

StimulusInfo.FrameInfo = FrameInfo;
                        
StimulusInfo.condition = condition;
StimulusInfo.StimulusSquareSideLength= StimulusSquareSideLength;
StimulusInfo.CubeSize = Size;

% %---- add circles
% NCircles = ExperimentInfo.InputParameters.NCircles;
% 
% Mininum_Circle_Diameter_to_Size=ExperimentInfo.InputParameters.Mininum_Circle_Diameter_to_Size;
% Maximum_Circle_Diameter_to_Size = ExperimentInfo.InputParameters.Maximum_Circle_Diameter_to_Size;
% xcenters_circles = rand(1, NCircles) *StimulusSquareSideLength;
% ycenters_circles = rand(1, NCircles) *StimulusSquareSideLength;
% diameters_circles = rand(1, NCircles)*(Maximum_Circle_Diameter_to_Size -  Mininum_Circle_Diameter_to_Size)  + Mininum_Circle_Diameter_to_Size;
% 
% BlackOrWhite_circles = (rand(1, NCircles)>0.5)+1;
% 
% 
% StimulusInfo.xcenters_circles  = xcenters_circles;
% StimulusInfo.ycenters_circles  = ycenters_circles;
% StimulusInfo.diameters_circles  =diameters_circles;
% StimulusInfo.BlackOrWhite_circles =BlackOrWhite_circles;


%--- Add equal sized dots
if StimulusInfo.condition.AddMask ==1
    for m= 1:StimulusInfo.condition.N_masks
        NDots= ExperimentInfo.InputParameters.NDots;
        Dot_Radius = round(Size * ExperimentInfo.InputParameters.Dot_Radius_To_Size);
        xcenters_dots = rand(1, NDots) *(StimulusSquareSideLength-2*Dot_Radius)+Dot_Radius+1;
        ycenters_dots = rand(1, NDots) *(StimulusSquareSideLength-2*Dot_Radius)+Dot_Radius+1;
        BlackOrWhite_dots = (rand(1, NDots)>0.5)+1;
        This_MaskInfo.xcenters_dots  = xcenters_dots;
        This_MaskInfo.ycenters_dots  = ycenters_dots;
        This_MaskInfo.BlackOrWhite_dots =BlackOrWhite_dots;
        This_MaskInfo.Dot_Radius = Dot_Radius;
        StimulusInfo.MaskInfo{m}=This_MaskInfo;
    end
end

                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            