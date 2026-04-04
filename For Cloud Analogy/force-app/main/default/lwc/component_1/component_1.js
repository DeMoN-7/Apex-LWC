import { LightningElement } from 'lwc';

export default class Component_1 extends LightningElement {
    og='Hello Ayush ';
    handleChange(){
      this.template.querySelector('c-component_2').handleChange();  
    }

    constructor(){
        super();
        console.log("This is  parent constructor");
    }
    renderedCallback(){
        console.log("This is parent rendered callback");
    }
    connectedCallback(){
        console.log("This is parent connected Callback");
    }
    
    disconnectedCallback(){
        console.log("This is parent disconnected callback");
    }
    errorCallback(){
        console.log("this is parent error callback");
    }
}