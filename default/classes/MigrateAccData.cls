//Assign Acc Data to Order_Processing__c Obj
global class MigrateAccData implements Database.Batchable<sObject> {
    global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQuerylocator([SELECT Id, Name, CreatedDate, LastModifiedDate 
                                         FROM Account 
                                         WHERE LastModifiedDate <:System.today().addMonths(-3)]);
        
    }
    global void execute(Database.BatchableContext bc, List<Account> accList){
        List<Order_Processing__c> orderList = new List<Order_Processing__c>();
        for(Account acc: accList){
            Order_Processing__c ord = new Order_Processing__c(
            	Name = acc.Name,
                Id = acc.Id,
                Created_Date__c  = acc.CreatedDate,
                Last_Modified_Date__c  = acc.LastModifiedDate
            );
            orderList.add(ord);
        }
        if(!orderList.isEmpty()){
            update orderList; 
        }
    }
    
    global void finish(Database.BatchableContext bc){
        System.debug('Batch Finished');
    }
}