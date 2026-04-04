public class EmployeeTriggerhandler {
    public static void q30(List<Employee__c>empList){
        Set<Id> accIds = new Set<Id>();
        for(Employee__c emp : empList){
            if(emp.Active__c != true){
                accIds.add(emp.Account__c);
            }
        }
        Map<Id, Integer> totalMap = new Map<Id, Integer>();
        for(AggregateResult ar :
            [SELECT Account__c accId, COUNT(Id) cnt
             FROM Employee__c
             WHERE Account__c IN :accIds
             GROUP BY Account__c ALL ROWS]){
                totalMap.put((Id)ar.get('accId'), (Integer)ar.get('cnt'));
        }
        Map<Id, Integer> activeMap = new Map<Id, Integer>();
        for(AggregateResult ar :
            [SELECT Account__c accId, COUNT(Id) cnt
             FROM Employee__c
             WHERE Account__c IN :accIds
             GROUP BY Account__c]){
                activeMap.put((Id)ar.get('accId'), (Integer)ar.get('cnt'));
        }
        Map<Id, Account> accMap =
            new Map<Id, Account>([
                SELECT Id, Deleted_Employee_Count__c
                FROM Account
                WHERE Id IN :accIds
            ]);
        for(Employee__c emp : empList){
            if(emp.Active__c == true){
                emp.addError('Cant Delete Active Record');
            }
            else{
                Integer total = totalMap.containsKey(emp.Account__c)
                                ? totalMap.get(emp.Account__c) : 0;
                Integer active = activeMap.containsKey(emp.Account__c)
                                 ? activeMap.get(emp.Account__c) : 0;
                accMap.get(emp.Account__c).Deleted_Employee_Count__c =
                    total - active;
            }
        }
        update accMap.values();
    }
    
    public static void q31(List<Employee__c>empList){
        Set<ID>accids=new Set<Id>();
        for(Employee__c ep:empList){
            accids.add(ep.Account__c);
        }
        
    }
}