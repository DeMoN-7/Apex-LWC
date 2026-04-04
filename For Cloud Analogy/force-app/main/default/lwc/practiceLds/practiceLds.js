import { LightningElement } from 'lwc';
import account_phone from '@salesforce/schema/Account.Phone';
import account_name from '@salesforce/schema/Account.Name';
import account_type from '@salesforce/schema/Account.Type';
import account_industry from '@salesforce/schema/Account.Industry';
import account_annual from '@salesforce/schema/Account.AnnualRevenue';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
export default class PracticeLds extends LightningElement {
    NameField=account_name;
    PhoneField=account_phone;
    TypeField=account_type;
    AnnualRevenue=account_annual;
    Industry=account_industry;
    
    handleSuccess(){
        const event= new ShowToastEvent({
            title:'Success',
            message:'Account Created SuccessFully',
            variant:'Success'
        })
        this.dispatchEvent(event);
    }
}