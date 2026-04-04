trigger OpportunityTrigger on Opportunity (before insert,before update,after insert, after update,after delete, after undelete) {
    if(Trigger.isAfter && Trigger.isUpdate){
      //  OpportunityTriggerHandler.q48(Trigger.new,Trigger.oldMap);
    }
    if(Trigger.isAfter ){
       // OpportunityTriggerHandler.q28(Trigger.New,Trigger.oldMap);
    }
    if(Trigger.isupdate && Trigger.isBefore){
      //  OpportunityTriggerHandler.q12(Trigger.new, Trigger.oldMap);
    }
    if(Trigger.isBefore &&(Trigger.isInsert || Trigger.isUpdate)){
       // OpportunityTriggerHandler.q21(Trigger.new);
    }
    if(Trigger.isAfter && Trigger.isInsert){
        //OpportunityTriggerHandler.q89(Trigger.new);
       // OpportunityTriggerHandler.q73(Trigger.new);
       //OpportunityTriggerHandler.q71(Trigger.new);
    }
    if(Trigger.isAfter &&(Trigger.isInsert || Trigger.isUpdate || Trigger.isDelete || Trigger.isUndelete)){
         if(Trigger.isDelete){
        OpportunityTriggerHandler.practice(Trigger.old, Trigger.oldMap);
    }
    else{
        OpportunityTriggerHandler.practice(Trigger.new, Trigger.oldMap);
    }	
    }
    if(Trigger.isAfter && Trigger.isUpdate){
        OpportunityTriggerHandler.practice1(Trigger.new, Trigger.oldMap);
    }    
    
}