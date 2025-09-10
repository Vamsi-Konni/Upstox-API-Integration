global class BatchClass1 implements DataBase.Batchable<sObject> {
	
    global DataBase.QueryLocator start(DataBase.BatchableContext bc){
        return Database.getQueryLocator('SELECT Id, Name FROM Account');
    }
    
    global void execute(Database.BatchableContext bc, List<Account> accList){
        for(Account acc: accList){
            acc.Name = acc.Name + 'Updated';
        }
        update accList;
    }
    
    global void finish(Database.BatchableContext bc){
        System.debug('Batch processing completed!');
    }    
}