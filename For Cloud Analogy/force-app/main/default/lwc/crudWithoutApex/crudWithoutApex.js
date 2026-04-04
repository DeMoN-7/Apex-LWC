import { LightningElement, wire } from 'lwc';
import { createRecord, getRecord } from 'lightning/uiRecordApi';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import ACCOUNT_NAME from '@salesforce/schema/Account.Name';
import Industry from '@salesforce/schema/Account.Industry';
import Phone from '@salesforce/schema/Account.Phone';
import Name from '@salesforce/schema/Account.Name';
import Type from '@salesforce/schema/Account.Type';

const fields = [Name, Industry, Phone, Type];

export default class CrudWithoutApex extends LightningElement {
    accountName;
    accountType;
    accountPhone;
    accountId;
    accountDetails;

    name;
    accountId;

    handleChange(event) {
        this.name = event.target.value;
    }

    handleClick() {
        const fields = {};
        fields[ACCOUNT_NAME.fieldApiName] = this.name;

        const recordInput = {
            apiName: ACCOUNT_OBJECT.objectApiName,
            fields
        };

        createRecord(recordInput)
            .then(account => {
                this.accountId = account.id;
                console.log('Account created: ', account.id);
            })
            .catch(error => {
                console.error(error);
            });
    }

    @wire(getRecord, { recordId: '$accountId', fields })
    wireData({ data, error }) {
        if (data) {
            this.accountDetails = data;
            this.accountName = this.accountDetails.fields.Name.value;
            this.accountType = this.accountDetails.fields.Type.value;
            this.accountId=this.accountDetails.id.value;

        }
        else if (error) {
            console.log(error);
        }
    }

}