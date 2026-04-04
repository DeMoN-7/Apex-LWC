import { LightningElement } from 'lwc';

export default class Q2 extends LightningElement {
    firstName;
    lastName;
    email;
    phone;
    title;

    saveValue(event) {
        if (event.target.label == "FirstName") {
            this.firstName = event.target.value;
        }
        if (event.target.label == "LastName") {
            this.lastName = event.target.value;
        }
        if (event.target.label == "Email") {
            this.email = event.target.value;
        }
        if (event.target.label == "Phone") {
            this.phone = event.target.value;
        }
        if(event.target.label == "Title"){
            this.title = event.target.value;
        }
    }
    debugLog(){
    console.log(this.firstName, this.lastName, this.email, this.phone, this.title);

    }
   

}