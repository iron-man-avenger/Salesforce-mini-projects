@isTest
private class AddTotalAmountOnInvoiceTest {
    @isTest
    static void testAmountUpdate() {
        // Create a test invoice
        List<Invoice__c> invoicelist = new List<Invoice__c>();
        Invoice__c invoice = new Invoice__c(Name = 'Test Invoice23');
        invoicelist.add(invoice);
        System.debug(invoicelist );
        if (invoicelist.size()>0) {
            insert invoicelist;
        }
        
        // Create test line items
        Invoice_Line_Item__c lineItem1 = new Invoice_Line_Item__c(Invoice__c = invoice.Id, price__c = 100);
        Invoice_Line_Item__c lineItem2 = new Invoice_Line_Item__c(Invoice__c = invoice.Id, price__c = 50);
        insert new List<Invoice_Line_Item__c>{lineItem1, lineItem2};
        System.debug(lineItem1);
        System.debug(lineItem2);
        List<Invoice_Line_Item__c> addInvoicelineitem = new List<Invoice_Line_Item__c>();
        lineItem1.price__c = 120;
        lineItem2.price__c = 70;
        addInvoicelineitem.add(lineItem1);
        addInvoicelineitem.add(lineItem2);
        // Update the Invoice_Line_Item__c
        try {
        if (addInvoicelineitem.size()>0) {
                update addInvoicelineitem;
            }
            System.debug(addInvoicelineitem);
            Decimal totalAmount = lineItem1.price__c + lineItem2.price__c;
            invoice.Total_Amount__c = totalAmount;
            // Update the invoice
            if (invoicelist.size()>0) {
                update invoice;
            }
            System.debug(invoice);
            // Verify that the total amount on the invoice has been updated
            Invoice__c updatedInvoice = [SELECT Total_Amount__c FROM Invoice__c WHERE Id = :invoice.Id];
            System.assertEquals(totalAmount, updatedInvoice.Total_Amount__c);
        } catch (Exception Error) {
            System.assert(false, 'Exception expected');
        }
    }
}