trigger AccountTrigger on Account (before insert,after Insert,before Delete,after Update,before update) {
    if(Trigger.isBefore && Trigger.isDelete){
       // AccountTriggerHandler.q67(Trigger.old);
    }
    if(Trigger.isAfter && Trigger.isUpdate){
       
    }
    if(Trigger.isAfter && Trigger.isUpdate){
         // AccountTriggerHandler.q24(Trigger.new);
        // AccountTriggerHandler.q29(Trigger.new,Trigger.oldMap);
       //  AccountTriggerHandler.q9(Trigger.new,Trigger.oldMap);
      //AccountTriggerHandler.q70(Trigger.new,Trigger.oldMap);
     // AccountTriggerHandler.q44(Trigger.new,Trigger.oldMap);
    }
    if(Trigger.isUpdate && Trigger.isBefore){
      //AccountTriggerHandler.q65(Trigger.new);
    }
    
    if(Trigger.isInsert && Trigger.isAfter){
       // AccountTriggerHandler.q76(Trigger.new);
       // AccountTriggerHandler.q10(Trigger.new);
        // AccountTriggerHandler.q3(Trigger.new);
       // AccountTriggerHandler.q5(Trigger.new);
       //AccountTriggerHandler.q9(Trigger.new);
    }
    if(Trigger.isDelete && Trigger.isBefore){
        //AccountTriggerHandler.q6(Trigger.old);
        //AccountTriggerHandler.q7(Trigger.old);
        //AccountTriggerHandler.q96(Trigger.old);
    }
    
    if(Trigger.isBefore &&(Trigger.isInsert || Trigger.isUpdate)){
      //  AccountTriggerHandler.q22(Trigger.new,Trigger.oldMap);
    }
    
    
    
    
   
    
}