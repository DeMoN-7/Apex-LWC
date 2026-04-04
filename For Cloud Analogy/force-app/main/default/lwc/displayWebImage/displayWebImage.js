import { LightningElement,wire  } from 'lwc';
import fetchUsers from '@salesforce/apex/fetchUsers.fetchUser';
export default class DisplayWebImage extends LightningElement {
    users;
    @wire(fetchUsers)
    wiredUsers({data }) {
        if (data) {
    this.users = data;
          
        }
    }
    handleClick(event){
        
    }
}