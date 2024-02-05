sap.ui.define(['sap/fe/test/ObjectPage'], function(ObjectPage) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ObjectPage(
        {
            appId: 'jpms.fiori.fiori',
            componentId: 'JobPostingObjectPage',
            contextPath: '/JobPosting'
        },
        CustomPageDefinitions
    );
});