import { LightningElement,api } from 'lwc';
import Account_Object from '@salesforce/schema/Account';
import Account_Name from '@salesforce/schema/Account.Name';
import Account_Phone from '@salesforce/schema/Account.Phone';
import Account_Website from '@salesforce/schema/Account.Website';
export default class SldsDemo extends LightningElement {
    recordId="001g5000008SnIwAAK";
objectApiName = Account_Object;
nameField = Account_Name;
phoneField = Account_Phone;
websiteField = Account_Website;
}