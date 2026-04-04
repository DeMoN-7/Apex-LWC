import { LightningElement, wire } from 'lwc';
import accountt from '@salesforce/apex/accountData.accountData1';
import contactt from '@salesforce/apex/fContacts.fContacts';

const column = [
    { label: "Contact Id", fieldName: "Id" },
    { label: "LastName", fieldName: "LastName" },
    { label: "Email", fieldName: "Email" }
]

export default class ComboboxPractice extends LightningElement {
    zz = 'Select Account';
    column = column;
    acid;
    data1 = [];
    condata = [];

    show = false;

    @wire(accountt)
    www({ error, data }) {
        if (data) {
            this.data1 = data.map(item => {
                return {
                    label: item.Name,
                    value: item.Id
                };
            });

        }
        else {
            console.log(error);
        }
    }

    @wire(contactt, { acid: '$acid' })
    wiredData({ error, data }) {
        if (data) {
            this.condata = data;
        }
        else {
            console.log(error);
        }
    }

    get options() {
        return this.data1;
    }
    handleChange(event) {
        this.zz = event.detail.value;
        this.acid = event.detail.value;
        this.show = true;


    }
    
}