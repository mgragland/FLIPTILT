function    EyeTracker_Info = SetUp_EyeTracker();
Screen('Preference', 'SkipSyncTests', 1);
ScreenNumber = max(Screen('Screens'));
addpath('FixationScripts')
eyetracking_turnon
EyeTracker_Info=[];