import { LightningElement ,wire,api} from 'lwc';
import hello from '@salesforce/apex/forPractice.forPractice1';

export default class WirePractice extends LightningElement {
    @api message='Message from lwc';
    @wire(hello)
    wiredata({error,data}){
        this.message=data;
    }
}