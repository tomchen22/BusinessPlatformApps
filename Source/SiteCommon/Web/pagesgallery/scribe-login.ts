import { ScribeOrganization } from '../classes/scribe-organization';

import { ActionResponse } from '../services/actionresponse';
import { DataStoreType } from '../services/datastore';
import { ViewModelBase } from '../services/viewmodelbase';

export class ScribeLogin extends ViewModelBase {
    scribeUsername: string = '';
    scribePassword: string = '';
    scribeOrganizations: ScribeOrganization[] = [];
    scribeOrganizationId: string = '';

    constructor() {
        super();
    }

    async OnValidate(): Promise<boolean> {
        this.MS.DataStore.addToDataStore('ScribeUsername', this.scribeUsername, DataStoreType.Private);
        this.MS.DataStore.addToDataStore('ScribePassword', this.scribePassword, DataStoreType.Private);

        let response = this.MS.HttpService.executeAsync('Microsoft-GetScribeOrganizations', {});

        return true;
    }
}