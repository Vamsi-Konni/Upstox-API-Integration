public class OrderRecordsController {
    @AuraEnabled(Cacheable=true)
    public static List<Order_Processing__c> getOrderProcessingRecords() {
        return [SELECT Id, Name, Customer_Name__c, Order_Date__c,Quantity__c FROM Order_Processing__c];
    }
}