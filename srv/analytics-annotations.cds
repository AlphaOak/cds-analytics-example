using {AnalyticsService} from './analytics-ui';


annotate AnalyticsService.Priorities with @(UI.PresentationVariant #vh_AnalyticsWos_priorityID: {
    $Type    : 'UI.PresentationVariantType',
    SortOrder: [{
        $Type     : 'Common.SortOrderType',
        Property  : code,
        Descending: false,
    }, ],
});

annotate AnalyticsService.Priorities with {
    ID @Common.Text: {
        $value                : description,
        ![@UI.TextArrangement]: #TextOnly,
    }
};


annotate AnalyticsService.ReportingTypes with @(UI.PresentationVariant #vh_AnalyticsWos_reportingTypeID: {
    $Type    : 'UI.PresentationVariantType',
    SortOrder: [{
        $Type     : 'Common.SortOrderType',
        Property  : code,
        Descending: false,
    }, ],
});

annotate AnalyticsService.ReportingTypes with {
    ID @Common.Text: {
        $value                : description,
        ![@UI.TextArrangement]: #TextOnly,
    }
};


annotate AnalyticsService.AnalyticsWos with @(

    Aggregation.ApplySupported             : {
        Transformations       : [
            'aggregate',
            'topcount',
            'bottomcount',
            'identity',
            'concat',
            'groupby',
            'filter',
            'search'
        ],

        GroupableProperties   : [
            ID,
            workorderId,
            description,
            priorityID,
            priorityCode,
            priorityDescription,
            reportingTypeID,
            reportingTypeCode,
            reportingTypeDescription,
            cost
        ],

        AggregatableProperties: [{
            $Type   : 'Aggregation.AggregatablePropertyType',
            Property: cost
        }]
    },

    Analytics.AggregatedProperty #totalCost: {
        $Type               : 'Analytics.AggregatedPropertyType',
        AggregatableProperty: cost,
        AggregationMethod   : 'sum',
        Name                : 'totalCost',
        ![@Common.Label]    : '{i18n>MeasureTotalCost}'
    },
);


annotate AnalyticsService.AnalyticsWos with @(
    UI.Chart              : {
        $Type            : 'UI.ChartDefinitionType',
        Title            : '{i18n>ChartTitle}',
        ChartType        : #Column,
        Dimensions       : [
            priorityDescription,
            reportingTypeDescription
        ],
        DynamicMeasures  : [ ![@Analytics.AggregatedProperty#totalCost] ],
        MeasureAttributes: [{
            $Type         : 'UI.ChartMeasureAttributeType',
            DynamicMeasure: ![@Analytics.AggregatedProperty#totalCost],
            Role          : #Axis1
        }]
    },
    UI.PresentationVariant: {
        $Type         : 'UI.PresentationVariantType',
        Visualizations: ['@UI.Chart', ],
    }
);

annotate AnalyticsService.AnalyticsWos with @(UI: {
    SelectionFields: [
        priorityID,
        reportingTypeID
    ],
    LineItem       : [
        {
            $Type: 'UI.DataField',
            Value: workorderId,
        },
        {
            $Type: 'UI.DataField',
            Value: description,
        },
        {
            $Type: 'UI.DataField',
            Value: cost
        }
    ],
});

annotate AnalyticsService.AnalyticsWos with {
    priorityID      @(
        Common.ValueList               : {
            $Type                       : 'Common.ValueListType',
            CollectionPath              : 'Priorities',
            Parameters                  : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: priorityID,
                    ValueListProperty: 'ID',
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'code',
                },
            ],
            PresentationVariantQualifier: 'vh_AnalyticsWos_priorityID',
        },
        Common.ValueListWithFixedValues: false
    );
    reportingTypeID @(
        Common.ValueList               : {
            $Type                       : 'Common.ValueListType',
            CollectionPath              : 'ReportingTypes',
            Parameters                  : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: reportingTypeID,
                    ValueListProperty: 'ID',
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'code',
                },
            ],
            PresentationVariantQualifier: 'vh_AnalyticsWos_reportingTypeID',
        },
        Common.ValueListWithFixedValues: false
    );
};
