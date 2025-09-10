public class OpportunityTrigger1Handler {
    public static void greaterAmount(List<Opportunity> oppList){
        for(Opportunity opp: oppList){
            if(opp.Amount!=null && opp.Amount>100000){
                opp.Description = 'Hot Opportunity';
            }
        }
    }
}