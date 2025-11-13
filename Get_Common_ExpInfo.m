function Common_ExpInfo = Get_Common_ExpInfo(ExperimentInfo)

	%--- get the common parts of the ExperimentInfo, so that different sessions can be compared to see if things are the same

	ExperimentInfo.fn_out = '';
        ExperimentInfo.clocktime = [];
        ExperimentInfo.day = '';
        ExperimentInfo.SubjectInfo = [];
        ExperimentInfo.InputParameters.Conditions = [];
        ExperimentInfo.InputParameters.NTrials_EachCondition = [];
        ExperimentInfo.InputParameters.NBreaks = 0;
        ExperimentInfo.InputParameters.DemoOrPracticeOrTest = 0;
	ExperimentInfo.SubjectReport='';
	ExperimentInfo.ExperimentalObservations ='';

Common_ExpInfo = ExperimentInfo;
