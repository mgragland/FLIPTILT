
function  Do_A_Instruction_Page(InstructionInfo, Instruction, p)

Window_ID = InstructionInfo.DisplayInfo.Window_ID;
Window_Width = InstructionInfo.DisplayInfo.WindowWidthAndHeightInPixels.TotalScreenX;
Window_Height = InstructionInfo.DisplayInfo.WindowWidthAndHeightInPixels.TotalScreenY;
BackgroundLuminance= InstructionInfo.DisplayInfo.BackgroundLuminance;
TextFont_sizeXY = InstructionInfo.TextFont_sizeXY;
LowLuminance = InstructionInfo.DisplayInfo.LowLuminance;

TrialType = Get_TrialType(InstructionInfo, Instruction, p);
% TrialType= prob list


% Stimulus Information
StimulusInfo = Get_TrialStimulusReady(TrialType, InstructionInfo);

[StimulusMatrix, RingMatrix] = Get_StimulusMatrixFromStimulusInfo(StimulusInfo, ...
    StimulusInfo.This_FrameInfo, InstructionInfo.InputParameters.Cube_Images);

if p>=8
    MaskMatrix = Get_MaskMatrixFromStimulusInfo(StimulusInfo, StimulusInfo.This_MaskInfo);
end


%
FixationSize = InstructionInfo.FixationSize;
StimulusCenter = TrialType.StimulusCenter;
FixationCenter = TrialType.FixationCenter;

TotalScreenX =  InstructionInfo.DisplayInfo.WindowWidthAndHeightInPixels.TotalScreenX;
TotalScreenY =  InstructionInfo.DisplayInfo.WindowWidthAndHeightInPixels.TotalScreenY;


StimulusCenter.x_in_Pixel = StimulusCenter.x_in_Scale*TotalScreenX;
StimulusCenter.y_in_Pixel = StimulusCenter.y_in_Scale*TotalScreenY;
%
FixationCenter.x_in_Pixel = FixationCenter.x_in_Scale*TotalScreenX;
FixationCenter.y_in_Pixel = FixationCenter.y_in_Scale*TotalScreenY;

StimulusDuration = TrialType.PresentationDuration;
xCenter =  TotalScreenX/2 + StimulusCenter.x_in_Pixel;
yCenter =  TotalScreenY/1.5 + StimulusCenter.y_in_Pixel;

Fixation_xCenter =  TotalScreenX/2 + FixationCenter.x_in_Pixel;
Fixation_yCenter =  TotalScreenY/1.5 + FixationCenter.y_in_Pixel;
Fx = Fixation_xCenter;
Fy = Fixation_yCenter;
BlankScreen= InstructionInfo.DisplayPages.BlankScreen;
[imageHeight, imageWidth] = size(StimulusMatrix);
dstRect = [0 0 imageWidth imageHeight];
% Center that rectangle on the screen center
dstRect = CenterRectOnPointd(dstRect, xCenter, yCenter);


for i=1:length(Instruction.Instruction_TextInfo)
    if (8>p) && (p>4) 
        InstructionTextSize =40;
        Screen('TextSize', Window_ID, InstructionTextSize);
        DrawFormattedText(Window_ID, Instruction.Instruction_TextInfo(i).txt , Instruction.Instruction_TextInfo(i).xy(1)*Window_Width,  Instruction.Instruction_TextInfo(i).xy(2)*Window_Height, [0,0,0])
        texture = Screen('MakeTexture', Window_ID, RingMatrix);
        Screen('DrawTexture', Window_ID, texture, [], dstRect);
        InstructionTextSize =TextFont_sizeXY;
        Screen('TextSize', Window_ID, InstructionTextSize);
          DrawFormattedText(Window_ID, 'Press any button       for the next trial', ...
            Fixation_xCenter-150, Fixation_yCenter, [0,0,0]); %5DVA
%         DrawFormattedText(Window_ID, 'Press any button       for the next trial', ...
%             Fixation_xCenter-93, Fixation_yCenter, [0,0,0]) %5DVA
        Screen('FillOval', Window_ID, LowLuminance, ...
            [Fx-FixationSize  Fy-FixationSize  Fx+FixationSize  Fy+ FixationSize]);
        Screen('Flip', Window_ID);
        Wait_For_RightArrowKey
    elseif p==8
        if i==5
            InstructionTextSize =40;
            Screen('TextSize', Window_ID, InstructionTextSize);
            DrawFormattedText(Window_ID, Instruction.Instruction_TextInfo(i).txt , Instruction.Instruction_TextInfo(i).xy(1)*Window_Width,  Instruction.Instruction_TextInfo(i).xy(2)*Window_Height, [0,0,0])
            texture = Screen('MakeTexture', Window_ID, RingMatrix);
            Screen('DrawTexture', Window_ID, texture, [], dstRect);
            texture = Screen('MakeTexture', Window_ID, StimulusMatrix);
            Screen('DrawTexture', Window_ID, texture, [], dstRect);
            Screen('FillOval', Window_ID, LowLuminance, ...
                [Fx-FixationSize  Fy-FixationSize  Fx+FixationSize  Fy+ FixationSize]);
            Screen('Flip', Window_ID);
            Wait_For_RightArrowKey
        elseif i>=7
            InstructionTextSize =40;
            Screen('TextSize', Window_ID, InstructionTextSize);
            DrawFormattedText(Window_ID, Instruction.Instruction_TextInfo(i).txt , Instruction.Instruction_TextInfo(i).xy(1)*Window_Width,  Instruction.Instruction_TextInfo(i).xy(2)*Window_Height, [0,0,0])
            texture = Screen('MakeTexture', Window_ID, RingMatrix);
            Screen('DrawTexture', Window_ID, texture, [], dstRect);
            InstructionTextSize =TextFont_sizeXY;
            Screen('TextSize', Window_ID, InstructionTextSize);
            DrawFormattedText(Window_ID, 'Press any button       for the next trial', ...
                Fixation_xCenter-150, Fixation_yCenter, [0,0,0]) %5DVA
            Screen('FillOval', Window_ID, LowLuminance, ...
                [Fx-FixationSize  Fy-FixationSize  Fx+FixationSize  Fy+ FixationSize]);
            texture = Screen('MakeTexture', Window_ID, MaskMatrix);
            Screen('DrawTexture', Window_ID, texture, [], dstRect);
            Screen('Flip', Window_ID);
            Wait_For_RightArrowKey
        else
            InstructionTextSize =40;
            Screen('TextSize', Window_ID, InstructionTextSize);
            DrawFormattedText(Window_ID, Instruction.Instruction_TextInfo(i).txt , Instruction.Instruction_TextInfo(i).xy(1)*Window_Width,  Instruction.Instruction_TextInfo(i).xy(2)*Window_Height, [0,0,0])
            texture = Screen('MakeTexture', Window_ID, RingMatrix);
            Screen('DrawTexture', Window_ID, texture, [], dstRect);
            InstructionTextSize =TextFont_sizeXY;
            Screen('TextSize', Window_ID, InstructionTextSize);
            DrawFormattedText(Window_ID, 'Press any button       for the next trial', ...
                Fixation_xCenter-150, Fixation_yCenter, [0,0,0]); %5DVA
            %         DrawFormattedText(Window_ID, 'Press any button       for the next trial', ...
            %             Fixation_xCenter-93, Fixation_yCenter, [0,0,0]) %5DVA
            Screen('FillOval', Window_ID, LowLuminance, ...
                [Fx-FixationSize  Fy-FixationSize  Fx+FixationSize  Fy+ FixationSize]);
            Screen('Flip', Window_ID);
            Wait_For_RightArrowKey
        end
    elseif p==9
        if i<=4
            InstructionTextSize =40;
            Screen('TextSize', Window_ID, InstructionTextSize);
            DrawFormattedText(Window_ID, Instruction.Instruction_TextInfo(i).txt , Instruction.Instruction_TextInfo(i).xy(1)*Window_Width,  Instruction.Instruction_TextInfo(i).xy(2)*Window_Height, [0,0,0])
            texture = Screen('MakeTexture', Window_ID, RingMatrix);
            Screen('DrawTexture', Window_ID, texture, [], dstRect);
            InstructionTextSize =TextFont_sizeXY;
            Screen('TextSize', Window_ID, InstructionTextSize);
            DrawFormattedText(Window_ID, 'Press any button       for the next trial', ...
                Fixation_xCenter-150, Fixation_yCenter, [0,0,0]); %5DVA
            Screen('FillOval', Window_ID, LowLuminance, ...
                [Fx-FixationSize  Fy-FixationSize  Fx+FixationSize  Fy+ FixationSize]);
            Screen('Flip', Window_ID);
            Wait_For_RightArrowKey
        elseif i==5 | i==6
            InstructionTextSize =40;
            Screen('TextSize', Window_ID, InstructionTextSize);
            DrawFormattedText(Window_ID, Instruction.Instruction_TextInfo(i).txt , Instruction.Instruction_TextInfo(i).xy(1)*Window_Width,  Instruction.Instruction_TextInfo(i).xy(2)*Window_Height, [0,0,0])
            texture = Screen('MakeTexture', Window_ID, RingMatrix);
            Screen('DrawTexture', Window_ID, texture, [], dstRect);
            InstructionTextSize =TextFont_sizeXY;
            Screen('TextSize', Window_ID, InstructionTextSize);
            DrawFormattedText(Window_ID, 'Press any button       for the next trial', ...
                Fixation_xCenter-150, Fixation_yCenter, [0,0,0]); %5DVA
            Screen('FillOval', Window_ID, LowLuminance, ...
                [Fx-FixationSize  Fy-FixationSize  Fx+FixationSize  Fy+ FixationSize]);
            texture = Screen('MakeTexture', Window_ID, StimulusMatrix);
            Screen('DrawTexture', Window_ID, texture, [], dstRect);
            Screen('Flip', Window_ID);
            Wait_For_RightArrowKey
        else
            InstructionTextSize =40;
            Screen('TextSize', Window_ID, InstructionTextSize);
            DrawFormattedText(Window_ID, Instruction.Instruction_TextInfo(i).txt , Instruction.Instruction_TextInfo(i).xy(1)*Window_Width,  Instruction.Instruction_TextInfo(i).xy(2)*Window_Height, [0,0,0])
            texture = Screen('MakeTexture', Window_ID, RingMatrix);
            Screen('DrawTexture', Window_ID, texture, [], dstRect);
            InstructionTextSize =TextFont_sizeXY;
            Screen('TextSize', Window_ID, InstructionTextSize);
            DrawFormattedText(Window_ID, 'Press any button       for the next trial', ...
                Fixation_xCenter-150, Fixation_yCenter, [0,0,0]) %5DVA
            Screen('FillOval', Window_ID, LowLuminance, ...
                [Fx-FixationSize  Fy-FixationSize  Fx+FixationSize  Fy+ FixationSize]);
            texture = Screen('MakeTexture', Window_ID, MaskMatrix);
            Screen('DrawTexture', Window_ID, texture, [], dstRect);
            Screen('Flip', Window_ID);
            Wait_For_RightArrowKey
        end
    elseif p>9
        InstructionTextSize =40;
        Screen('TextSize', Window_ID, InstructionTextSize);
        DrawFormattedText(Window_ID, Instruction.Instruction_TextInfo(i).txt , Instruction.Instruction_TextInfo(i).xy(1)*Window_Width,  Instruction.Instruction_TextInfo(i).xy(2)*Window_Height, [0,0,0])
        Screen('Flip', Window_ID);
        Wait_For_RightArrowKey
        ResponseAndMiscInfo = Execute_Trial(StimulusMatrix, MaskMatrix, RingMatrix, TrialType, InstructionInfo);
    else
        InstructionTextSize =40;
        Screen('TextSize', Window_ID, InstructionTextSize);
        DrawFormattedText(Window_ID, Instruction.Instruction_TextInfo(i).txt , Instruction.Instruction_TextInfo(i).xy(1)*Window_Width,  Instruction.Instruction_TextInfo(i).xy(2)*Window_Height, [0,0,0])
        texture = Screen('MakeTexture', Window_ID, RingMatrix);
        Screen('DrawTexture', Window_ID, texture, [], dstRect);
        texture = Screen('MakeTexture', Window_ID, StimulusMatrix);
        Screen('DrawTexture', Window_ID, texture, [], dstRect);
        Screen('FillOval', Window_ID, LowLuminance, ...
            [Fx-FixationSize  Fy-FixationSize  Fx+FixationSize  Fy+ FixationSize]);
        Screen('Flip', Window_ID);
        Wait_For_RightArrowKey
    end
end

end






	





	
		
	
