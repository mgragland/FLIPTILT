Analysis_prompt={'Location', 'Individual/Group', 'Fixation/Stimulus Moves', 'Name for Saved Folder'}
Analysis_dialog_title='Give_Analysis_Information';
num_lines=1;
Analysis_default_answer={'Inferior', 'Individual', 'Fixation', 'Save'}
Analysis_info=inputdlg(Analysis_prompt,Analysis_dialog_title,num_lines,Analysis_default_answer);

Location=Analysis_info{1};
Individual_Group=Analysis_info{2};
Fixation_Stimulus=Analysis_info{3};
Save_Files=Analysis_info{4};

if Individual_Group=="Individual"
    if (Location == "Inferior")
        analysis_inferior_superior
    end
 
elseif Individual_Group=="Group"
    Path_prompt={'Path'}
    Path_dialog_title='Give_Path_Group';
    num_lines=1;
    Path_default_answer={'C:\Users\raglandm\Desktop\ZP_COLLAB\Flip_Tilt\raw'}
    Path_info=inputdlg(Path_prompt,Path_dialog_title,num_lines,Path_default_answer);
    Path=Path_info{1};
    files=find_files(Path) % loop through to find the files
    matrix_results=groupanalysis(Path, files,Fixation_Stimulus, Individual_Group, Location, Save_Files)
    [figure_individual, figure_group]=graph_group(Location, matrix_results, Save_Files)
end









