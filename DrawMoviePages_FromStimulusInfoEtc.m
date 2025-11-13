function [Drawn, MoviePages] = DrawMoviePages_FromStimulusInfoEtc(StimulusInfo, ExperimentInfo)

    StimulusMatrix = Get_StimulusMatrixFromStimulusInfo(StimulusInfo, StimulusInfo.This_FrameInfo, ExperimentInfo.InputParameters.Cube_Images);
    MaskMatrix = Get_MaskMatrixFromStimulusInfo(StimulusInfo, StimulusInfo.This_MaskInfo);



centerx = ExperimentInfo.InputParameters.StimulusCenter.x_in_Pixel;
centery = ExperimentInfo.InputParameters.StimulusCenter.y_in_Pixel;

for ii = 1:N_images
         crsSetDrawPage(MoviePages(ii));
         crsDrawMatrixPalettised([centerx, centery], round(StimulusMatrices{ii})+1); 
end

if StimulusInfo.condition.AddMask ==1
    end
end

Drawn = 1;
