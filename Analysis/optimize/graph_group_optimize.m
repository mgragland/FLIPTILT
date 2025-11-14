function [figure_individual, figure_group]=graph_group_optimize(matrix_results, Save_Files)
times={'80ms', '200ms', '1s'};
locations={'Central','Peripheral 5', 'Peripheral 8'}
timing=NaN(length(times), size(matrix_results,1));
numColors=size(matrix_results,2);
cmap = jet(numColors); % generate a jet colormap

for i=1:size(matrix_results,1)
    for ii=1:size(matrix_results,2)
        pt_data=matrix_results{i,ii};
        for j=1:length(locations)
            if ii==1
                timing_homotrials_fastest(j,i)=pt_data(1,j);
                timing_homotrials_fast(j,i)=pt_data(2,j);
                timing_homotrials_slow(j,i)=pt_data(3,j);

            elseif ii==2
                timing_heterotrials_fastest(j,i)=pt_data(1,j);
                timing_heterotrials_fast(j,i)=pt_data(2,j);
                timing_heterotrials_slow(j,i)=pt_data(3,j);

            end
        end
    end
end

%
mean_timing_homotrials_fastest=mean(timing_homotrials_fastest,2);
mean_timing_homotrials_fast=mean(timing_homotrials_fast,2);
mean_timing_homotrials_slow=mean(timing_homotrials_slow,2);

mean_timing_heterotrials_fastest=mean(timing_heterotrials_fastest,2);
mean_timing_heterotrials_fast=mean(timing_heterotrials_fast,2);
mean_timing_heterotrials_slow=mean(timing_heterotrials_slow,2);

% 
figure 
subplot(3,1,1)
x=1:length(locations);
bar1=bar(x, mean_timing_homotrials_fastest, 0.1);
hold on
xticks(x+0.1)
xticklabels(locations)
x_offset=x+0.2;
bar2=bar(x_offset, mean_timing_heterotrials_fastest, 0.1);
bar2.FaceColor = 'r'; % 'r' for red
yline(0.5, '--k', 'Chance', ...
      'LabelHorizontalAlignment','left', ...
      'LabelVerticalAlignment','bottom');
for i=1:length(timing_homotrials_fastest)
    for ii=1:size(timing_homotrials_fastest, 2)
        scatter(x(i), timing_homotrials_fastest(i, ii), 36, cmap(ii,:), 'filled');
    end
end

for i=1:length(timing_heterotrials_fastest)
    for ii=1:size(timing_heterotrials_fastest, 2)
        scatter(x_offset(i),timing_heterotrials_fastest(i,ii), 36, cmap(ii,:), 'filled');
    end
end
title('Stimulus Presentation Time 80ms')
legend({'Homotrials', 'Heterotrials'})
hold off 

subplot(3,1,2)
x=1:length(locations);
bar1=bar(x, mean_timing_homotrials_fast, 0.1);
hold on
xticks(x+0.1)
xticklabels(locations)
x_offset=x+0.2;
bar2=bar(x_offset, mean_timing_heterotrials_fast, 0.1);
bar2.FaceColor = 'r'; % 'r' for red
yline(0.5, '--k', 'Chance', ...
      'LabelHorizontalAlignment','left', ...
      'LabelVerticalAlignment','bottom');
for i=1:length(timing_homotrials_fast)
    for ii=1:size(timing_homotrials_fast, 2)
        scatter(x(i), timing_homotrials_fast(i, ii), 36, cmap(ii,:), 'filled');
    end
end

for i=1:length(timing_heterotrials_fast)
    for ii=1:size(timing_heterotrials_fast, 2)
        scatter(x_offset(i),timing_heterotrials_fast(i,ii), 36, cmap(ii,:), 'filled');
    end
end
title('Stimulus Presentation Time 200ms')
legend({'Homotrials', 'Heterotrials'})
hold off 

subplot(3,1,3)
x=1:length(locations);
bar1=bar(x, mean_timing_homotrials_slow, 0.1);
hold on
xticks(x+0.1)
xticklabels(locations)
x_offset=x+0.2;
bar2=bar(x_offset, mean_timing_heterotrials_slow, 0.1);
bar2.FaceColor = 'r'; % 'r' for red
yline(0.5, '--k', 'Chance', ...
      'LabelHorizontalAlignment','left', ...
      'LabelVerticalAlignment','bottom');
for i=1:length(timing_homotrials_slow)
    for ii=1:size(timing_homotrials_slow, 2)
        scatter(x(i), timing_homotrials_slow(i, ii), 36, cmap(ii,:), 'filled');
    end
end

for i=1:length(timing_heterotrials_slow)
    for ii=1:size(timing_heterotrials_slow, 2)
        scatter(x_offset(i),timing_heterotrials_slow(i,ii), 36, cmap(ii,:), 'filled');
    end
end
title('Stimulus Presentation Time 1000 ms')
legend({'Homotrials', 'Heterotrials'})
hold off