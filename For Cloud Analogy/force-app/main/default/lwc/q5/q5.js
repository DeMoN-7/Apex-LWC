import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class Q5 extends LightningElement {
    handleClick() {
        this.dispatchEvent(new ShowToastEvent({
            title: 'Success',
            message: 'Toast Message',
            variant: 'success',
        }));
}
}