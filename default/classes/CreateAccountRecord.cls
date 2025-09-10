public class CreateAccountRecord {
    public static Id insertAccount(String Name, String Rating){
        Account acc = new Account();
        acc.Name = Name;
        acc.Rating = Rating;  
        insert acc;
        return acc.Id;
    }
    
    
    
}