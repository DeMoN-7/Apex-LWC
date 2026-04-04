public class ContactTriggerHandler {
    public static void q23(list<Contact>conList){
        List<Contact_Relationship__C>relList=new List<Contact_Relationship__C>();
        for(Contact con:conList){
            Contact_Relationship__C conRel=new Contact_Relationship__C(Name=con.Lastname,Contact__C=con.id);
            relList.add(conRel);
        }
        Database.saveResult[]res=Database.insert(relList);
    }
    public static void q35(list<Contact>conList){
        List<account>acc=new List<account>();
        
        for(Contact con:conList){
            if(con.AccountId==null){
                Account Tempacc=new Account(Name=con.LastName);
                acc.add(Tempacc);
            }
            
        }
        Insert acc;
    }
    
    
    
    
    public static void q95(List<Contact>conList, Map<id,Contact>conMap){
        Set<Id>accId=new set<Id>();
        for(Contact con:conList){
            
            if(con.accountId!=null){
                if(Trigger.isInsert){
                    accId.add(con.AccountId);
                }
                else if(Trigger.isUpdate){
                    if(con.Continent__c!=conMap.get(con.Id).Continent__C){
                        accId.add(con.AccountId);
                    }
                }
            }
            
        }
        Map<Id,Integer>countMap=new Map<Id,Integer>();
        for(AggregateResult agr:[Select AccountID acc,count(id)total from contact where accountId in:accId and Continent__C='Asia' group by accountId]){
            countMap.put((ID)agr.get('acc'),(Integer)agr.get('total'));
        }
        List<Account> updatedacc=new List<Account>();
        for(id acId:accid){
            Account acc=new Account();
            acc.id=acId;
            acc.Contact_Count_From_Asia_c__c=countMap.get(acc.id);
            updatedacc.add(acc);
        }
        update updatedacc;
    }
    
    public static void q87(List<Contact>conList){
        Set<Id>accId=new set<Id>();
        for(Contact con:conList){
            if(con.accountId!=null){
                accId.add(con.AccountId);   
            }
        }
        List<Account> updatedacc=new List<Account>();
        for(id acId:accid){
            Account acc=new Account();
            acc.id=acId;
            acc.description='From Contacts';
            updatedacc.add(acc);
        }
        update updatedacc;
    }
    public static void q85(List<contact>conList){
        for(contact con:conlist){
            if(con.Primary__c==false){
                con.addError('Cant create please check primary');
            }
        }
    }
    public static void q78(List<Contact>conlist){
        Account Acc=[Select id from account where name like 'ayush%' limit 1];
        List<contact>conList1=new list<Contact>();
        for(Contact con:conList){
            Contact contemp=new contact();
            contemp.id=con.id;
            contemp.AccountId=acc.id;
            conList1.add(contemp);
        }
        Update conList1;
    }
    
    public static void q75(List<contact>conList){
        Set<String> emails=New Set<String>();
        FOR(Contact con: conlist){
            if(con.Email!=NULL){
                emails.add(con.email);
            }
            
        }
        Map<id,String> emailMap=New Map<id,String>();
        FOR(Contact con:[Select email from Contact WHERE EMAIL IN :emails]){
            emailMap.put(con.id,con.Email);
        }
        Set<String> oldEmails = new Set<String>(emailMap.values());
        List<Contact> updatecon=New List<Contact>();
        FOR(Contact con: conList){
            if(oldEmails.contains(con.email)){
                Contact tempcon=New Contact(id=emailMap.get(con.id),FirstName='Dup', LastName='Entered');
                updatecon.add(tempcon);
                con.addError('Duplicate Email Found');
            }
            else{
                oldemails.add(con.email);
            }
        }
        if(!updatecon.isEmpty()){
            update updatecon;  
        }
        
    }   
    
    public static void q72(List<Contact>conList,Map<Id,Contact>conMap){
        Set<Id>accSet=new Set<Id>();
        for(Contact con:conlist){
            if(con.AccountId!=null){
                if(con.Dead__c!=conMap.get(con.id).Dead__c){
                    accSet.add(con.AccountId);
                }
            }
        }
        Map<Id,Integer>DeadCount=new Map<id,Integer>();
        Map<Id,Integer>Count=new Map<id,Integer>();
        for(AggregateResult agr:[Select accountId acId,count(id) cId,dead__c dc from Contact where accountId in:accSet group by accountId,dead__C]){
            if(agr.get('dc')==true){
                Deadcount.put((Id)agr.get('acid'),(integer)agr.get('cId'));
            }
            else{
                count.put((Id)agr.get('acid'),(integer)agr.get('cId'));
            }
            
        }
        List<Account>accListt=new list<account>();
        for(contact con:conList){
            if((Decimal)(deadCount.get(con.AccountId)/Count.get(con.AccountId))>0.7){
                Account acc=new Account(id=con.AccountId,Need_Intel__c=True);
                accListt.add(acc);
            }
        }
        update accListt;
        
    }
    
    
    
    
    
    
    public static void q69(List<Contact> newList,Map<Id, Contact> oldMap) { 
        
        Set<Id> accIds = new Set<Id>(); 
        for (Contact con : newList) { 
            if (con.AccountId != null) { 
                if (oldMap == null || con.AccountId != oldMap.get(con.Id).AccountId) {
                    accIds.add(con.AccountId); 
                } 
            } 
        } 
        if (accIds.isEmpty()) return; 
        Map<Id, Account> accMap = new Map<Id, Account>( 
            [SELECT Id, Type, OwnerId FROM Account WHERE Id IN :accIds] 
            
        ); 
        List<Case> caseList = new List<Case>(); 
        for (Contact con : newList) { 
            Account acc = accMap.get(con.AccountId); 
            if (acc.Type == 'Premium') { 
                Case c = new Case();
                c.AccountId = acc.Id; 
                c.ContactId=con.id; 
                c.OwnerId   = acc.OwnerId; 
                c.Origin   = 'Web'; 
                c.Description = con.FirstName + ' ' + con.LastName; 
                caseList.add(c); 
            }
        } 
        
        if (!caseList.isEmpty()) { 
            insert caseList; 
        } 
    }
    
    public static void ff(List<Contact> conList){
        List<Id>conId=new List<ID>();
        for(Contact con:conList){
            conId.add(con.id);
        }
        futureCon(conId);
    }
    @future 
    public static void futureCon(List<id>conId){
        List<Contact>con=new List<contact>();
        for(id idd:conId){
            Contact temp=new Contact(email='eda@gmail.com',id=idd);
            con.add(temp);
        }
        update con;
    }
    
}