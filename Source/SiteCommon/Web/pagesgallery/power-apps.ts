import { DataStoreType } from '../services/datastore';
import { ViewModelBase } from '../services/viewmodelbase';

export class PowerApps extends ViewModelBase {
    async OnLoaded() {
        let response = await this.MS.HttpService.executeAsync('Microsoft-GetAllEnvironments');
        console.log(response);
    }
}