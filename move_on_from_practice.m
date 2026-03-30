InstructionTextSize =40;
Screen('TextSize', Window_ID, InstructionTextSize);
text=sprintf('Congrats! You got %d out of %d trials correct', correct, totalTrials);
DrawFormattedText(Window_ID, text, 0.1*Window_Width, 0.1*Window_Width, [0,0,0])
Screen('Flip', Window_ID);
Wait_For_RightArrowKey;


InstructionTextSize =40;
Screen('TextSize', Window_ID, InstructionTextSize);
DrawFormattedText(Window_ID, 'Great job! Do you have any questions before proceeding?', ...
    0.1*Window_Width, 0.1*Window_Width, [0,0,0])
Screen('Flip', Window_ID);
Wait_For_RightArrowKey
DrawFormattedText(Window_ID, 'We will now move on to the testing trials. Press the right button', ...
    0.1*Window_Width, 0.1*Window_Width, [0,0,0])
Screen('Flip', Window_ID);
Wait_For_RightArrowKey;