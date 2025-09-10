public class SetDemo {
    
    public static void createSet(){
		Set<Id> accSet = new Set<Id>();
		List<Account> accList = new List<Account>();
        
        accList=[Select Id, Name from Account LIMIT 5];
        
        for(Account acc: accList){   
            accSet.add(acc.Id);
        }
        
        System.debug(accSet);
    
	}
}