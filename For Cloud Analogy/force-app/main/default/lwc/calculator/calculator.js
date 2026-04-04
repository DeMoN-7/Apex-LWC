import { LightningElement } from 'lwc';

export default class Calculator extends LightningElement {
    result=0;
    exp='';
    handleInput(event){
        this.exp=event.target.value;

    }

    handleClick(){
        this.result=eval(this.exp);
    }

}