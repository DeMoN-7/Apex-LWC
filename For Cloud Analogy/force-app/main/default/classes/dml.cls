public class dml {
    public static void insertt(){
        // System.debug('Account created with id:'+record.id);
      /*  List<Account> accRecord=new List<Account>();
        for(integer i=0;i<3;i++){
            Account temp=new Account(Name='Ayush'+i);
            accRecord.add(temp);
        }
        insert accRecord;*/
        /*Account record=new Account(Name='Ayush Using Apex',Phone='789456');
        insert record;
        Contact con = new Contact(LastName='Singh',AccountId=record.id,FirstName='Akhilesh');
        insert con;
        */
        
        Account acc= [Select Id,Name,Phone from account where Name='Ayush112'];
        acc.AnnualRevenue=1000000;
        update acc;
        //system.asserEquals('1000;00',acc.AnnualRevenue,'Not Equal');
    }
}