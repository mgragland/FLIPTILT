function [homotrials,homotrials_error,heterotrials,heterotrials_error]= group_average(matrix_results, Location, Save_Files)

if (Location == "Inferior") | (Location == "Superior")
    for iii=1:length(matrix_results)
        participant=matrix_results{iii,1};
        homotrials_group_central(iii)=participant(1,1);
        homotrials_group_peripheral(iii)=participant(2,1);
        heterotrials_group_central(iii)=participant(1,2);
        heterotrials_group_peripheral(iii)=participant(2,2);
    end

    mean_homotrials_central=mean(homotrials_group_central);
    mean_homotrials_peripheral=mean(homotrials_group_peripheral);
    mean_heterotrials_central=mean(heterotrials_group_central);
    mean_heterotrials_peripheral=mean(heterotrials_group_peripheral);

    homotrials=[mean_homotrials_central, mean_homotrials_peripheral];
    homotrials_error=[std(homotrials_group_central), std(homotrials_group_peripheral)];
    heterotrials=[mean_heterotrials_central,mean_heterotrials_peripheral];
    heterotrials_error=[std(heterotrials_group_central), std(heterotrials_group_peripheral)];
end
% Create Table with Accuracy and Standard Deviation
createtable(homotrials, homotrials_error, heterotrials, heterotrials_error, Save_Files)
end

