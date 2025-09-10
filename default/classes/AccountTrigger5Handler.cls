public class AccountTrigger5Handler {
	public static void accPhone(List<Account> accList,Map<Id,Account> oldMap){
		for(Account acc:accList){
			if ((acc.Phone != oldMap.get(acc.Id).Phone) && (acc.Phone == null || !acc.Phone.equals(oldMap.get(acc.Id).Phone))){
				acc.Description='Phone is updated! Old Value : '+oldMap.get(acc.Id).Phone+' & New Value : '+acc.Phone;
			}
		}
	}
}