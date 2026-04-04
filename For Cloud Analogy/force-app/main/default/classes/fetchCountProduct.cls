public class fetchCountProduct {
    public static void getProduct(){
        List<Opportunity>opp=[Select Name,Id from opportunity limit 99];
       // List<AggregateResult> count=new <AggregateResult>();
       /* try{
        	for(Opportunity temp:opp){
        	Integer oppLine=[select count() from OpportunityLineItem where OpportunityId=:temp.Id ];
        	system.debug(oppLine);   
        	}
        }
        catch(exception e){
            System.debug(e.getMessage());
        }*/
        
        for(Opportunity temp:opp){
      List<AggregateResult>  count=[select count_DISTINCT(product2Id),OpportunityId from opportunitylineItem where OpportunityId=:temp.id group by OpportunityId having count(id)>=2 ];
            if(!count.isEmpty()){
                System.debug(count);}
            
            
        }
    }
}
//group by OpportunityId having count(id)>2