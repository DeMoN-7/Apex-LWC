import { LightningElement } from 'lwc';

export default class HideShow extends LightningElement {
    show=false;
    buttonValue="Show";
    handleClick(){
        if(this.show)
        {
        this.show = false;
        this.buttonValue="Show";
        }
            

        else{
        this.show = true;
        this.buttonValue="Hide";
        }
            
    }
}