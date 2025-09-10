trigger MarketInstrumentTrigger on Market_Instrument__c (after insert, after update) {
    switch on Trigger.operationType {
        when AFTER_INSERT {
            MarketInstrumentTriggerHandler.sendEmails(Trigger.new);
        }
    }
}