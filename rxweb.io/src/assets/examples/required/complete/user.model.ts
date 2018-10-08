import {  required,prop,} from "@rxweb/reactive-form-validators"

export class User {

	@required() 
	firstName: string;
	@required({conditionalExpression:x => x.firstName == "John" }) 
	lastName: string;
	@required({message:'Username cannot be blank.' }) 
	userName: string;
}
