public class LeadTriggerHandler {
    public static void q1(List<Lead>leadList){
        //Whenever Lead is created with LeadSource as Web then give rating as cold otherwise hot.
        for(Lead tempLead:leadList){
            if(tempLead.LeadSource=='Web'){
                tempLead.rating='Cold';
            }
            else{
                tempLead.rating='Hot';
            }
        }
    }
    
    //Write a trigger on lead to prevent duplicate records based on lead email,
    // if a record is already created with the same Email, Or record is Updated.
    //  The trigger should throw an error. 
    public static void q20(List<Lead>newLeadList,Map<Id,Lead>oldLeadMap){
        if(oldLeadMap==null){
            for(Lead led:newLeadList){
                List<Lead>tempList=[Select email from lead where email =:led.email];
                if(tempList!=null){
                    led.addError('Duplicate Email');
                }
            }
        }
        else{
            for(Lead led:newLeadList){
                if(led.Email!=oldLeadMap.get(led.id).email){
                    List<Lead>tempList=[Select email from lead where email =:led.email];
                    if(!tempList.isEmpty()){
                        led.addError('Duplicate Email');
                    }
                }
            }
        }
    }
    public static void q97(List<Lead>leadList){
        Set<String>leadNames=new Set<String>();
        Set<String>checkNames=new Set<String>();
        for(lead ld:leadList){
            leadNames.add(ld.Lastname);
        }
        List<Lead>fetchedname=[Select Lastname from lead where Lastname in :leadNames];
        for(lead ld:fetchedName){
            checkNames.add(ld.Lastname);
        }
        for(lead ld:leadList){
            if(checkNames.contains(ld.LastName)){
                ld.addError('Duplicate Name');
            }
            else{
                //to ensure same name is not added when bulk data is entered
                checkNames.add(ld.LastName);
            }
        }
    }
}









// Anurag's logic
/*
public class LeadTriggerHandler {
 public static void q20(List<Lead> newLeadList , Map<Id, Lead> oldLeadMap ){
       // store all the email in set
         
        Set<String> emails = new Set<String>();
        for(Lead l: newLeadList){
            if(l.Email != null){
            emails.add(l.Email);
            }
        }
        
        if(emails.isEmpty()) return;
        // fetch the existing email and store it in a set 
        
        Set<String> ExistingEmails = new Set<String>();
        
        for(Lead l: [Select Id, Email from Lead Where Email IN : emails]){
            ExistingEmails.add(l.Email);
        }
         Set<String> seenInBatch = new Set<String>();
        // in case of insert 
       
        if(newLeadList != null && oldLeadMap == null){
            for(Lead l: newLeadList){
                if(ExistingEmails.contains(l.Email) || (l.email!=Null ? !seenInBatch.add(l.Email):False)){
                    l.addError('Duplicate Email at Insert');
                }
            }
        }
        
        // in case of update
        if(newLeadList != null && oldLeadMap != null){
            for(Lead l: newLeadList){
                if(l.Email != oldLeadMap.get(l.Id).Email){
                    if(ExistingEmails.contains(l.Email) ||  (l.email!=Null ? !seenInBatch.add(l.Email):False)){
                    l.addError('Can not update Duplicate Email');
                   }
                }
            }
        }
        
    }
}

*/