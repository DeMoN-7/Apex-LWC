import { LightningElement } from 'lwc';

export default class Lifecyclehooks extends LightningElement {
    constructor(){
        super();
        console.log("This is constructor");
    }
    renderedCallback(){
        console.log("This is rendered callback");
    }
    connectedCallback(){
        console.log("This is connected Callback");
    }
    
    disconnectedCallback(){
        console.log("This is disconnected callback");
    }
    errorCallback(){
        console.log("this is error callback");
    }
}