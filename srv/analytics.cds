using {ao.samples as aoschema} from '../db/schema';


@path: 'ana'
service AnalyticsService {

    entity Workorders     as projection on aoschema.Workorders;
    entity Priorities     as projection on aoschema.Priorities;
    entity ReportingTypes as projection on aoschema.ReportingTypes;

}
