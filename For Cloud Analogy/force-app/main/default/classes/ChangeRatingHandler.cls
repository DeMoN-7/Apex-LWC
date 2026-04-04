public class ChangeRatingHandler {
    public static void populate (List<Account> acc){
       List<Account>SavedAccount=[Select name from account];
       Set<String>nameSet=new Set<String>();
        for(Account temp:SavedAccount){
           	nameSet.add(temp.name);
            }
        for(Account temp:acc){
            if(nameSet.contains(temp.Name)){
                temp.addError('sfdsfd');
            }
        }
        }
    }