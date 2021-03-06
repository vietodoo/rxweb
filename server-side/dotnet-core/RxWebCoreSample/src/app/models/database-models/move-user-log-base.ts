import { prop,propObject,propArray,required,maxLength,range  } from "@rxweb/reactive-form-validators"
import { gridColumn } from "@rxweb/grid"


export class MoveUserLogBase {

//#region moveUserLogId Prop
        @prop()
        moveUserLogId : number;
//#endregion moveUserLogId Prop


//#region moveBatchId Prop
        @range({minimumNumber:1,maximumNumber:2147483647})
        @required()
        moveBatchId : number;
//#endregion moveBatchId Prop


//#region userId Prop
        @range({minimumNumber:1,maximumNumber:2147483647})
        @required()
        userId : number;
//#endregion userId Prop


//#region oldParentId Prop
        @range({minimumNumber:1,maximumNumber:2147483647})
        @required()
        oldParentId : number;
//#endregion oldParentId Prop


//#region newParentId Prop
        @range({minimumNumber:1,maximumNumber:2147483647})
        @required()
        newParentId : number;
//#endregion newParentId Prop



}