public with sharing class showAccDetails {
    @auraEnabled(cacheable=true)
    public static account showAccDetails(id accId) {
        return [select name,type,industry,phone from account where id=:accId limit 1];
    }
}