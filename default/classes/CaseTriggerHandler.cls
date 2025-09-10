public class CaseTriggerHandler {
    public static void LatestCaseNumber(List<Case> csList){
        List<Account> accList = new List<Account>();
        for(Case cs: csList){
            Account acc = new Account();
            acc.id = cs.AccountId;
            acc.Latest_Case_Number__c  = cs.CaseNumber;
            accList.add(acc);
        }
        if(!csList.isEmpty()){
			insert csList;
		}
    }
}

/*When a Case is created on any Account, put the latest case number on the
Account in the ‘Latest Case Number’ field.*/