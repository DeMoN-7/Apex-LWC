trigger OppLineItemTrigger on OpportunityLineItem (After insert) {
    if(Trigger.isInsert && Trigger.isAfter){
      //  OppLineItemHandler.q77(Trigger.new);
      //  OppLineItemHandler.q79(Trigger.new);
       // OppLineItemHandler.q88(Trigger.new);
       //OppLineItemHandler.q32(Trigger.new,Trigger.oldMap);
       OppLineItemHandler.pracTrigger(Trigger.new);
    }
}