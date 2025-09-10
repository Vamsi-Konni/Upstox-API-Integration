//A company wants to update the Status__c field on all Opportunity records older than a year to "Closed".
global class UpdateOppRecords implements Database.Batchable<sObject>{
    
    global Database.QueryLocator start(Database.BatchableContext bc){
        Date dt = System.today().addYears(-1); 
        return Database.getQueryLocator([
            SELECT Id, StageName, CreatedDate FROM Opportunity WHERE CreatedDate <= :dt AND StageName != 'ClosedWon']);
    }
        
    global void execute(Database.BatchableContext bc, List<Opportunity> oppList){
        for(Opportunity opp: oppList){
            opp.StageName = 'ClosedWon';
        }
        
        if(!oppList.isEmpty()){
            update oppList;
        }
    }
    
    global void finish(Database.BatchableContext bc){
        System.debug('Batch finished');
    }
}