trigger CaseTrigger on Case (before insert,after insert,after update) {
    if(Trigger.isBefore && Trigger.isInsert){
       // CaseTriggerHandler.q1(Trigger.new);
    }
    if(Trigger.isAfter && Trigger.isInsert){
     //   CaseTriggerHandler.q4(Trigger.new);
     
    }
        if(Trigger.isAfter &&  Trigger.isUpdate){
          //     CaseTriggerHandler.q84(Trigger.new,Trigger.oldMap);
        }
    if(Trigger.isAfter && Trigger.isUndelete){
        
    }
    
}