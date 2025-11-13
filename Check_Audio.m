function Audio = Check_Audio;

fs = 5000; t = 0:0.00002:0.02;
LowToneSoundwave =  sin(2*pi*fs/2*t);
HighToneSoundwave = sin(2*pi*fs*2*t);
VolumnOK =0;
while VolumnOK ==0
    sound(LowToneSoundwave, fs); pause(0.2);   sound(HighToneSoundwave, fs);
    SoundVolumn_prompt = {'Enter 1 or 0 if the volumn of the low and high tune for feedback are ok or otherwise', 'Check audio volumn for feedback use'};
    SoundVolumn_prompt_title='Check audio speaker';
    num_lines =1;
    SoundVolumn_default_answer={'1', 'ok'};
    SoundVolumn_Info = inputdlg(SoundVolumn_prompt, SoundVolumn_prompt_title, num_lines, SoundVolumn_default_answer);
    VolumnOK = str2num(SoundVolumn_Info{1});
    CheckedOK  = SoundVolumn_Info{2};
end
Audio.VolumnOK = VolumnOK;
Audio.CheckedOK = CheckedOK;
%-----Audio
Audio.LowToneSoundwave = LowToneSoundwave;
Audio.HighToneSoundwave = HighToneSoundwave;
Audio.fs = fs;