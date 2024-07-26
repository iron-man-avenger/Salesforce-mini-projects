public with sharing class AddTotalAmountOnInvoiceHelper {
    public static void amountUpdate(List<Invoice_Line_Item__c> inv) {
        Set<Id> invoiceIds = new Set<Id>();
        for (Invoice_Line_Item__c lineItem : inv) {
            invoiceIds.add(lineItem.Invoice__c);
        }

        Map<Id, Decimal> invoiceTotalMap = new Map<Id, Decimal>();

        for (Invoice_Line_Item__c lineItem : [SELECT Invoice__c, price__c 
                                                FROM Invoice_Line_Item__c 
                                                WHERE Invoice__c IN :invoiceIds]) {
            Decimal total = invoiceTotalMap.get(lineItem.Invoice__c);
            invoiceTotalMap.put(lineItem.Invoice__c, total != null ? total + lineItem.price__c : lineItem.price__c);
            System.debug(invoiceTotalMap);
        }

        List<Invoice__c> invoiceListToUpdate = [SELECT Id, Total_Amount__c 
                                                FROM Invoice__c 
                                                WHERE Id IN :invoiceTotalMap.keySet()];

        for (Invoice__c invoiceToUpdate : invoiceListToUpdate) {
            invoiceToUpdate.Total_Amount__c = invoiceTotalMap.get(invoiceToUpdate.Id);
        }

        update invoiceListToUpdate;
        System.debug(invoiceListToUpdate);
    }
}
