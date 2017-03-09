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
        this.isValidated = false;
    }

    async NavigatingNext(): Promise<boolean> {
        let selectedScribeOrganization: ScribeOrganization = this.scribeOrganizations.find(x => x.id === this.scribeOrganizationId);
        this.MS.DataStore.addToDataStore('ScribeApiToken', selectedScribeOrganization.apiToken, DataStoreType.Private);
        this.MS.DataStore.addToDataStore('ScribeOrganizationId', selectedScribeOrganization.id, DataStoreType.Private);
        return true;
    }

    async OnValidate(): Promise<boolean> {
        super.Invalidate();

        this.MS.DataStore.addToDataStore('ScribeUsername', this.scribeUsername, DataStoreType.Private);
        this.MS.DataStore.addToDataStore('ScribePassword', this.scribePassword, DataStoreType.Private);

        let response: ActionResponse = await this.MS.HttpService.executeAsync('Microsoft-GetScribeOrganizations', {});

        if (response.IsSuccess) {
            this.scribeOrganizations = JSON.parse(response.Body.value);
            this.isValidated = true;
            this.showValidation = true;
        } else {
            return false;
        }

        return true;
    }
}