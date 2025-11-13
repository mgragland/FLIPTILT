function [Fixation_Scale, Stimulus_Scale]=locationandscale(Location,Fixation_or_Stimulus, Distance_from_Fixation, Window_Width_pixels, Window_Height_pixels)
% How Fixation Point is Calculated in the Flip-Tilt Task
% FixationCenter.x_in_Pixel = FixationCenter.x_in_Scale*TotalScreenX;
% FixationCenter.y_in_Pixel = FixationCenter.y_in_Scale*TotalScreenY;
% Fixation_xCenter =  TotalScreenX/2 + FixationCenter.x_in_Pixel;
% Fixation_yCenter =  TotalScreenY/2 + FixationCenter.y_in_Pixel;

if strcmp(Location, 'Inferior')
    if strcmp(Fixation_or_Stimulus, 'Fixation')
        Fixation_center_x_inferior= 0;
        Fixation_center_y_inferior= (-1* Distance_from_Fixation);

        Stimulus_Scale=[0,0];
        Fixation_Scale=[0,  (Fixation_center_y_inferior/Window_Height_pixels)]

    elseif strcmp(Fixation_or_Stimulus, 'Stimulus')
        Stimulus_center_x_inferior= 0;
        Stimulus_center_y_inferior= Distance_from_Fixation;

        Stimulus_Scale=[0, Stimulus_center_y_inferior/Window_Height_pixels];
        Fixation_Scale= [0,0];


    end

elseif strcmp(Location, 'Superior')
    if strcmp(Fixation_or_Stimulus, 'Fixation')
        Fixation_center_y_superior= Distance_from_Fixation;

        Stimulus_Scale=[0, 0];
        Fixation_Scale=[0, Fixation_center_y_superior/Window_Height_pixels]

    elseif strcmp(Fixation_or_Stimulus, 'Stimulus')
        Stimulus_center_y_superior= -1 * Distance_from_Fixation;

        Fixation_Scale=[0,0]
        Stimulus_Scale = [0,   Stimulus_center_y_superior/Window_Height_pixels]
    end

elseif strcmp(Location, 'Left')
    if strcmp(Fixation_or_Stimulus, 'Fixation')
        Fixation_center_x_left= Distance_from_Fixation;

        Stimulus_Scale=[0,0];
        Fixation_Scale=[Fixation_center_x_left/Window_Width_pixels, 0]

    elseif strcmp(Fixation_or_Stimulus, 'Stimulus')
        Stimulus_center_x_left= -1 * Distance_from_Fixation;
        Stimulus_center_y_left=Window_Height_pixels/2;

        Fixation_Scale=[0,0]
        Stimulus_Scale = [Stimulus_center_x_left/Window_Width_pixels, 0]
    end

elseif strcmp(Location, 'Right')
    if strcmp(Fixation_or_Stimulus, 'Fixation')
        Fixation_center_x_right= -1 * Distance_from_Fixation;

        Stimulus_Scale=[0,0];
        Fixation_Scale=[Fixation_center_x_right/Window_Width_pixels, 0]

    elseif strcmp(Fixation_or_Stimulus, 'Stimulus')
        Stimulus_center_x= Distance_from_Fixation;

        Fixation_Scale=[0,0]
        Stimulus_Scale = [Stimulus_center_x/Window_Width_pixels, 0]
    end
end