import { LightningElement, wire } from 'lwc';
import accountt from '@salesforce/apex/accountData.accountData1';
import deleteAccounts from '@salesforce/apex/deleteAccount.deleteAccount1';
import { refreshApex } from '@salesforce/apex';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

const column = [
    { label: "Account Id", fieldName: "Id" },
    { label: "Name", fieldName: "Name" },
    { label: "Rating", fieldName: "Rating" }
];

export default class WireAccountDemo extends LightningElement {
    selectedAccountIds = [];
    data1 = [];
    column = column;
    wiredResult;

    @wire(accountt)
    www(result) {
        this.wiredResult = result;
        if (result.data) {
            this.data1 = result.data;
        } else if (result.error) {
            console.log(result.error);
        }
    }

    handleRowSelection(event) {
        const selectedRows = event.detail.selectedRows;
        this.selectedAccountIds = selectedRows.map(row => row.Id);
    }

    deleteRec() {
        if (this.selectedAccountIds.length === 0) {
            this.showToast('Error', 'Please select at least one record', 'error');
            return;
        }

        deleteAccounts({ accountIds: this.selectedAccountIds })
            .then(() => {
                this.showToast('Success', 'Records deleted successfully', 'success');
                this.selectedAccountIds = [];

                // Refresh table
                return refreshApex(this.wiredResult);
            })
            .catch(error => {
                console.error(error);
                this.showToast('Error', 'Error deleting records', 'error');
            });
    }

    showToast(title, message, variant) {
        this.dispatchEvent(
            new ShowToastEvent({
                title,
                message,
                variant
            })
        );
    }
}