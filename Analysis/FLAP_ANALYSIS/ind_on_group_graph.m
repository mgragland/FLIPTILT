%% Color Scheme for Individual Data
cmap = turbo(length(matrix_results));  % Or jet, lines, turbo, etc.
names=matrix_results(:,2)

if (Location == "Inferior") | (Location == "Superior")
    for j=1:length(matrix_results)
        individual_datas=matrix_results{j};
        ind_hm(j,1)=individual_datas(1,1);
        ind_hm(j,2)=individual_datas(2,1);
        ind_ht(j,1)=individual_datas(1,2);
        ind_ht(j,2)=individual_datas(2,2);
    end


    %% === Subplot 1: Homopair Trials ===
    figure
    subplot(1,2,1)
    b = bar(homotrials);
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
    hold on


    for i = 1:size(matrix_results,1)

        c = cmap(i,:);
        y = ind_hm(i,:);

        h(i) = plot([1 2], y, '-o', ...
            'Color', c, ...
            'MarkerFaceColor', c, ...
            'HandleVisibility','on');
        hold on

        scatter(1, y(1), 30, c, 'filled', 'MarkerFaceAlpha', 0.7, 'HandleVisibility','off')
        scatter(2, y(2), 30, c, 'filled', 'MarkerFaceAlpha', 0.7, 'HandleVisibility','off')
    end

    %% === Subplot 2: Heteropair Trials ===
    subplot(1,2,2)
    b = bar(heterotrials);
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
    hold on

    for i = 1:size(matrix_results,1)

        c = cmap(i,:);
        y = ind_ht(i,:);

        h(i)=plot([1 2], y, '-o', ...
            'Color', c, ...
            'MarkerFaceColor', c, ...
            'HandleVisibility','off');
        hold on

        scatter(1, y(1), 30, c, 'filled', 'MarkerFaceAlpha', 0.7, 'HandleVisibility','off')
        scatter(2, y(2), 30, c, 'filled', 'MarkerFaceAlpha', 0.7, 'HandleVisibility','off')
    end
    legend(h, string(names), 'Location','eastoutside');
    saveas(gcf, fullfile(Full_Save_Path, 'Ind_Group.jpg'));

end

