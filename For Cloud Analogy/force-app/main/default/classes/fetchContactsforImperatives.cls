public with sharing class fetchContactsforImperatives {
    public static list<Contact> fetchContactsforImperatives1(id acid) {
        return [select id,lastName from contact where accountId = :acid and account.type='Customer -  Direct' and account.active__c='yes'];
    }
}