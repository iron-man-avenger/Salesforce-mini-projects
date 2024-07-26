public with sharing class PdfGenerator {
    public class PdfGenerationResult {
        @AuraEnabled
        public String attachmentId;
        @AuraEnabled
        public Boolean isSuccess;
    }

    @AuraEnabled(cacheable=true)
    public static PdfGenerationResult generatePdf(String recordId) {
        // Fetch the record details using SOQL or any other method
        // Prepare the Visualforce page content (replace this with your content)
        String vfPageContent = '<apex:page><h1>Record Details</h1><p>Replace this with record details</p></apex:page>';
        
        // Generate the PDF
        PageReference pdfPage = Page.PdfPage;
        pdfPage.getParameters().put('content', vfPageContent);
        Blob pdfBlob = pdfPage.getContentAsPDF();
        
        // Save the PDF as an attachment to the record
        Attachment attachment = new Attachment();
        attachment.ParentId = recordId;
        attachment.Name = 'RecordDetails.pdf';
        attachment.Body = pdfBlob;
        insert attachment;

        PdfGenerationResult result = new PdfGenerationResult();
        if (attachment.Id != null) {
            result.isSuccess = true;
            result.attachmentId = attachment.Id;
        } else {
            result.isSuccess = false;
            result.attachmentId = null;
        }

        return result;
    }
}
