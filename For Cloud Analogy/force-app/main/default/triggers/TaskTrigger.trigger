trigger TaskTrigger on Task (before insert,before delete) {
    if(Trigger.isDelete && Trigger.isBefore){
       // TaskTriggerHandler.q19(Trigger.old);
    }
}