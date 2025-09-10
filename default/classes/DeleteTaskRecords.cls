//Delete Tasks older than 2 years
global class DeleteTaskRecords implements Database.Batchable<sObject> {
    
    global Database.QueryLocator start(Database.BatchableContext bc){ 
        return Database.getQueryLocator([Select Id from Task WHERE CreatedDate < LAST_N_YEARS:2]);
    }
    
    global void execute(Database.BatchableContext bc, List<Task> tList){
        for(Task ts: tList){
            ts.Status = 'Completed';
        }
        if(!tList.isEmpty()){
            update tList;
        }
    }
    
    global void finish(Database.BatchableContext bc){
        System.debug('Finished');
    }

}