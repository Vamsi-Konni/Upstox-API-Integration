public class PreventRecurrsion {
    //public static Boolean rec=false;
    
    private Set<Id> recIds = new Set<Id>();

	public Boolean checkRec(Id recordId) {
        return recIds.contains(recordId);
    }
    public void testRec(Id recordId) {
        recIds.add(recordId);
    }
}