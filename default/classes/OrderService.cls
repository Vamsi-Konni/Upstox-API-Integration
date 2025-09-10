@RestResource(urlMapping='/OrdersWithQuantity')
global with sharing class OrderService {
    @HttpGet
    global static List<Order_Processing__c> getOrdersWithQuantity() {
        List<Order_Processing__c> orders = [SELECT Id, Name, Quantity__c FROM Order_Processing__c WHERE Quantity__c > 5];
        return orders;
    }
}