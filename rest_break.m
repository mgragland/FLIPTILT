InstructionTextSize =40;
Screen('TextSize', Window_ID, InstructionTextSize);
DrawFormattedText(Window_ID, 'Time for a Break. Please rest your eyes. \n \n Press the right button when you are ready to proceed', ...
    0.3*Window_Width, 0.3*Window_Height, [0,0,0])
Screen('Flip', Window_ID);
Wait_For_RightArrowKey_Break
    