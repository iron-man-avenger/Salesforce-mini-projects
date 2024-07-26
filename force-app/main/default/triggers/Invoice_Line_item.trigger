trigger Invoice_Line_item on Invoice_Line_Item__c (after insert, after Update) {

    // if((trigger.IsInsert == true && Trigger.Isafter == true) 
    // ||(trigger.IsUpdate == true && Trigger.Isafter == true)){
        
    // }
    TriggerDispatcher.run(new AddTotalAmountOnInvoiceHandler(), 'Invoice_Line_item');
}