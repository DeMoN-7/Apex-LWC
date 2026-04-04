public class FutureApexClass {
    public static void RunAll(){
        // IsRunning();
       // IsSleeping();
      create();
        CreateLinked();
    }
    public static void create(){
        Account acc=new Account(name='AyushFuture1');
        insert acc;
    }
    @future
    public static void CreateLinked(){
		Account acc=[Select Name from account where name='AyushFuture1' limit 1];
        Contact con=new Contact(LastName='Futre Account contact1',accountId=acc.id);
        insert con;
    }
    
    
   /* public static void IsRunning(){
        System.debug('User is Running');
    }
    @Future
    public static void IsSleeping(){
        System.debug('User is Sleeping');
    } */
}