global class BatchClass2 implements Database.Batchable<sObject>{
	private String Query;
    
    global BatchClass2(String soql){
       this.Query=soql;
    }
    
    global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator(Query);
    }
    
    global void execute(Database.BatchableContext bc, List <Account> accs){
        for(Account acc: accs){
            acc.Name = acc.Name + 'Active'; 
        }
    }
    
    global void finish(Database.BatchableContext bc){
        System.debug('Processing Active Accounts Completed');
    }
}