function [ButtonPressed, Time, EyeData, trialdone]= checkanswer(ExperimentInfo)

if strcmp(ExperimentInfo.ResponseButtons.Type, 'Keyboard')
    TakeKbCheck;
    FlushEvents('keydown')
    ButtonPressed= KbName(keyCode);
    if ButtonPressed==ExperimentInfo.ResponseButtons.Buttons{1} | ButtonPressed==ExperimentInfo.ResponseButtons.Buttons{2}
        trialdone=1;
    else
        trialdone=0;
    end
    Time= timeSecs;
    response_recorded=1;
end


if strcmp(ExperimentInfo.ResponseButtons.Type, 'ResponseBox')
    keycode=0;
    while keycode==0;
        Datapixx('Flush');
        Datapixx('RegWrRd');
        [keyValue, keyTime]= Datapixx('ReadDinLog');
        if length(keyValue)>1
            if keyValue(end)==65534 || keyValue(end)==65531
                if keyValue==65534
                    keyname= 'red' ;
                    keycode=1;
                    pause(0.1)
                    trialdone=1;
                    
                elseif keyValue==65531
                    keyname= 'green';
                    keycode=1;
                    pause(0.1)
                    trialdone=1;
                else
                    trialdone=0
                    
                end
            end
        elseif  length(keyValue)==1
            if keyValue(end)==65534 || keyValue(end)==65531
                if keyValue==65534
                    keyname= 'red' ;
                    keycode=1;
                    pause(0.1)
                    trialdone=1;
                    
                elseif keyValue==65531
                    keyname= 'green';
                    keycode=1;
                    pause(0.1)
                    trialdone=1;
                else
                    trialdone=0
                    
                end
            end
        end
    end
    ButtonPressed= keyname;
    Time= keyTime; %datapixx internal clock
    response_recorded=1;
end

EyeData=[];

%% Stop Logging Eye Data 
if ExperimentInfo.Gaze_Contingent==1 && response_recorded==1;
    Datapixx('StopTPxSchedule');
    Datapixx('RegWrRdVideoSync');
    %% Output eyetracking data
    status= Datapixx('GetTPxStatus');
    toRead= status.newBufferFrames;  
    [bufferData, ~, ~]= Datapixx('ReadTPxData', toRead);
     EyeData = array2table(bufferData, 'VariableNames', {'TimeTag', 'LeftEyeX', 'LeftEyeY', 'LeftPupilDiameter', 'RightEyeX', 'RightEyeY', 'RightPupilDiameter',...
        'DigitalIn', 'LeftBlink', 'RightBlink', 'DigitalOut', 'LeftEyeFixationFlag', 'RightEyeFixationFlag', 'LeftEyeSaccadeFlag', 'RightEyeSaccadeFlag',...
        'MessageCode', 'LeftEyeRawX', 'LeftEyeRawY', 'RightEyeRawX', 'RightEyeRawY'});
else
    EyeData=[];
end

%% Clear Data 
clear keyTime keyValue response_recorded
Datapixx('Flush')
