import { DataStoreType } from '../services/datastore';
import { ViewModelBase } from '../services/viewmodelbase';

export class Customize extends ViewModelBase {
    ssasEnabled: string = 'false';

    async OnLoaded() {
        this.isValidated = true;
        this.showValidation = false;
    }

    async OnValidate(): Promise<boolean> {
        this.isValidated = true;
        this.showValidation = false;
        return true;
    }

    async NavigatingNext(): Promise<boolean> {
        if (this.ssasEnabled === 'true') {
            this.MS.DataStore.addToDataStore('ssasEnabled', 'false', DataStoreType.Public);
        } else {
            this.MS.DataStore.addToDataStore('ssasEnabled', 'true', DataStoreType.Public);
        }
       
        return true;
    }
}