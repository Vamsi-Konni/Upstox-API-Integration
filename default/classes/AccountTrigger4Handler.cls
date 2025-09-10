public class AccountTrigger4Handler {
    public static void createContactOrOpp (List<Account> accList){
        
        List<Contact> conList = new List<Contact>();
        List<Opportunity> oppList = new List<Opportunity>();
        
        for(Account acc: accList){
            if(acc.Contact__c == True){
                Contact con = new Contact();
                con.LastName = acc.Name;
                con.AccountId = acc.id;
                conList.add(con);
            }
            if(acc.Opportunity__c == True && acc.Active__c == 'Yes'){
                Opportunity opp = new Opportunity();
                opp.Name = acc.Name;
                opp.AccountId = acc.Id;
                oppList.add(opp);
            }
            if(oppList.size()>0){
				insert oppList;
			}
			if(conList.size()>0){
				insert conList;
			}
        }
    }
}