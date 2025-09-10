public class OrderProcessingEventHandler {
    
    public static void createOrders(List <Order_Event__e> OrderPE){
    
        List<Order_Processing__c> OrderList = new List<Order_Processing__c>();
    
        for(Order_Event__e Order_Event: OrderPE){
    
            Order_Processing__c OP = new Order_Processing__c();
            
                OP.Order_Number__c = Order_Event.Order_Number__c;
                OP.InStock__c = Order_Event.In_Stock__c;
                OP.Order_Date__c = Order_Event.Order_Date__c;
                OP.Customer_Name__c = Order_Event.Customer_Name__c;
                OP.Quantity__c = Order_Event.Quantity__c;
                OP.Total_Price__c = Order_Event.Price__c;
                //OP.Discount_Amoumt__c = Order_Event.Amount__c;

            OrderList.add(OP);
        }
        if(!OrderList.isEmpty()){
                insert OrderList;
          }
          else{
               system.debug('Order Record is not Created');
          }
      
    }
}