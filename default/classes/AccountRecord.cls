public class AccountRecord{
    public static Id insertAccount(String Name, String Rating){
	
		Account acc = new Account();
        acc.Name = Name;
        acc.Rating = Rating;  
        insert acc;
        return acc.Id;
    }
    
    public static void insertContact(){
        Id accid;
        accid = insertAccount('Salesforce','Warm');
        Contact con = new Contact(FirstName = 'Test', LastName = 'Contact');
        con.AccountId=accid;
        insert con;
    }
    
    public static void insertConAccount(String Name, String Rating){
        
        Account acc=new Account();
        
        acc.Name = Name;
        acc.Rating = Rating;
        insert acc;
        
        Contact con = new Contact(FirstName = 'Vamsi', LastName = 'Test');
        con.AccountId = acc.id;
        insert con;
        
        Opportunity opp = new Opportunity();
        opp.Name = 'Opp Test';
        opp.CloseDate= System.Today();
        opp.StageName = 'Prospecting';
        opp.AccountId = acc.Id;
        insert opp;
        
        Case cs = new Case();
        cs.Status='Working';
        cs.Origin='Email';
        cs.AccountId=acc.id;
        insert cs;
    }

	
}