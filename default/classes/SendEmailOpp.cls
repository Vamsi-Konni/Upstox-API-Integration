//send email to all Opportunity records that were marked "Closed" in the past 30 days.
global class SendEmailOpp implements Database.Batchable<sObject>{
    private List<Opportunity> ClosedOpps = new List<Opportunity>();
    global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([Select Id, Name from Opportunity WHERE CloseDate <= LAST_N_DAYS:30]);
    }
    
    global void execute(Database.BatchableContext bc, List<Opportunity> oppList){
        for(Opportunity opp: oppList){
            opp.StageName = 'ClosedWon';
        }
        if(!oppList.isEmpty()){
            update oppList;
            ClosedOpps.addAll(oppList);
        }
    }
    
    global void finish(Database.BatchableContext bc){
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
        for (Opportunity opp : ClosedOpps) {
            String emailAddress;
            if (opp.AccountId != null) {
                Account acc = [SELECT Id, Owner.Email FROM Account WHERE Id = :opp.AccountId];
                emailAddress = acc.Owner.Email;
            } else {
                continue;
            }

            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setToAddresses(new String[]{emailAddress});
            mail.setSubject('Follow-up: Your Opportunity ' + opp.Name);
            mail.setPlainTextBody('Your opportunity "' + opp.Name + '" was closed.');
            emails.add(mail);
        }

        if (!emails.isEmpty()) {
            Messaging.sendEmail(emails);
        }
    }

}