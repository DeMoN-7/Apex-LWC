public class Assignment_9 {
    public static void oppLine(){
        /*
         * Set<ID> idWithAttachment=new Set<ID>();
        for(ContentDocumentLInk attach:[Select LinkedEntityId from ContentDocumentLInk
                                        where LinkedEntityId!=null]){
            idWithAttachment.add(attach.LinkedEntityId);
        }
        
*/
        List<Account> accList=[Select ID,Name,
                               (Select id from Contacts),
                              (select LinkedEntityId from ContentDocumentLInks)
                              From Account];
        System.debug(accList);
        
    }
}