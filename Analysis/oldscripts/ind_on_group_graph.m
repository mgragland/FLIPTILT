%% Color Scheme for Individual Data 
cmap = turbo(length(matrix_results));  % Or jet, lines, turbo, etc.


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

    for i = 1:numel(b)
        b(i).FaceAlpha = 0.1;          % 30% opacity
    end

    for k = 1:2  % for Central and Peripheral
        x = b(1).XEndPoints(k);
        y = ind_hm(:,k);
        scatter(x, y, 30, cmap, 'filled', 'MarkerFaceAlpha', 0.7); % black dots with transparency
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

    for i = 1:numel(b)
        b(i).FaceAlpha = 0.1;          % 30% opacity
    end

    for k = 1:2  % for Central and Peripheral
        x = b(1).XEndPoints(k);
        y = ind_ht(:,k);
        scatter(x, y, 30, cmap, 'filled', 'MarkerFaceAlpha', 0.7); % black dots with transparency
    end
    saveas(gcf, fullfile(Full_Save_Path, 'Ind_Group.jpg'));

end

if (Location == "Left/Right")
    for j=1:length(matrix_results)
        individual_datas=matrix_results{j};
        ind_hm(j,1)=individual_datas(1,1);
        ind_hm(j,2)=individual_datas(2,1);
        ind_hm(j,3)=individual_datas(3,1);
        ind_ht(j,1)=individual_datas(1,2);
        ind_ht(j,2)=individual_datas(2,2);
        ind_ht(j,3)=individual_datas(3,2);
    end

    %% === Subplot 1: Homopair Trials ===
    figure
    subplot(1,2,1)
    b = bar(homotrials);
    xticklabels(["Left", "Central", "Right"]);
    ylim([0,1])
    ylabel('Accuracy');
    title('Accuracy of Homopair Trials')
    hold on
    for i = 1:numel(b)
        b(i).FaceAlpha = 0.1;          % 30% opacity
    end


    for k = 1:2  % for Left, Central and Right
        x = b(1).XEndPoints(k);
        y = ind_hm(:,k);
        scatter(x, y, 30, cmap, 'filled', 'MarkerFaceAlpha', 0.7); % black dots with transparency
    end

    %% === Subplot 2: Heteropair Trials ===
    subplot(1,2,2)
    b = bar(heterotrials);
    xticklabels(["Left", "Central", "Right"]);
    ylim([0,1])
    ylabel('Accuracy');
    title('Accuracy of Heteropair Trials')
    hold on

    for i = 1:numel(b)
        b(i).FaceAlpha = 0.1;          % 30% opacity
    end

    for k = 1:3  % for Left, Central and Right
        x = b(1).XEndPoints(k);
        y = ind_ht(:,k);
        scatter(x, y, 30, cmap, 'filled', 'MarkerFaceAlpha', 0.7); % black dots with transparency
    end
    saveas(gcf, fullfile(Full_Save_Path, 'Ind_Group.jpg'));
end