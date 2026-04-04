import { LightningElement } from 'lwc';

export default class QuerySelectordemo extends LightningElement {
    firstName="";
    handleClick(){
        this.firstName = this.template.querySelector('lightning-input').value;
    }
}