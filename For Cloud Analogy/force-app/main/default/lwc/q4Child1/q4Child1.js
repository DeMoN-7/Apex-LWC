import { LightningElement, api } from 'lwc';

export default class Q4Child1 extends LightningElement {
    @api handleClick(event) {
        if (event.target.label == 'Deselected') {
            event.target.label = 'Selected';
        }
        else if (event.target.label == 'Selected') {
            event.target.label = 'Deselected';
        }
    }
}