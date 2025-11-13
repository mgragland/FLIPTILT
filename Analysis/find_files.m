function files=find_files(Path)

% Specify the directory containing your data
dataFolder = Path;

% Get a list of all files in the folder
files = dir(fullfile(dataFolder, '*.mat')); 
end
