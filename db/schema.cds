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
