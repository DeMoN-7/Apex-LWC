import { LightningElement } from 'lwc';

export default class Q3 extends LightningElement {
    temptask = '';
    task = [];

    saveValue(event) {
        this.temptask = event.target.value;
    }

    addTask() {
        if (this.temptask) {
            this.task = [...this.task, this.temptask]; 
            this.temptask = '';
        }
    }

    removeTask() {
        this.task = this.task.slice(0, -1); 
    }
}