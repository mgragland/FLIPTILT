function matrix_results=groupanalysis(Path, files, Fixation_Stimulus, Individual_Group, Location, Save_Files) 
dataFolder=Path;
matrix_results=cell(length(files),1);
for ii = 1:numel(files)
    % Get the file name
    filename = files(ii).name;
    % Construct the full file path
    filepath = fullfile(dataFolder, filename);
    %load the filename
    load(filepath)
    if Location=="Inferior"
        analysis_inferior_superior
    elseif Location == "Left/Right"
        analysis_left_right
    elseif Location=="Multiple"
        analysis_multiple_inferior_locations
    elseif Location=='Optimize'
        addpath('optimize')
        analysis_optimize
    end
    matrix_results{ii,1}=results_homotrials;
    matrix_results{ii,2}=results_heterotrials;
    clearvars -except ii files dataFolder matrix_results Fixation_Stimulus Individual_Group Location
end
