function createtable(homotrials, homotrials_error, heterotrials, heterotrials_error, Save_Files)

% Create Location to Save the Figures
Save_location = "/Users/madelineragland/Desktop/FLIPTILTDATA/Figures";
Full_Save_Path = fullfile(Save_location, Save_Files);

if ~exist(Full_Save_Path, 'dir')
    mkdir(Full_Save_Path);
end

% Create cell arrays of formatted strings for each pair
homo_str = arrayfun(@(m,s) sprintf('%.2f ± %.2f', m, s), homotrials, homotrials_error, 'UniformOutput', false);
hetero_str = arrayfun(@(m,s) sprintf('%.2f ± %.2f', m, s), heterotrials, heterotrials_error, 'UniformOutput', false);

% Combine into one cell array with columns: Homopair (Central, Peripheral), Heteropair (Central, Peripheral)
tableData = [homo_str, hetero_str];  % 1x4 cell array

% Create figure with specific size
fig = figure('Position', [100 100 700 100]);

% Create uitable
uit = uitable(fig, ...
    'Data', tableData, ...
    'ColumnName', {'Homopair Central', 'Homopair Peripheral', 'Heteropair Central', 'Heteropair Peripheral'}, ...
    'RowName', [], ...
    'Units', 'normalized', ...
    'Position', [0 0 1 1]);

% Capture the figure as an image (UI included!)
F = getframe(fig);
img = F.cdata;

filename = fullfile(Full_Save_Path, 'mean_std_table.jpg');
imwrite(img, filename);
end
