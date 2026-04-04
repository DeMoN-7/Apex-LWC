public with sharing class fContacts {
    @auraEnabled(cacheable=true)
    public static list<Contact> fContacts(id acid) {
        // return [select id,lastName from contact where accountId = :acid and account.type='Customer - Direct' and account.Active__c='Yes'];
        return [select id,lastName,email from contact where accountId = :acid ];
    }
}