public class forSoql_assignment {
    public static void accNames(){
      List<Account>name=[Select name from account where id in (select accountID from opportunity) limit 3];
        for(Account acc:name){
            system.debug(acc.name);
        }
    }
}