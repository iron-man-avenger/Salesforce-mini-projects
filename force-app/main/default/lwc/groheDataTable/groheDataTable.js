import { LightningElement, wire, track } from 'lwc';
import getGroheRecords from '@salesforce/apex/GroheController1.getGroheRecords';


export default class GroheDataTable extends LightningElement {
    @wire(getGroheRecords, { searchKey: '$searchTerm' }) groheRecords;
    @track searchTerm = '';

    columns = [
        { label: 'Name', fieldName: 'Name', type: 'text' },
        { label: 'Area', fieldName: 'Area__c', type: 'text' },
        { label: 'Code', fieldName: 'Code__c', type: 'text' },
        { label: 'Image', fieldName: 'Image__c', type: 'url' },
        { label: 'Discount', fieldName: 'Discount__c', type: 'percent' },
        { label: 'MRP', fieldName: 'MRP__c', type: 'currency' },
        { label: 'Quantity', fieldName: 'Quantity__c', type: 'number' },
        { label: 'Total', fieldName: 'Total__c', type: 'currency' },
    ];

    selectedRows = [];
    handleSearchChange(event) {
        this.searchTerm = event.target.value;
    }

    get filteredGroheRecords() {
        // Filter the records based on the search term
        const searchLower = this.searchTerm.toLowerCase();
        return this.groheRecords.data
            ? this.groheRecords.data.filter(record =>
                  record.Name.toLowerCase().includes(searchLower) ||
                  record.Area__c.toLowerCase().includes(searchLower) ||
                  record.Code__c.toLowerCase().includes(searchLower)
              )
            : [];
    }

    data = 'Sample Data'; // Replace this with your actual data

    groheRecords = [
        { Name: 'Product 1', Area__c: 'Area 1' },
        { Name: 'Product 2', Area__c: 'Area 2' }
        // Add more records
    ];

    generatePDF() {
        const selectedRecords = this.selectedRows.map(row => row.Id);
        const vfPageUrl = '/apex/GroheDataTableVFPage?renderAs=pdf&selectedRecords=' + selectedRecords.join(',');
        window.open(vfPageUrl, '_blank');
        console.log('Selected Records:', selectedRecords); // Log the selected records
    }
    
}


