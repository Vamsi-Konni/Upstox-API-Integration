global class RollUpAccRelated implements Database.Batchable<sObject>{
    
    global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([SELECT ID, Name FROM Account]);
    }
    global void execute(Database.BatchableContext bc, List<Account> accList){
        Set<Id> accIds = new Set<Id>();
        for(Account acc: accList){
            accIds.add(acc.ID);
        }
        
        Map<Id,Integer> totalCon = new Map<Id,Integer>();
        Map<Id,Integer> totalOpp = new Map<Id,Integer>();
        
        //put(Object key, Object value)
        for(AggregateResult ar: [SELECT COUNT(Id) tCon ,AccountId FROM Contact 
                                 WHERE AccountId IN: accIds 
                                 GROUP BY AccountId]){
                                     totalCon.put((Id) ar.get('AccountId'), (Integer) ar.get('tCon'));
        }
        
        for(AggregateResult ar:[SELECT COUNT(Id) tOpp, AccountID from Opportunity
                               WHERE AccountId IN: accIds
                                GROUP BY AccountId]){
                                    totalOpp.put((Id) ar.get('AccountId'), (Integer) ar.get('tOpp'));
                                }
        
		List<Account> TotalCount = new List<Account>();
        for(Account acc: accList){
            acc.Total_Con__c = totalCon.containsKey(acc.Id) ? totalCon.get('acc.Id') : 0;
            acc.Total_Opp__c = totalOpp.containsKey(acc.Id) ? totalOpp.get('acc.Id') : 0;
        }
        
        if(!TotalCount.isEmpty()){
            update TotalCount;
        }
    }
    global void finish(Database.BatchableContext bc){
        System.debug('Batch finished');
    }
}