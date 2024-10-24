sap.ui.define(['sap/fe/test/ListReport'], function(ListReport) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ListReport(
        {
            appId: 'ao.samples.ui.appsample',
            componentId: 'AnalyticsWosList',
            contextPath: '/AnalyticsWos'
        },
        CustomPageDefinitions
    );
});