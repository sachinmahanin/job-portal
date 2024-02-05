sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'jpms/fiori/fiori/test/integration/FirstJourney',
		'jpms/fiori/fiori/test/integration/pages/JobPostingList',
		'jpms/fiori/fiori/test/integration/pages/JobPostingObjectPage'
    ],
    function(JourneyRunner, opaJourney, JobPostingList, JobPostingObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('jpms/fiori/fiori') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheJobPostingList: JobPostingList,
					onTheJobPostingObjectPage: JobPostingObjectPage
                }
            },
            opaJourney.run
        );
    }
);