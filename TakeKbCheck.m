keyIsDown =0;
while keyIsDown==0   %While waiting for button response.
    [keyIsDown,timeSecs,keyCode] = KbCheck;  %Check response
    pause(0.001);
    if strcmp('esc', KbName(keyCode)) ==1  % Escape key pressed
        EscapeKeyPressed =1; 
        break
    end
end
 
 