import { LightningElement,wire } from 'lwc';
import {publish,MessageContext} from 'lightning/messageService';
import samplemess from '@salesforce/messageChannel/first__c';
export default class Publisher extends LightningElement {
    data;
    inputHandler(event){
        this.data=event.target.value;
    }
    @wire(MessageContext)
    context;

    publishclick(){
        const message={recordData:{value:this.data}};
        publish(this.context,samplemess,message);
    }
}