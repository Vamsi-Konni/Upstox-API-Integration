global class DynamicAccountFilter implements Database.Batchable<sObject>{
    private String dynamicFilter;  	
    global DynamicAccountFilter(String filter){
    	this.dynamicFilter = filter;
    }
    global class DynamicAccountFilterIterator implements Iterator<sObject>, Iterable<sObject>{
        private List<Account> accList;
        private Integer index=0;
        
		public Iterator<sObject> iterator() 	{
            		return this;
        	}
        public DynamicAccountFilterIterator(String filterCriteria){
			String query = 'SELECT Id, Name FROM Account WHERE ' + filterCriteria + ' LIMIT 100';
            accList = Database.query(query);
        }
        public boolean hasNext(){
            return index < accList.size();
        }
        public Account next(){
            return accList[index++];
        }
    }
    
    global Iterable<sObject> start(Database.BatchableContext bc){
        return new DynamicAccountFilterIterator(dynamicFilter);
    }
    
    global void execute(Database.BatchableContext bc, List<Account> updatedAccounts){
        for(Account acc: updatedAccounts){
            acc.Name = acc.Name + 'Update';
        }
        if(!updatedAccounts.isEmpty()){
            update updatedAccounts;
        }
    }
    
    global void finish(Database.BatchableContext bc){
        System.debug('Batch Finished');
    }
}