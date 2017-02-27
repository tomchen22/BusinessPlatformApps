import { ViewModelBase } from '../../../../../SiteCommon/Web/services/viewmodelbase'
import { DataStoreType } from '../../../../../SiteCommon/Web/services/datastore'

export class CognitiveText extends ViewModelBase {


    isBingChecked: boolean = false;


    constructor() {
        super();
        this.isValidated = false;
    }

    verifyBing() {
        this.isValidated = this.isBingChecked;
    }

}