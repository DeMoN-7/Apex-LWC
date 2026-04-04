public class OppLineItemHandler {
    public static void q88(List<OpportunityLineItem>oppLineList){
        Set<Id>opplineIds=new Set<Id>();
        Set<Id>accIds=new set<Id>(); //to store all the account ids
        //stored all opportunity related to inserted oli
        for(OpportunityLineItem oli:oppLineList){
            opplineIds.add(oli.OpportunityId);
        }
        //fetched all opportunity with count of oli items
        Map<Id,Integer>olicount=new Map<ID,Integer>();
        for(AggregateResult agr: [Select OpportunityId opId,count(Id) total from OpportunityLineItem where opportunityId in :oppLineIds group by OpportunityId]){
            olicount.put((Id)agr.get('opId'),(Integer)agr.get('total'));
        }
        
        //fetching all account related to that opportunity
        Map<Id,Id> oppAccId=new Map<Id,Id>();
        for(Opportunity oop:[Select id ,AccountId  from opportunity where id in :opplineIds]){
            oppAccID.put(oop.id,oop.accountId);
        }
        Map<Id,Integer>accCount=new Map<id,Integer>();
        // main logic for assigning count
        for(Id oppId: oppAccId.keyset()){
            Id accId=oppAccId.get(oppId);
            if(accId != null){
                System.debug(olicount.get(oppID));
                accCount.put(accId,accCount.containsKey(accId)?accCount.get(accId)+oliCount.get(oppid):oliCount.get(oppId));
            }
        }
        List<Account> UpdatedAcc=New List<Account>();
        For(id temp:accCount.keySet()){
            if(accCount.get(temp)>5){
                UpdatedAcc.add(New Account(id=temp,Total_opp_count__C=accCount.get(temp)));
            }
        }
        update UpdatedAcc;
    }
    public static void q79(List<opportunityLineItem>oppLineList){
        Set<Id> oppIds = new Set<Id>();
        Set<Id> accIds = new Set<Id>();
        
        // Step 1: Get Opportunity Ids from OLI
        for(OpportunityLineItem oli : oppLineList){
            if(oli.OpportunityId != null){
                oppIds.add(oli.OpportunityId);
            }
        }
        
        // Step 2: Get Account Ids from Opportunities
        for(Opportunity opp : [
            SELECT Id, AccountId
            FROM Opportunity
            WHERE Id IN :oppIds
        ]){
            if(opp.AccountId != null){
                accIds.add(opp.AccountId);
            }
        }
        
        // Step 3: Count Opportunities per Account
        Map<Id, Integer> accOppCount = new Map<Id, Integer>();
        
        for(AggregateResult ar : [
            SELECT AccountId accId, COUNT(Id) total
            FROM Opportunity
            WHERE AccountId IN :accIds
            GROUP BY AccountId
        ]){
            accOppCount.put((Id) ar.get('accId'), (Integer) ar.get('total'));
        }
        
        // Step 4: Update Accounts
        List<Account> accToUpdate = new List<Account>();
        
        for(Id accId : accIds){
            Integer total = accOppCount.containsKey(accId) ? accOppCount.get(accId) : 0;
            
            accToUpdate.add(new Account(
                Id = accId,
                Total_opp_count__c = total
            ));
        }
        
        if(!accToUpdate.isEmpty()){
            update accToUpdate;
        }
    }
    public static void q77(List<opportunityLineItem>oliList){
        Set<Id> oppIds = new Set<Id>();
        for (OpportunityLineItem oli : oliList) {
            if (oli.OpportunityId != null) {
                oppIds.add(oli.OpportunityId);
            }
        }
        
        Map<Id, Id> oppToAcc = new Map<Id, Id>();
        for (Opportunity opp : [
            SELECT Id, AccountId
            FROM Opportunity
            WHERE Id IN :oppIds
            AND AccountId != null
        ]) {
            oppToAcc.put(opp.Id, opp.AccountId);
        }
        
        Set<Id> accIds = new Set<Id>(oppToAcc.values());
        
        Map<Id, Integer> accProductCount = new Map<Id, Integer>();
        for (AggregateResult agg : [
            SELECT Opportunity.AccountId accId, COUNT(Id) total
            FROM OpportunityLineItem
            WHERE Opportunity.AccountId IN :accIds
            GROUP BY Opportunity.AccountId
        ]) {
            accProductCount.put(
                (Id) agg.get('accId'),
                (Integer) agg.get('total')
            );
        }
        
        List<Account> updatedAcc = new List<Account>();
        for (Id accId : accProductCount.keySet()) {
            updatedAcc.add(
                new Account(
                    Id = accId,
                    Total_Product__c = accProductCount.get(accId)
                )
            );
        }
        
        if (!updatedAcc.isEmpty()) {
            update updatedAcc;
        }
    }
    /*  public static void q32(List<opportunityLineItem>oliList,Map<Id,opportunityLineItem>oliMap){
Set<id>oliId=new set<Id>();
for(opportunityLineItem opp:oliList){
if(opp.quantity!=oliMap.get(opp.Id).quantity){
oliId.add(opp.id);
}
}
for(opportunityLineItem oli:oliList){
if(oli.Serial_No__c!=null){
integer ser=Integer.valueOf(oli.Serial_No__c.charAt(-1));
}
oli.Serial_No__c=oliMap.get(oli.id).Serial_No__c+','+
}
} */
    
    
    public static void pracTrigger(List<opportunityLineItem>oliList){
        
        // Step 1: Collect Opportunity Ids
        Set<Id> oppIds = new Set<Id>();
        for (OpportunityLineItem oli : oliList) {
            if (oli.OpportunityId != null) {
                oppIds.add(oli.OpportunityId);
            }
        }
        
        // Step 2: Get Account Ids from Opportunity
        Set<Id> accIds = new Set<Id>();
        for (Opportunity opp : [SELECT Id, AccountId from Opportunity WHERE Id IN :oppIds AND AccountId != NULL]) {
            accIds.add(opp.AccountId);
        }
        
        // Step 3: Count ALL products across ALL opportunities of those accounts
        List<Account> accList = new List<Account>();
        
        for (AggregateResult agr : [
            SELECT Opportunity.AccountId accId, COUNT(Id) totalCount FROM OpportunityLineItem WHERE Opportunity.AccountId IN :accIds GROUP BY Opportunity.AccountId
        ]) {
            Account acc = new Account();
            acc.Id = (Id) agr.get('accId');
            acc.Total_Product__c = (Integer) agr.get('totalCount');
            accList.add(acc);
        }
        
        // Step 4: Update Accounts
        if (!accList.isEmpty()) {
            update accList;
        }
        
    }
}