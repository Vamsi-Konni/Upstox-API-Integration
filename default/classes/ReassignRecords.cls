global class ReassignRecords implements Database.Batchable<sObject>{
    
    private ID oldOwnerId;
    private ID newOwnerId;
    
    public ReassignRecords(ID oldUser, ID newUser){
        this.oldOwnerId = oldUser;
        this.newOwnerId = newUser;    
    }
    
    global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([
            SELECT Id, OwnerId FROM Opportunity WHERE OwnerId = :oldOwnerId
            
        ]);
    }
    
    global void execute(Database.BatchableContext bc, List<sObject> oldOwnerRecords){
        List<sObject> updatedRecords = new List<sObject>();
            for(sObject rec: oldOwnerRecords){
                if (rec.getSObjectType() == Opportunity.SObjectType) {
                Opportunity opp = (Opportunity) rec;
                opp.OwnerId = newOwnerId;
                updatedRecords.add(opp);
            } else if (rec.getSObjectType() == Lead.SObjectType) {
                Lead le = (Lead) rec;
                le.OwnerId = newOwnerId;
                updatedRecords.add(le);
            	}
            }
    }
    
    global void finish(Database.BatchableContext bc){
        System.debug('Batch Finished');
    }

}