public class CaseTriggerHandler {
    public static void q1(List<Case>caseList){
        //Whenever a Case is created with Origin as 'Email', set its Status to 'New' and Priority to 'Medium'. 
        if(!caseList.isEmpty()){
            for(Case tempCase:caseList){
                if(tempCase.origin=='Email'){
                    tempCase.Status='New';
                    tempCase.Priority='Medium';
                }
            }
        }
    } 
    public static void q4(List<case>caseList){
        Map<Id,Account> accMap=new Map<Id,Account>();
        for(Case caseRecord:caseList){
            if(caseRecord.AccountId!=null){
                accMap.put(CaseRecord.AccountId,new Account(id=caseRecord.AccountId,Latest_Case_Number__c=caseRecord.CaseNumber));
            }
        }
        if(!accMap.isEmpty()){
            update accMap.values();
        }
    }
    public static void q84(List<case>caseList,Map<ID,Case>caseMap){
        Set<Id>accId=new set<Id>();
        for(Case con:caseList){
            if(con.Status!=caseMap.get(con.Id).Status){
                accId.add(con.AccountId);
            }
            
        }
        Map<Id,Integer>countMap=new Map<Id,Integer>();
        for(AggregateResult agr:[Select AccountID acc,count(id)total from case where accountId in:accId and Status='Closed' group by accountId]){
            countMap.put((ID)agr.get('acc'),(Integer)agr.get('total'));
        }
        List<Account> updatedacc=new List<Account>();
        for(id acId:accid){
            Account acc=new Account();
            acc.id=acId;
            if(countMap.get(acc.id)<2){
                acc.Rating='cold';
            }
            else if(countMap.get(acc.id)<5){
                acc.Rating='Warm';
            }      
            else{
                acc.Rating='Hot';
            }
            updatedacc.add(acc);
        }
        update updatedacc;
    }
    
    
    
}