function Show_StimulusForDebugging_FromStimulusInfo(StimulusInfo);
    disp('StimulusInfo');
    disp(StimulusInfo);
    figure(1); clf;
    NbX = StimulusInfo.NbX;
    NbY = StimulusInfo.NbY;
    Window_Width = StimulusInfo.Window_Width;
    Window_Height = StimulusInfo.Window_Height;
    temlist_x =1:NbX;
    temlist_x = (temlist_x - 0.5)/NbX*Window_Width;
    xcenters_nojitter = ones(NbY, 1)*temlist_x;
    temlist_y = 1:NbY;
    temlist_y = (temlist_y - 0.5)/NbY*Window_Height;
    ycenters_nojitter = temlist_y'*ones(1, NbX);
               subplot(3, 2, 1); imagesc(StimulusInfo.xcenters-xcenters_nojitter); colormap(gray); axis image; title('horizontal jitters from xcenters'); colorbar;
               subplot(3, 2, 2); imagesc(StimulusInfo.ycenters-ycenters_nojitter); colormap(gray); axis image; title('vertical jitters from ycenters'); colorbar;
               subplot(3, 2, 3); imagesc(StimulusInfo.StimulusContent); colormap(gray); axis image; title('StimulusInfo.StimulusContent'); colorbar;
               subplot(3, 2, 4); imagesc(StimulusInfo.Target_Distractors_Matrix); colormap(gray); axis image; title('StimulusInfo.Target_Distractors_Matrix'); colorbar;
               subplot(3, 3, 7); imagesc(StimulusInfo.TargetCube); colormap(gray); axis image; 
               title(sprintf('StimulusInfo.TargetCube, TargetType  = %d',StimulusInfo.TargetType)); colorbar;
               subplot(3, 3, 8); imagesc(StimulusInfo.DistractorCube1); colormap(gray); axis image; 
                 title(sprintf('StimulusInfo.DistractorCube1, Distractor1 = %d',StimulusInfo.Distractor1)); colorbar;
           
               subplot(3, 3, 9); imagesc(StimulusInfo.DistractorCube2); colormap(gray); axis image; 
               title(sprintf('StimulusInfo.DistractorCube2, Distractor2 = %d',StimulusInfo.Distractor2)); colorbar;
               
    figure(2);  clf;
    imagesc(Get_StimulusMatrixFromStimulusInfo(StimulusInfo)); colormap(gray); axis image; colorbar;
    title_txt = sprintf('NbX = %d, NbY = %d, Target_i = %d, Target_j= %d, This_Target_LateralSide = %d',...
        StimulusInfo.NbX, ...
          StimulusInfo.NbY, ...
    StimulusInfo.Target_i, ...
    StimulusInfo.Target_j, ...
    StimulusInfo.This_Target_LateralSide);
    title(title_txt); 