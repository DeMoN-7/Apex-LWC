public class AccountTriggerHandler {
    //Whenever new Account record is created then needs to create associated Contact record automatically. 
    public static void 	q3(List<Account>AccountList){
        List<Contact>contactList=new List<Contact>();
        for(Account acc:AccountList){
            Contact con=new Contact(Lastname=acc.name,Accountid=acc.id);
            contactList.add(con);
        }
        Database.saveResult[] result=Database.insert(contactList,false);
        for(Database.saveResult res:result){
            if(res.isSuccess()){
                System.debug(res.getID()+' Contact Created Successfully');
            }
            else{
                for(Database.Error err:res.getErrors()){
                    System.debug(err.getMessage());
                }
            }
        }
    }
    
    public static void q5(List<Account>AccountList){
        //Write a trigger to create a related Contact of Account with same phone
        // as Account's phone if custom checkbox field on Account is checked. 
        List<Contact>contactList=new List<Contact>();
        for(Account acc:AccountList){
            if(acc.isChecked__C==True){
                Contact con=new Contact(Lastname=acc.name,Accountid=acc.id,phone=acc.Phone);
                contactList.add(con);
            }
        }
        
        Database.saveResult[] result=Database.insert(contactList,false);
        for(Database.saveResult res:result){
            if(res.isSuccess()){
                System.debug(res.getID()+' Contact Created Successfully');
            }
            else{
                for(Database.Error err:res.getErrors()){
                    System.debug(err.getMessage());
                }
            }
        }
    }
    
    public static void q6(List<Account>AccountList){
        
        List<Messaging.SingleEmailMessage> emails=new List<Messaging.SingleEmailMessage>();
        for(Account accOwner:AccountList){
            if(accOwner.Owner.Email != null){
                Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
                message.setToAddresses(new List<string>{accOwner.Owner.Email});
                message.setSubject('Account Deleted Successfully');
                message.setPlaintextBody(accOwner.name+' deleted successfully');
                emails.add(message);
            }
            
        }
        //Messaging.sendEmail(emails);
        
        
    }
    
    
    public static void q7(List<Account>accList){
        for(Account acc:accList){
            if(acc.Active__c=='Yes'){
                acc.addError('Cant delete active account');
            }
        }
    }
    
    public static void q8(List<Account>newAccList,Map<ID,Account>oldAccMap){
        Map<Id,String>changedAcc=new Map<Id,String>();
        for(Account acc:newAccList){
            if(acc.Phone!=oldAccMap.get(acc.id).phone){
                changedAcc.put(acc.id,acc.phone);
            }
        }
        List<contact>conList=new List<contact>();
        
        if(!changedAcc.isEmpty()){
            for(Contact con:[select phone,id,accountID from contact where Accountid in :changedAcc.keyset()]){
                con.phone=changedAcc.get(con.AccountId);
                conlist.add(con);
            }
        }
        if (!conList.isEmpty()) {
            Database.SaveResult[] res = Database.update(conList, false);
            
            for(Database.saveResult ress:res){
                if(ress.isSuccess()){
                    System.debug('Succes '+ress.getID());
                }
                else{
                    for(Database.Error err : ress.getErrors()) {
                        System.debug(err.getMessage());
                    }
                }
            }
        }
    }
    
    public static void q9(List<Account>newAccList){
        
        //,Map<Id,Account>oldAccMap
        
        
        /* for(Account acc:newAccList){
if(acc.Industry==null){
acc.addError('Industry Cant be empty');
}
else if(acc.Industry=='Media'){
acc.Rating='Hot';
}
else{
acc.Rating='Cold';
}
}
*/
        //While updating an Account, if the Phone field is being updated but no
        // value is provided (i.e., blank), show an error message. Otherwise, update
        //  the Phone field and set the Description field to 'Phone updated successfully'. 
        
        
        /*Map<Id,String>changedAcc=new Map<Id,String>();
for(Account acc:newAccList){
if(acc.Phone!=oldAccMap.get(acc.id).phone){
changedAcc.put(acc.id,acc.phone);
if(acc.Phone==null){
acc.addError('Phone number cant be blank');
}
else{
acc.Description='Phone updated successfully';
}
}
}  */
        
        //After creating an Account, automatically create a related Opportunity.
        List<opportunity>oppList=new List<opportunity>();
        for(Account acc:newAccList){
            if(acc.Active__c=='Yes'){
                Opportunity opp=new opportunity(name=acc.name,accountId=acc.Id,closeDate=System.today(),stageName='Prospecting');
                oppList.add(opp);
            }
            else{
                acc.addError('Active status is set to no, Opportunity will not be created');
            }
            
        }
        if(!oppList.isEmpty()){
            Database.saveResult[]res=Database.insert(oppList,false);
            
            for(Database.saveResult ress:res){
                if(ress.isSuccess()){
                    System.debug('Succes '+ress.getID());
                }
                else{
                    for(Database.Error err : ress.getErrors()) {
                        System.debug(err.getMessage());
                    }
                }
            }
            
            
            
        }
    }
    
    public static void q10(List<Account>newAccList){
        List<Contact>conList=new List<Contact>();
        for(Account acc:newAccList){
            Contact con=new Contact(lastName=acc.Name,phone=acc.Phone,accountId=acc.Id);
            conList.add(con);
        }
        if(!conList.isEmpty()){
            Database.saveResult[]res=Database.insert(conList,false);
            
            for(Database.saveResult ress:res){
                if(ress.isSuccess()){
                    System.debug('Succes '+ress.getID());
                }
                else{
                    for(Database.Error err : ress.getErrors()) {
                        System.debug(err.getMessage());
                    }
                }
            }   
        }
    }
    
    
    public static void q22(List<Account>newAccList,Map<Id,Account>oldAccMap){
        Set<Id>ownerIDs=new Set<Id>();
        for(Account acc:newAccList){
            ownerIDs.add(acc.OwnerId);
        }
        Map<Id,User>userMap=new Map<Id,User>([Select id,name from user where id in :ownerIDs]);
        for(Account acc:newAccList){
            if(Trigger.isInsert){
                acc.Sales_Rep__c=userMap.get(acc.OwnerId).Name;
            }
            else if(Trigger.isUpdate){
                if(acc.OwnerId!=oldAccMap.get(acc.Id).ownerId){
                    acc.Sales_Rep__c=userMap.get(acc.OwnerId).Name;
                }
            }
        }
    }
    
    
    public static void q24(List<Account>newAccList){
        Set<Id>accId=new Set<ID>();
        for(Account acc:newAccList){
            accId.add(acc.id);
        }
        List<Opportunity>oppList=[Select name,id,stageName,createdDate from opportunity where accountId in :accId];
        List<Opportunity>UpdatedOpp=new List<Opportunity>();
        for(Opportunity opp: oppList){
            if(opp.CreatedDate.date()==System.today() && opp.StageName!='Closed Won'){
                opp.StageName='Closed Lost';
                UpdatedOpp.add(opp);
            }
            
        }
        Update updatedOpp;
    }
    
    public static void q29(List <account> accList,Map<Id,Account> oldMap){
        Set<ID>accId=new Set<ID>();
        for(Account acc:accList){
            Account oldAcc = oldMap.get(acc.Id);
            if(acc.BillingStreet != oldAcc.BillingStreet ||
               acc.BillingCity != oldAcc.BillingCity ||
               acc.BillingState != oldAcc.BillingState ||
               acc.BillingPostalCode != oldAcc.BillingPostalCode ||
               acc.BillingCountry != oldAcc.BillingCountry){
                   accId.add(acc.id);
               }
        }
        List<Contact> conList=[Select id,MailingStreet, MailingCity, MailingState,
                               MailingPostalCode, MailingCountry,
                               Account.BillingStreet, Account.BillingCity,
                               Account.BillingState, Account.BillingPostalCode,
                               Account.BillingCountry from contact where AccountID in :accId];
        List<Contact>conListUpdated=new List<Contact>();
        for(Contact con: conList){
            con.MailingStreet=con.account.Billingstreet;
            con.MailingCountry=con.account.BillingCountry;
            con.MailingCity=con.account.BillingCity;
            con.MailingPostalCode=con.account.BillingPostalCode;
            conListUpdated.add(con);
        }
        update conListUpdated;
    }
    
    
    public static void q44(List<Account>newAccList,Map<Id,Account>oldAccMap){
        set<Id>accIds=new Set<Id>();
        for(Account acc:newAccList){
            if(acc.Close_All_Opportunities__c!=oldAccMap.get(acc.id).Close_All_Opportunities__c){
                if(acc.Close_All_Opportunities__c==True){
                    accIds.add(acc.id);
                }
            }
        }
        List<Opportunity>oppList=[Select id,probability from opportunity where accountId in :accIDs];
        for(Opportunity opp:oppList){
            if(opp.Probability>70){
                opp.StageName='Closed Won';
            }
        }
        Update OppList;
    }
    public static void q76(List<Account>accList){
        List<contact>conList=new List<Contact>();
        for(account acc:accList){
            Integer len=(Integer)acc.numberOfContacts__c;
            for(integer i=0;i<len;i++){
                Contact con=new Contact(accountId=acc.id,lastName='From q76');
                conList.add(con);
            }
        }
        insert conList;
    }
    public static void q96(List<Account>accList){
        Set<Id>accIds=new set<Id>();
        for(Account acc:accList){
            accIds.add(acc.id);
        }
        Set<id>oppIds=new set<id>();
        for(Opportunity opp:[Select AccountId from opportunity where accountId in :accIds and isClosed=False])
        {
            oppIds.add(opp.AccountId);
        }
        for(Account acc:accList){
            if(oppIds.contains(acc.id)){
                acc.addError('Cant Delete account with active opportunity');
            }
        }
    }
    
    public static void q70(List<Account>accList,Map<Id,Account>accMap){
        Set<Id> accids = new Set<Id>();
        for (Account acc : accList) {
            if(acc.Website!=accMap.get(acc.id).website){
                accids.add(acc.Id);  
            }
            
        } 
        Map<Id, List<Contact>> conMap = new Map<Id, List<Contact>>(); 
        List<Contact> toUpdate = new List<Contact>(); 
        Map<id,Account> accNewMap=New Map<id,Account>([SELECT id,Website FROM Account WHERE id IN :accids]); 
        for (Contact con : [ 
            SELECT Id, AccountId, Profile__c, FirstName,LastName 
            FROM Contact 
            WHERE AccountId IN :accids 
            
        ]) { 
            con.Profile__c = (accNewMap.get(con.AccountId).Website)+'/'+con.FirstName.substring(0,1)+con.LastName; 
            toUpdate.add(con); 
        }         if (!toUpdate.isEmpty()) { 
            update toUpdate; 
        } 
    }
    
    public static void q67(List<Account>accList){
        List<Contact>conList=[select id from Contact where accountId =:acclist];
        for(contact con:conList){
            con.AccountId=null;
        }
        update conList;
    }
    public static void q65(List<Account>accList){
        for(Account acc:accList){
            if(acc.LastModifiedDate >= System.now().addHours(-1)){
                acc.addError('Modified within hour');
            }
        }
    }
    
}