public class OpportunityTriggerHandler {
    public static void q12(List<Opportunity>newOppList,Map<Id,Opportunity>oldOppMap){
        List<Opportunity>updatedOpportunity=new List<Opportunity>();
        for(Opportunity opp:newOppList){
            if(opp.stageName!=oldOppMap.get(opp.id).stageName && opp.StageName=='Closed Won'){
                Opportunity oppTemp=new Opportunity(id=opp.Id,closeDate=System.today(),Type='New Customer');
                updatedOpportunity.add(oppTemp);
            }
            
        }
        
    }
    
    public static void q21(List<Opportunity>OppList){
        List<AggregateResult> aggList = [
            SELECT AccountId accid, COUNT(Id) total FROM Opportunity WHERE Account.Working_In__c INCLUDES ('Asia') AND StageName = 'Closed Won'
            GROUP BY AccountId];
        Map<Id, Integer> countmap = new Map<Id, Integer>();
        for(AggregateResult agg : aggList){
            countmap.put(
                (Id) agg.get('accid'),
                (Integer) agg.get('total')
            );
        }
        for(Opportunity opp : oppList){
            if(opp.StageName != 'Closed Won'){
                continue;
            }
            if(countmap.containsKey(opp.AccountId)){
                opp.addError('Cant do this Operation');
            }
            else{
                countmap.put(opp.AccountId, 1);
            }
        }
    }
    
    public static void q28(List<Opportunity>Opplist,Map<Id,Opportunity>oppMap){
        Set<Id>accId=new Set<Id>();
        Map<Id,Decimal> totalMap=new Map<Id,Decimal>();
        
        //Insert & Undelete
        if(OppList!=null && oppMap==null){
            for(Opportunity opp:Opplist){
                accId.add(opp.AccountId);
            }
            
        }
        //Update
        else if(OppList!=null && oppMap!=null){
            for(Opportunity opp:OppList){
                if(Opp.Amount !=oppMap.get(opp.Id).amount || opp.AccountId!=oppMap.get(opp.id).AccountID){
                    accId.add(opp.AccountId);
                    accId.add(oppMap.get(opp.id).accountID);
                }
            }
        }
        //Delete 
        else if(OppList==Null && OppMap!=Null){
            for(Opportunity opp:oppMap.Values()){
                accId.add(oppMap.get(opp.id).accountID);
                
            }
        }
        
        List<AggregateResult> agr=[Select Accountid,sum(amount) total from Opportunity where accountId in :accId group by Accountid  ];
        for(AggregateResult agg:agr){
            totalMap.put((Id)agg.get('Accountid'),(decimal)agg.get('total'));
        }
        List<Account>accList=[Select id,total_opportunity_amount__c from account where id in:accId];
        FOR(Account acc:accList){
            acc.total_opportunity_amount__c=totalMap.get(acc.id);
        }
        Update accList;
    }
    
    public static void q48(List<Opportunity>oppList,Map<id,Opportunity>oppMap){
        Set<Id>accIds=new Set<Id>();
        //List<Account>acc
        for(Opportunity opp:oppList){
            if(opp.for_q48__c!=oppMap.get(opp.id).for_q48__c){
                accIds.add(opp.Accountid);
            }
        }
        List<Account>updAccList=new List<Account>();
        for(Opportunity opp:oppList){
            Account acctemp=new Account();
            accTemp.id=opp.AccountId;
            accTemp.for_q48__c=opp.for_q48__c;
            updAccList.add(accTemp);
        }
        if(!updAccList.isEmpty()){
            update updAccList;
        }
    }
    public static void q89(List<Opportunity>oppList){
        for(Opportunity opp: oppList){
            if(opp.Amount<10000){
                opp.addError('Amount cant be less than 10000');
            }
        }
    }
    
    
    public static void q73(List<Opportunity>oppList){
        Set<id>accId=new Set<id>();
        for(Opportunity opp:oppList){
            accId.add(opp.AccountId);
        }
        Map<id,Decimal> accMap=new Map<id,Decimal>();
        for(AggregateResult agr:[Select AccountId,avg(amount) agg from opportunity where accountId in :accId group by accountId]){
            accMap.put((id)agr.get('accountId'),(Decimal)agr.get('agg'));
        }
        List<Account>accList=new List<Account>();
        for(Opportunity opp: oppList){
            Account acc=new Account(id=opp.AccountId,Average_Opp__c=accMap.get(opp.AccountId));
            accList.add(acc);
        }
        update accList;
    }
    
    public static void q71(List<opportunity>oppList){
        Set<id>updateaccid=New Set<id>();
        FOR(Opportunity opp:oppList){
            if(opp.Accountid!=NULL && opp.Amount>20000){
                updateaccid.add(opp.AccountId);
            }
        }
        List<Account>updatedaccList=New List<Account>();
        FOR(id accid:updateaccid){
            Account acc=New Account();
            acc.id=accid;
            acc.is_gold__c=True;
            updatedaccList.add(acc);
        }
        if(!updatedaccList.isEmpty()){
            update updatedaccList;
        }
    }
    
    
    public static void q66(LIst<opportunity>oppList){
        
    }
    
    public static void practice(List<Opportunity>oppList,Map<Id,Opportunity>oldMap){
        set<Id> accIds=new set<Id>();
        for(Opportunity opp:oppList){
            if(trigger.isInsert || Trigger.isUndelete ){
                if(opp.AccountId != null){
                    accIds.add(opp.AccountId);
                }
                
            }
            else if(Trigger.isUpdate && opp.AccountId != oldMap.get(opp.Id).accountId ){
                
                    accIds.add(opp.AccountId);
                    accIds.add(oldMap.get(opp.Id).accountId);
                //system.debug(oldMap.get(opp.Id).Name);
                
            }
            /*  else if(Trigger.isDelete){
accIds.add(oldMap.get(opp.Id).accountId);
} */
        }
        
        Map<id,Integer>countMap=new Map<Id,Integer>();
        for(AggregateResult agg:[select accountId acc,count(Id)cou from opportunity where accountId in :accIds group by accountId]){
            countMap.put((Id)agg.get('acc'),(Integer)agg.get('cou'));
        }
        List<Account> accList=new List<account>();
        for(opportunity opp:oppList){
            integer count=countmap.containsKey(opp.AccountId)?countmap.get(opp.AccountId):0;
            Account acc=new Account(id=opp.AccountId,Total_Opp_Count__c=count);
            accList.add(acc);
        }
        if(!accList.isEmpty()){
            update accList;
        }
        
    }
    
    public static void practice1(List<opportunity>oppList,Map<Id,Opportunity>oldMap){
       	Set<Id>accId=new set<Id>();
        for(Opportunity opp:oppList){
            if(opp.stageName=='Closed Won' && opp.stageName!=oldMap.get(opp.id).stageName && opp.accountId!=null){
                accId.add(opp.accountId);
            }
        }
        list <Account>accUp=new list<Account>();
        for(id idd:accId){
            Account acc=new Account(id=idd,type='Prospect');
            accUp.add(acc);
        }
        if(!accUp.isEmpty()){
            update accUp;
        }
    }
    
}