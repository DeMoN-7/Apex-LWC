import { LightningElement } from 'lwc';

export default class ParentLWC extends LightningElement {
    count=0;
    handleAdd(event){
        this.count+=1;
    }
    handleSub(event){
        this.count-=1;
    }
    handleMul10(event){
        this.count*=event.detail;
    }
    handleMul100(event){
        this.count*=event.detail;
        
    }
}