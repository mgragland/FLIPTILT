%function [fixating x y area_eye evt ]=IsFixating(el,eye_used,fixr,rect,driftoffsetx,driftoffsety)
function [fixating, xeye_total, yeye_total, eyedist]=IsFixatingSquareNew_MGR(ExperimentInfo, Fx, Fy)

%reset Eyetracking Variables
resetgazevars
fixwindowPix_radius=100;
total_fixation_time=0.7;
IFI=ExperimentInfo.DisplayInfo.IFI;
xfix=Fx;
yfix=Fy;
neededfixcount_time=round(total_fixation_time/IFI); 

while fixation_complete==0
    checkescapekey
    framecount=framecount+1;
    
    % Get Eye-Tracking Information
    eyefixation;
    r_eyeloc= sqrt((xeye-xfix)^2 + (yeye-yfix)^2);
    
    if framecount>1
        if r_eyeloc<fixwindowPix_radius
            % if eyes are within fixation window; we count the frame
            fixating=fixating+1;
            count_fixation=count_fixation+1;
        else
            % if eyes are outside fixation window; reset fixating
            fixating=0;
            count_fixation=count_fixation+0;
        end
    else
        fixating=0;
        count_fixation=count_fixation+0;
    end
    %
    
    %% Frame Flip Time  
    if fixating>neededfixcount_time
        fixation_complete=100;
    else
        fixation_complete=0;
    end
    
    xeye_total(end+1)=xeye;
    yeye_total(end+1)=yeye;
    eyedist(end+1)=r_eyeloc;
end
end