public class BatchApex implements Database.batchable<sobject> {
    public database.queryLocator start(Database.BatchableContext bc){
        return database.getQueryLocator('Select id,StageName from opportunity');
    }
    public void execute(Database.BatchableContext bc,List<Opportunity> oppList){
        for(Opportunity opp:oppList){
            opp.stageName='Prospecting';
        }
        update oppList;
    }
    public void finish(Database.BatchableContext bc){
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

    mail.setToAddresses(new List<String>{ UserInfo.getUserEmail() });
    mail.setReplyTo('varun.sachdeva@learnowx.com');
    mail.setSenderDisplayName('Batch Processing');
    mail.setSubject('Batch Process Completed');
    mail.setPlainTextBody('Batch Process has completed');

    Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{ mail });
        
        
        
       // Account acc=new Account(Name='Ayush',Description='All opportunity is set to prospecting');
       // Insert acc;
    }
}