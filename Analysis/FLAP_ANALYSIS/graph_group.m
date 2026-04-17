function [figure_individual, figure_group]=graph_group(Location, matrix_results, Save_Files)

% Create Location to Save the Figures
Save_location = "C:\Users\raglandm\Desktop\ZP_COLLAB\Flip_Tilt\Figures";
Full_Save_Path = fullfile(Save_location, Save_Files);
if ~exist(Full_Save_Path, 'dir')
    mkdir(Full_Save_Path);
end

[homotrials,homotrials_error,heterotrials,heterotrials_error]= group_average(matrix_results, Location, Save_Files);

%% Individual
if (Location == "Inferior") | (Location == "Superior")
    count=0;
    for j=1:length(matrix_results)
        individual_data=matrix_results{j,1};
        ind_homotrials=[individual_data(1,1), individual_data(2,1)];
        ind_heterotrials=[individual_data(1,2), individual_data(2,2)];
        if j==1
            figure_individual=figure
            count = count + 1;
            subplot(length(matrix_results), 2, count)
            bar(ind_heterotrials)
            ylim([0,1])
            ylabel('Accuracy');
            title('Accuracy of Heteropair Trials')

            % Set X-Ticks manually
            ax = gca;
            ax.XTick = [1 2];      % assuming 2 bars
            ax.XTickLabel = [];    % remove default labels

            % Add custom multiline text labels
            y_offset = -0.05;  % adjust based on axis scale
            text(1, y_offset, {'Central'}, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top', 'Units', 'data')
            text(2, y_offset, {'Peripheral'; '(Inferior)'}, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top', 'Units', 'data')


            count=count+1;
            subplot(length(matrix_results), 2, count)
            bar(ind_heterotrials)
            ylim([0,1])
            ylabel('Accuracy');
            title('Accuracy of Heteropair Trials')

             % Set X-Ticks manually
            ax = gca;
            ax.XTick = [1 2];      % assuming 2 bars
            ax.XTickLabel = [];    % remove default labels

            % Add custom multiline text labels
            y_offset = -0.05;  % adjust based on axis scale
            text(1, y_offset, {'Central'}, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top', 'Units', 'data')
            text(2, y_offset, {'Peripheral'; '(Inferior)'}, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top', 'Units', 'data')
        else
            % Homopair Trials
            count=count+1;
            subplot(length(matrix_results), 2, count)
            bar(ind_homotrials)
            ylim([0,1])
            ylabel('Accuracy');
            title('Accuracy of Homopair Trials')

             % Set X-Ticks manually
            ax = gca;
            ax.XTick = [1 2];      % assuming 2 bars
            ax.XTickLabel = [];    % remove default labels

            % Add custom multiline text labels
            y_offset = -0.05;  % adjust based on axis scale
            text(1, y_offset, {'Central'}, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top', 'Units', 'data')
            text(2, y_offset, {'Peripheral'; '(Inferior)'}, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top', 'Units', 'data')

            % Heteropair Trials
            count=count+1;
            subplot(length(matrix_results), 2, count)
            bar(ind_heterotrials)
            ylim([0,1])
            ylabel('Accuracy');
            title('Accuracy of Heteropair Trials')

             % Set X-Ticks manually
            ax = gca;
            ax.XTick = [1 2];      % assuming 2 bars
            ax.XTickLabel = [];    % remove default labels

            % Add custom multiline text labels
            y_offset = -0.05;  % adjust based on axis scale
            text(1, y_offset, {'Central'}, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top', 'Units', 'data')
            text(2, y_offset, {'Peripheral'; '(Inferior)'}, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top', 'Units', 'data')
        end
    end
    saveas(gcf, fullfile(Full_Save_Path, 'Individual.jpg'));
end

%% GROUP
if (Location == "Inferior") | (Location == "Superior")
    figure_group=figure;
    subplot(1,2,1)
    b=bar(homotrials)
    ylim([0,1])
    ylabel('Accuracy');
    title('Group Average: Accuracy of Homopair Trials')
    % Set X-Ticks manually
    ax = gca;
    ax.XTick = [1 2];      % assuming 2 bars
    ax.XTickLabel = [];    % remove default labels
    % Add custom multiline text labels
    y_offset = -0.05;  % adjust based on axis scale
    text(1, y_offset, {'Central'}, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top', 'Units', 'data')
    text(2, y_offset, {'Peripheral'; '(Inferior)'}, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top', 'Units', 'data')

    hold on

    xtips = b.XEndPoints;
    ytips = b.YEndPoints;
    errorbar(xtips,ytips,heterotrials_error, '.r', 'MarkerSize',0.1)

    subplot(1,2,2)
    bb= bar(heterotrials)
    ylim([0,1])
    ylabel('Accuracy');
    title('Group Average: Accuracy of Heteropair Trials')
    % Set X-Ticks manually
    ax = gca;
    ax.XTick = [1 2];      % assuming 2 bars
    ax.XTickLabel = [];    % remove default labels

    % Add custom multiline text labels
    y_offset = -0.05;  % adjust based on axis scale
    text(1, y_offset, {'Central'}, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top', 'Units', 'data')
    text(2, y_offset, {'Peripheral'; '(Inferior)'}, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top', 'Units', 'data')
    hold on
    % Recent MATLAB Versions
    xtips = bb.XEndPoints;
    ytips = bb.YEndPoints;
    errorbar(xtips,ytips,heterotrials_error, '.r', 'MarkerSize',0.1)

    saveas(gcf, fullfile(Full_Save_Path, 'Group.jpg'));
end

%% Individual on Group 
ind_on_group_graph
end