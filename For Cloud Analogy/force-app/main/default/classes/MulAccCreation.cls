public class MulAccCreation {
    public static void del(){
        list<Account>acclist=new list<Account>();
        for(integer i=0;i<9999;i++){
            Account acc=new Account(name='apex'+i);
            acclist.add(acc);
        }
        insert accList;
    }
}