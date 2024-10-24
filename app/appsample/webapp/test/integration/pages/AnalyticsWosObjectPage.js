sap.ui.define(['sap/fe/test/ObjectPage'], function(ObjectPage) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ObjectPage(
        {
            appId: 'ao.samples.ui.appsample',
            componentId: 'AnalyticsWosObjectPage',
            contextPath: '/AnalyticsWos'
        },
        CustomPageDefinitions
    );
});