public without sharing class WebLeadCreation {
    @AuraEnabled
    Public static string pickList(){
        list<String> fieldNameLst=new list<string>{'Other_Countries_Name__c','Health_Issues__c','Auto_Immune_Disease__c'};
              MainWrapper mainWrap=new MainWrapper();
                    mainWrap.countryList=new list<DropDownWrapper>();
                    mainWrap.heathIssueList=new list<DropDownWrapper>();
                    mainWrap.autoImmune=new list<DropDownWrapper>();
                    for (String strField : fieldNameLst) {
                    Schema.SObjectType convertToObj = Schema.getGlobalDescribe().get('Screening_Questionnaires__c');
                 Schema.DescribeSObjectResult res = convertToObj.getDescribe();
                 Schema.DescribeFieldResult fieldResult = res.fields.getMap().get(strField).getDescribe();
                List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
                for( Schema.PicklistEntry pickListVal : ple){
                    DropDownWrapper picklstWrap=new DropDownWrapper();
                    picklstWrap.label=pickListVal.label;
                    picklstWrap.value=pickListVal.value;
                    switch on strField {
                        when  'Other_Countries_Name__c'{
                            mainWrap.countryList.add(picklstWrap);
                        }
                        when 'Health_Issues__c'{
                            mainWrap.heathIssueList.add(picklstWrap);
                        }
                        when 'Auto_Immune_Disease__c'{
                             mainWrap.autoImmune.add(picklstWrap);
                        }
                    }
                }
        }
                return JSON.serialize(mainWrap);
    }
 } 
