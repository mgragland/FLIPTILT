function graph_tilt_results(results,Individual_Group, Location)

if (Location == "Inferior") | (Location == "Superior")
    if Individual_Group== "Group"
        group_average=[];
    elseif Individual_Group== "Individual"
        homotrials=results(:,1);
        heterotrials=results(:,2);
        
        figure
        bar(homotrials)
        xticklabels(["Central", "Peripheral (Inferior)"]);
        ylabel('Accuracy');
        title('Accuracy of Homopair Trials')
        
        figure
        bar(heterotrials)
        xticklabels(["Central", "Peripheral (Inferior)"]);
        ylabel('Accuracy');
        title('Accuracy of Heteropair Trials')
    end
elseif (Location == "Left/Right")
    if Individual_Group== "Group"
        group_average=[];
    elseif Individual_Group== "Individual"
        homotrials=results(:,1);
        heterotrials=results(:,2);
        
        figure
        bar(homotrials)
        xticklabels(["Left", "Central", "Right"]);
        ylabel('Accuracy');
        title('Accuracy of Homopair Trials')
        
        figure
        bar(heterotrials)
        xticklabels(["Left", "Central", "Right"]);
        ylabel('Accuracy');
        title('Accuracy of Heteropair Trials')
        
    end
end
end
