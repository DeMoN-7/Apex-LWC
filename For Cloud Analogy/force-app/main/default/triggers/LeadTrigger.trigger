trigger LeadTrigger on Lead (before insert, before update) {
    if(Trigger.isInsert && Trigger.isBefore){
        //LeadTriggerHandler.q1(Trigger.new);
        LeadTriggerHandler.q97(Trigger.new);
    }
    if((Trigger.isInsert || Trigger.isUpdate) && Trigger.isBefore){
       // LeadTriggerHandler.q20(Trigger.new,Trigger.oldMap);
    }
}