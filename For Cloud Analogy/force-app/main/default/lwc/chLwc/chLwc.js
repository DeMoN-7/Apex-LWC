import { LightningElement } from 'lwc';

export default class ChLwc extends LightningElement {
    handlePlus(event) {
        this.dispatchEvent(new CustomEvent('add'));
    }
    handleMinus(event) {
        this.dispatchEvent(new CustomEvent('subtract'));
    }
    mul10(event) {
        this.dispatchEvent(new CustomEvent('mul10',{detail:event.target.value}));
    }
    mul100(event) {
        this.dispatchEvent(new CustomEvent('mul100',{detail:event.target.value}));
    }
}