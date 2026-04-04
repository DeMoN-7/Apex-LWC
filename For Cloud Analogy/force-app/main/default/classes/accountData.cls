public with sharing class accountData {
    @auraEnabled(cacheable=true)
    public static list<account> accountData1() {
            return [select id,name,rating from account ];
    }
}