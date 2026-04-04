import { LightningElement, wire, api } from 'lwc';
import relContact from '@salesforce/apex/fContacts.fContacts';
import accDetails from '@salesforce/apex/showAccDetails.showAccDetails';
const COLUMNS = [
    { label: "Contact Id", fieldName: "Id" },
    { label: "Last Name", fieldName: "LastName" }
];
export default class AccRecordPage extends LightningElement {
    @api recordId;
    show = false;
    contacts = [];
    column = COLUMNS;
    accName = '';
    accType = '';
    accIndustry = '';
    accPhone = '';
    @wire(relContact, { acid: '$recordId' })
    wiredContacts({ error, data }) {
        if (data) {
            this.contacts = data;
            this.show = data.length > 0;
        } else if (error) {
            console.error(error);
        }
    }
    @wire(accDetails, { accId: '$recordId' })
    wiredAccount({ error, data }) {
        if (data) {
            this.accIndustry = data.Industry || '';
            this.accName = data.Name || '';
            this.accPhone = data.Phone || '';
            this.accType = data.Type || '';
        } else if (error) {
            console.error(error);
        }
    }
}