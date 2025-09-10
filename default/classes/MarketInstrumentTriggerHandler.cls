public with sharing class MarketInstrumentTriggerHandler {
    public static void sendEmails(List<Market_Instrument__c> marketList) {
        if (marketList.isEmpty()) {
            return;
        }
    
        String recipientEmail = marketList[0].Owner.Email;
        if (recipientEmail == null) return;
    
        String body = 'Hello ' + marketList[0].Owner.Name + ',<br/><br/>' +
                      'The following Market Instruments were created:<br/><br/>';
    
        for (Market_Instrument__c mi : marketList) {
            body += '<b>Name:</b> ' + mi.Name__c + 
                    ' | <b>Exchange:</b> ' + mi.Exchange__c +
                    ' | <b>Symbol:</b> ' + mi.Symbol__c + 
                    ' | <b>Instrument Key:</b> ' + mi.Instrument_Key__c +
                    ' | <b>Token:</b> ' + mi.Token__c +
                    ' | <b>Lot Size:</b> ' + mi.Lot_Size__c +
                    ' | <b>Tick Size:</b> ' + mi.Tick_Size__c +
                    ' | <b>Expiry Date:</b> ' + mi.Expiry__c +  '<br/>';
        }
    
        body += '<br/>Thanks,<br/>Salesforce Trigger';
    
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setToAddresses(new List<String>{ recipientEmail });
        email.setSubject('New Market Instruments Created (' + marketList.size() + ')');
        email.setHtmlBody(body);
    
        Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{ email });
    }
}