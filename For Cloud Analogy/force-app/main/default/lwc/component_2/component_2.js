import { LightningElement , api} from 'lwc';

export default class Component_2 extends LightningElement {
    @api ff="Non Exposed Component";
    @api handleChange(){
        this.ff="Component Changed ";
    }
}