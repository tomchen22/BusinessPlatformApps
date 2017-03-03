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

    async NavigatingNext(): Promise<boolean> {
        if (!super.NavigatingNext()) {
            return false;
        }
        let body: any = {};
        let response = await this.MS.HttpService.executeAsync('Microsoft-RegisterCognitiveServices', body);
        if (!response.IsSuccess) {
            return false;
        }

        return true;
    }

}