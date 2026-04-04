public with sharing class deleteAccount {
    @AuraEnabled
    public static void deleteAccount1(List<Id> accountIds) {
        if (accountIds == null || accountIds.isEmpty()) {
            return;
        }
        
        delete [SELECT Id FROM Account WHERE Id IN :accountIds];
    }
}