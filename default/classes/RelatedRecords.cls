global class RelatedRecords implements Database.Batchable<sObject> {
    global class RelatedRecordsIterator implements Iterator<sObject>, Iterable<sObject> {
		
		private List<Account> accList;
        private Integer index=0;
        
        public Iterator<sObject> Iterator(){
            return this;
        }
        public RelatedRecordsIterator(){
            accList = [SELECT Id, Name, (SELECT Id, LastName FROM Contacts) FROM Account WHERE CreatedDate <= LAST_N_DAYS: 30 LIMIT 1000];
        }
        public Boolean hasNext(){
            return index< accList.size();
        }
        public Account next(){
            return accList[index++];
        }
    }
    global Iterable<sObject> start(Database.BatchableContext bc){
        return new RelatedRecordsIterator();
    }
    global void execute(Database.BatchableContext bc, List<Account> accList){ 
        List<Contact> updatedContacts = new List<Contact>();
        for(Account acc: accList){
        	for(Contact con: acc.Contacts){
            	con.LastName = con.LastName + '- Updated';
                updatedContacts.add(con);
            }
        }
        if (!updatedContacts.isEmpty()) {
            update updatedContacts;
        }
    }
    global void finish(Database.BatchableContext bc){
        System.debug('Batch Finished');
    }
}