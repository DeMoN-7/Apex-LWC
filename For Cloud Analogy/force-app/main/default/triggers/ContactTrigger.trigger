trigger ContactTrigger on Contact (after insert,after update,before insert,after undelete) {
    if(Trigger.isAfter && Trigger.isUpdate){
        
        //ContactTriggerHandler.q72(Trigger.new, Trigger.oldMap);
    }
    
    if(Trigger.isBefore && Trigger.isInsert){
       // ContactTriggerHandler.q85(trigger.new);
       //ContactTriggerHandler.q75(Trigger.new);
    }
    if(Trigger.isAfter && Trigger.isInsert){
        //ContactTriggerHandler.q23(Trigger.new);
        //ContactTriggerHandler.q35(Trigger.new);
        //ContactTriggerHandler.q87(Trigger.new);
        //ContactTriggerHandler.ff(Trigger.new);
    }
    
    if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)){
        ContactTriggerHandler.q69(Trigger.new,Trigger.oldMap);
     //   ContactTriggerHandler.q95(Trigger.new,Trigger.oldMap);
    }
    if(Trigger.isAfter && Trigger.isUndelete){
       // ContactTriggerHandler.q78(Trigger.new);
    }
    
    
}