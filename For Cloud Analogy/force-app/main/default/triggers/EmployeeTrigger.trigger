trigger EmployeeTrigger on Employee__c (before insert,before Delete,after Delete ) {
    if(Trigger.isBefore && Trigger.isDelete){
        EmployeeTriggerhandler.q30(Trigger.old);
    }
}