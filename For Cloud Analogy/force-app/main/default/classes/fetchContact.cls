public with sharing class fetchContact {
    @auraEnabled(cacheable=true)
    public static list<contact> fetchContact1(Id accountIdd) {
        return ([select id,firstName,lastName,email from contact where accountId =:accountIdd]);
    }
}