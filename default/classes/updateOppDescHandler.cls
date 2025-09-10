public class updateOppDescHandler {
    public static void updateDesc(List<Opportunity> oppList, Map<Id,Opportunity> oldMap){
        for(Opportunity opp: oppList){
            if(!oldMap.containsKey(opp.Id) || opp.StageName != oldMap.get(opp.Id).StageName) {
                if(opp.StageName== 'Closed Won'){
					opp.Description = 'Opportunity is Closed won';
				}else if(opp.StageName=='Closed Lost'){
					opp.Description = 'Opportunity is closed lost';
				}else{
					opp.Description = 'Opportunity is open';
                }
            }
        }   
    }
}