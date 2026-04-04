public class CalcQuantity {
    public static integer calc(){
        AggregateResult[] result = [
            SELECT SUM(Quantity) totalQty
            FROM OpportunityLineItem
            WHERE Opportunity.Account.Working_in__c INCLUDES ('Asia')
        ];
        
        Decimal total = (Decimal) result[0].get('totalQty');
        System.debug(total);
        return 0;
    }
}