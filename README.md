# SAP CAP Node.js Analytics Example

The intent of this repository is to act as a simple example of how to turn a service into a service capable of supporting an analytical list page.

## Steps to reproduce
1. Initialize the CDS environment
    - `cds init`
2. Create the base project components
    1. The data model
        - [schema.cds](./db/schema.cds)
        ```cds
        namespace ao.samples;

        using {
            cuid,
            managed,
            Currency
        } from '@sap/cds/common';


        entity Priorities : cuid, managed {
            code        : String(10);
            description : localized String(100);
        }


        entity ReportingTypes : cuid, managed {
            code        : String(10);
            description : localized String(100);
        }


        entity Workorders : cuid, managed {
            workorderId   : String(10);
            description   : String(100);
            priority      : Association to one Priorities;
            reportingType : Association to one ReportingTypes;
            cost          : Decimal(15, 3);
            costCurrency  : Currency;
        }

        ```
    2. A super simple service starting point
        -  [analytics.cds](./srv/analytics.cds)
        ```cds
        using {ao.samples as aoschema} from '../db/schema';


        @path: 'ana'
        service AnalyticsService {

            entity Workorders     as projection on aoschema.Workorders;
            entity Priorities     as projection on aoschema.Priorities;
            entity ReportingTypes as projection on aoschema.ReportingTypes;

        }
    3. And to test the service parts some test data and a REST test.
        - [Test Data Directory](./test/data/)
        - [REST Test Environment](./test/http/analytics.http)
        ```http
        @server=http://localhost:4004
        @service=/odata/v4/ana


        ### Check if Workorders entity is accessible
        GET {{server}}{{service}}/Workorders?$expand=priority,reportingType,costCurrency


        ### Check if Priorities entity is accessible
        GET {{server}}{{service}}/Priorities?$expand=texts

        ### Check if Reportingtypes entity is accessible
        GET {{server}}{{service}}/ReportingTypes?$expand=texts
        ```
