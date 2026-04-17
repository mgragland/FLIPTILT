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
    end
    matrix_results{ii,1}=results;
    matrix_results{ii,2}=filename(1:6);
    clearvars -except ii files dataFolder matrix_results Fixation_Stimulus Individual_Group Location
end
