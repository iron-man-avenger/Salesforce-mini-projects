public with sharing class AddTotalAmountOnInvoice {
public static void amountUpdate(List<Invoice_Line_Item__c> inv){

//incoice__c records from the database and sub-query to fetch price__c from Invoice_Line_items__r
list<Invoice__c> record = [Select Id, Total_Amount__c, 
                            (select  price__c from Invoice_Line_items__r)
                            from Invoice__c ];

//Map contains "record" list variable data
Map<Id, Invoice__c> invoiceMap = new Map<Id, Invoice__c>(record);

//map used to store the "Invoice__c" Id and their price__c value
Map<Id, Decimal> invoiceandvalueMap = new Map<Id, Decimal>();

//queries all invoice_line_item__ records related to the invoice__c records in the invoiceMap variable and loops one by one, assigning each record to the lineItem variable
for (Invoice_Line_Item__c lineItem : [SELECT Invoice__c, price__c 
                            FROM Invoice_Line_Item__c 
                            WHERE Invoice__c IN :invoiceMap.keySet()]) {
    
    //Calculate total price of all Invoice_line_item__c records for each invoice__c record
    Decimal total = invoiceandvalueMap.get(lineItem.Invoice__c);
    if (total != null) {
        invoiceandvalueMap.put(lineItem.Invoice__c, total + lineItem.price__c);
        System.debug(invoiceandvalueMap);
    }
    else{
        invoiceandvalueMap.put(lineItem.Invoice__c, lineItem.price__c);
        System.debug(invoiceandvalueMap);
    }
}  

//Only record with ids that match th ekeys of the "invoiceandvalue" map are retrieved
List<Invoice__c> invoiceList = [ Select Id, Total_Amount__c  from Invoice__c where id IN: invoiceandvalueMap.keySet() ];
for (Invoice__c i : invoiceList) {
    i.Total_Amount__c = invoiceandvalueMap.get(i.id);
    System.debug(i.Total_Amount__c);
}
update invoiceList;
}
}