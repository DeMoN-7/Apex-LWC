import { LightningElement } from 'lwc';
import acc from '@salesforce/apex/accountData.accountData1';
const column=[
    {label:'Account Name',fieldName:'Id'},
    {label:'Account Id',fieldName:'Name'},
    {label:'Account Rating',fieldName:'Rating'}

]
export default class Imperativee extends LightningElement {
    columns=column;
    data=[];
    handleClick(){
        
    }
}