//Processing Large Account Data Using an Iterator for Last 30days
global class AccountData implements Database.Batchable<sObject>{
    global class AccountDataIterator implements Iterator<sObject>, Iterable<sObject> {
        private List<Account> accList;
        private Integer index=0;
        
        public Iterator<sObject> iterator(){
            return this;
        }
        public AccountDataIterator(){
            accList = [SELECT ID FROM Account WHERE CreatedDate <= LAST_N_DAYS:30];
        }
        public boolean hasNext(){
            return index<accList.size();
        }
        public Account Next(){
            return accList[index++];
        }
    }
    
    global Iterable<sObject> start(Database.BatchableContext bc){
        return new AccountDataIterator();
    }
    
    global void execute(Database.BatchableContext bc, List<Account> updatedAcc){
        for(Account acc: updatedAcc){
            acc.Name = acc.Name + 'Iterator Updated';
        }
        if(!updatedAcc.isEmpty()){
       		update updatedAcc;
        }
    }
    global void finish(Database.BatchableContext bc){
        System.debug('Batch Finished');
    }
    
}