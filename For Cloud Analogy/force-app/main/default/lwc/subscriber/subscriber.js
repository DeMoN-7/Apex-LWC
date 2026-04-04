import { LightningElement, wire } from 'lwc';
import samplemess from '@salesforce/messageChannel/first__c';
import {subscribe,MessageContext, APPLICATION_SCOPE, unsubscribe} from 'lightning/messageService';
export default class Subscriber extends LightningElement {
    temp="";
    subscription;

    @wire(MessageContext)
    context;
    sub(){
       this.subscription=subscribe(this.context,samplemess,(message)=>{this.handleMessage(message)},{scope:APPLICATION_SCOPE});
    }
    handleMessage(message){
        this.temp=message.recordData.value? message.recordData.value :"No Message";
    }
    unsub(){

        unsubscribe(this.subscription)
        this.subscription=null;
    }
}