if strcmp(ExperimentInfo.ResponseButtons.Type, 'Keyboard')
    keyIsDown =0;
    while keyIsDown==0   %While waiting for button response.
        [keyIsDown,timeSecs,keyCode] = KbCheck;  %Check response
        pause(0.001);
        if strcmp('esc', KbName(keyCode)) ==1  % Escape key pressed
            EscapeKeyPressed =1;
            break
        end
        if strcmp('space', KbName(keyCode)) ==1
            moveon=1;
        end
    end
end


if strcmp(ExperimentInfo.ResponseButtons.Type, 'ResponseBox')
    moveon=0;
    while moveon==0;
        Datapixx('Flush');
        Datapixx('RegWrRd');
        [keyValue, keyTime]= Datapixx('ReadDinLog');
        if keyValue ==65519
            keyname= 'white' ;
            moveon= 1
        end
    end
end

