public class AccWithConOpp {
    public static void insertAccount(String Name, String Rating){
        
        Account acc=new Account();
        
        acc.Name = Name;
        acc.Rating = Rating;
        insert acc;
        
        Contact con = new Contact(FirstName = 'Vamsi 1', LastName = 'Test');
        con.AccountId = acc.id;
        insert con;
        
        Opportunity opp = new Opportunity();
        opp.Name = 'Opp Test 1';
        opp.CloseDate= System.Today();
        opp.StageName = 'Prospecting';
        opp.AccountId = acc.Id;
        insert opp;
        
        
        Case cs = new Case();
        cs.Status='Working';
        cs.Origin='Phone';
        cs.AccountId=acc.id;
        insert cs;
    }
}