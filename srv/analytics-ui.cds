using {AnalyticsService} from './analytics';

extend service AnalyticsService with {
    entity AnalyticsWos as
        select
            key ID                                                    : UUID                                        @title: '{i18n>InternalWorkordersId}',
                workorderId               as workorderId              : AnalyticsService.Workorders:workorderId     @title: '{i18n>WorkordersId}',
                description               as description              : AnalyticsService.Workorders:description     @title: '{i18n>WorkordersDescription}',
                priority.ID               as priorityID               : UUID                                        @title: '{i18n>InternalPrioritiesId}',
                priority.code             as priorityCode             : AnalyticsService.Priorities:code            @title: '{i18n>PrioritiesCode}',
                priority.description      as priorityDescription      : AnalyticsService.Priorities:description     @title: '{i18n>PrioritiesDescription}',
                reportingType.ID          as reportingTypeID          : UUID                                        @title: '{i18n>InternalReportingTypesId}',
                reportingType.code        as reportingTypeCode        : AnalyticsService.ReportingTypes:code        @title: '{i18n>ReportingTypesCode}',
                reportingType.description as reportingTypeDescription : AnalyticsService.ReportingTypes:description @title: '{i18n>ReportingTypesDescription}',
                cost                      as cost                     : AnalyticsService.Workorders:cost            @title: '{i18n>WorkordersCost}',
                costCurrency.code         as costCurrencyCode         : String(3)                                   @title: '{i18n>CurrenciesCode}'
        from AnalyticsService.Workorders as wo;

}
