global class ConvertLeads implements Database.Batchable<sObject>{
    global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([SELECT ID from Lead WHERE Status = 'Qualified' AND IsConverted = false]);
    }
    global void execute(Database.BatchableContext bc, List<Lead> LeadsConverted){
        List<Database.LeadConvert> lead = new List<Database.LeadConvert>();
        for(Lead le: LeadsConverted){
            Database.LeadConvert lc = new Database.LeadConvert();
            lc.setLeadId(le.ID);
            lc.setDoNotCreateOpportunity(false);
            lc.setConvertedStatus('Closed - Converted');
            lead.add(lc);
        }
        if (!lead.isEmpty()) {
            List<Database.LeadConvertResult> results = Database.convertLead(lead, false);
            for (Database.LeadConvertResult result : results) {
                if (!result.isSuccess()) {
                    System.debug('Lead Conversion Failed: ' + result);
                }
            }
        }
    }
    global void finish(Database.BatchableContext bc){
        System.debug('Batch finished');
    }
}