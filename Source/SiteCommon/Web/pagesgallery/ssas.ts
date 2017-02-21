import { DataStoreType } from '../services/datastore';
import { ViewModelBase } from '../services/viewmodelbase';

export class Customize extends ViewModelBase {
    ssasEnabled: string = 'false';

    async OnLoaded() {
    }

    async OnValidate(): Promise<boolean> {
        this.isValidated = true;
        this.showValidation = false;
        return true;
    }

    async NavigatingNext(): Promise<boolean> {
        this.MS.DataStore.addToDataStore('ssasEnabled', this.ssasEnabled, DataStoreType.Public);
        return true;
    }
}