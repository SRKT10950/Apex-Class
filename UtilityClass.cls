public with sharing class InitialData {
    @AuraEnabled
    Public static string pickList(){
        list<String> fieldNameLst=new list<string>{'country__c','state__c','city__c'};
              MainWrapper mainWrap=new MainWrapper();
                    mainWrap.countryList=new list<DropDownWrapper>();
                    mainWrap.stateList=new list<DropDownWrapper>();
                    mainWrap.cityList=new list<DropDownWrapper>();
                    for (String strField : fieldNameLst) {
                    Schema.SObjectType convertToObj = Schema.getGlobalDescribe().get('ObjectApiName');
                 Schema.DescribeSObjectResult res = convertToObj.getDescribe();
                 Schema.DescribeFieldResult fieldResult = res.fields.getMap().get(strField).getDescribe();
                List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
                for( Schema.PicklistEntry pickListVal : ple){
                    DropDownWrapper picklstWrap=new DropDownWrapper();
                    picklstWrap.label=pickListVal.label;
                    picklstWrap.value=pickListVal.value;
                    switch on strField {
                        when  'country__c'{
                            mainWrap.countryList.add(picklstWrap);
                        }
                        when 'state__c'{
                            mainWrap.stateList.add(picklstWrap);
                        }
                        when 'city__c'{
                             mainWrap.cityList.add(picklstWrap);
                        }
                    }
                }
        }
                return JSON.serialize(mainWrap);
    }
    
    @AuraEnabled
    public static String getPickListValue(string objectApiName, string fieldApiName){
                    MainWrapper mainWrap=new MainWrapper();
                    mainWrap.pickListData=new list<DropDownWrapper>();
                    Schema.SObjectType convertToObj = Schema.getGlobalDescribe().get(objectApiName);
                 Schema.DescribeSObjectResult res = convertToObj.getDescribe();
                 Schema.DescribeFieldResult fieldResult = res.fields.getMap().get(fieldApiName).getDescribe();
                List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
                for( Schema.PicklistEntry pickListVal : ple){
                    DropDownWrapper picklstWrap=new DropDownWrapper();
                    picklstWrap.label=pickListVal.label;
                    picklstWrap.value=pickListVal.value;
                    mainWrap.pickListData.add(picklstWrap);
                }
                return JSON.serialize(mainWrap);
    }
    
     public class MainWrapper{
        @AuraEnabled public list<DropdownWrapper> countryList;
        @AuraEnabled public list<DropdownWrapper> stateList;
        @AuraEnabled public list<DropdownWrapper> cityList;
        @AuraEnabled public list<DropdownWrapper> pickListData;
    }
        public class DropdownWrapper{
            @AuraEnabled public string label;
            @AuraEnabled public string value;
        }
 } 
