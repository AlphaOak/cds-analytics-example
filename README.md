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
3. Enablement of the service to work for Analytical consumption.
    1. !!! If you run the Fiori Elements Application Generator at this point in time you receive the following error message `The OData V4 service you have provided is not suitable for use in an Analytical List Page application. The service must contain aggregate based entity sets for this template.` !!!
    2. If you have configured enough annotation to get past the problem outlined in 1. but still have other annotations to specify, you might get the following error.
    ```
    TypeError: Cannot read properties of undefined (reading 'map')
        at Object._formatPropertyInfo (https://sapui5.hana.ondemand.com/1.129.2/resources/sap/fe/templates/library-preload.js:1564:12353)
        at Object.formatPropertyInfo (https://sapui5.hana.ondemand.com/1.129.2/resources/sap/fe/templates/library-preload.js:1564:12287)
        at a.e [as getTemplate] (https://sapui5.hana.ondemand.com/1.129.2/resources/sap/fe/templates/library-preload.js:1599:13369)
        at https://sapui5.hana.ondemand.com/1.129.2/resources/sap/fe/templates/library-preload.js:161:10025
        at i.renderAsXML (https://sapui5.hana.ondemand.com/1.129.2/resources/sap/fe/templates/library-preload.js:56:541)
        at D (https://sapui5.hana.ondemand.com/1.129.2/resources/sap/fe/templates/library-preload.js:161:10002)
    ```
    3. **IMPORTANT:** In this [page](https://sapui5.hana.ondemand.com/sdk/#/topic/653ed0f4f0d743dbb33ace4f68886c4e.html) a few important restrictions are mentioned. Namely 'Properties such as measures, dimensions, and text associations that come from associated entity sets are currently not supported.'. That means that we have to consolidate all infomration we want to use as measures or dimensions in a 'flat', new entity to use the functionality properly. 
    4. **IMPORTANT:** Insure that all your fields have a title annotation (and preferably an assigned type) see [analytics-ui.cds](./srv/analytics-ui.cds) 
    5. Create an [extension for the standard service](./srv/analytics-ui.cds) to add the new entity.
    6. Create the analytics annotations in yet another [file](./srv/analytics-annotations.cds).
    7. Run the Fiori App Generator
        1. Select the Fiori generator (if run from command line (yo))
        2. Chose the `Analytical List Page` template.
        3. `Use a Local CAP Project`
        4. Select our project `cds-analytics-example`
        5. The service `AnalyticsService` (should only be one available)
        6. Main Entity: `AnalyticsWos`
        7. Table type: `Analytical`
        8. Selection mode: `Auto`
        9. ModuleName: `appsample`
        10. Application title: `Example Analytics List Page`
        11. Application namespace: `ao.samples.ui`
        12. Description: `An AlphaOak sample app.`
        13. Minimum SAPUI Version: [At present the version I user is 1.129.2]
        14. Add Flp configuration: N
        15. Configure advanced options: N
        





## References

- Explanation of which measures to set how....
https://sapui5.hana.ondemand.com/sdk/docs/topics/7f844f1021cd4791b8f7408eac7c1cec.html

- Fiori Elements Analytical Table with CAP: Does it work with V2 and V4? https://community.sap.com/t5/technology-blogs-by-members/fiori-elements-analytical-table-with-cap-does-it-work-with-v2-and-v4/ba-p/13565008
- 