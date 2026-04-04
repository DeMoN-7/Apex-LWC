import { LightningElement, wire } from 'lwc';
import accId from '@salesforce/apex/fetchContact.fetchContact1';
const column = [
    { label: "First Name", fieldName: "FirstName" },
    { label: "Last Name", fieldName: "LastName" },
    { label: "Email", fieldName: "Email" }

]
export default class Q6getAllContact extends LightningElement {
    column=column;
    data1=[];
    @wire(accId,{accountIdd:'001g5000008SnIvAAK'})
    fafdf({error,data}){
        if(data){
            this.data1=data;
        }
        else{
            console.log(error);
        }
    }

}