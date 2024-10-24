sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'ao/samples/ui/appsample/test/integration/FirstJourney',
		'ao/samples/ui/appsample/test/integration/pages/AnalyticsWosList',
		'ao/samples/ui/appsample/test/integration/pages/AnalyticsWosObjectPage'
    ],
    function(JourneyRunner, opaJourney, AnalyticsWosList, AnalyticsWosObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('ao/samples/ui/appsample') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheAnalyticsWosList: AnalyticsWosList,
					onTheAnalyticsWosObjectPage: AnalyticsWosObjectPage
                }
            },
            opaJourney.run
        );
    }
);