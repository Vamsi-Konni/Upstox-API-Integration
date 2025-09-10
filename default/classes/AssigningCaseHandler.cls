public class AssigningCaseHandler {
    public static void AssigningCaseHandlerMethod(List<Case> caseNew, String triggerOperationType) {
        try {
            // Fetch the Case Queue
            Group caseQueue = [SELECT Id FROM Group WHERE Type = 'Queue' AND Name = 'Assigning_CaseRec' LIMIT 1];

            for (Case cs : caseNew) {
                if (cs.Type == 'Technical Support') {
                    if (triggerOperationType == 'BEFORE_INSERT' || 
                       (triggerOperationType == 'BEFORE_UPDATE' && cs.OwnerId != caseQueue.Id)) {
                        cs.OwnerId = caseQueue.Id; // Directly assign in before trigger (no need for update DML)
                    }
                }
            }
        } catch (Exception e) {
            System.debug('Error in AssigningCaseHandler: ' + e.getMessage());
        }
    }
}


/*public class AssigningCaseHandler {
    public void AssigningCaseHandlerMethod(list<case> caseNew, string triggerOperationtype) {
        
    Group caseQueue = [SELECT Id FROM Group WHERE Type = 'Queue' AND Name = 'Assigning_CaseRec'];
    List<Case> casesToUpdate = new List<Case>();
    for (Case cs : caseNew) {
        if (cs.Type == 'Technical Support') {
            if (triggerOperationtype == 'before_insert' || ((triggerOperationtype == 'before_update') && cs.OwnerId != caseQueue.Id)) {
                cs.OwnerId = caseQueue.Id;
                casesToUpdate.add(cs);
            }
        }
    }
    if (!casesToUpdate.isEmpty()) {
        update casesToUpdate;
        }
    }
} */