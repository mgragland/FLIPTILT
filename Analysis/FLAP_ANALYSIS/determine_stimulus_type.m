function true_answer=determine_stimulus_type(trial)

Homo_Left = [0.5, 0.5,  0, 0,  0, 0, 0, 0];  %--- homo, left tilted
Homo_Right = [0, 0, 0, 0, 0.5, 0.5, 0, 0]; %--- homo, right tilted
Hetero_Left = [0, 0,  0.5, 0.5, 0, 0, 0, 0];  %--- hetero, left tilted
Hetero_Right = [0, 0,  0, 0, 0, 0, 0.5, 0.5];  %--- hetero, right tilted

if trial==Homo_Left 
    true_answer=1;
elseif trial==Homo_Right
    true_answer=2;
elseif trial==Hetero_Left
    true_answer=1;
elseif trial==Hetero_Right
    true_answer=2;
end



