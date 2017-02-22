import { DataStoreType } from '../services/datastore';
import { ViewModelBase } from '../services/viewmodelbase';

export class Customize extends ViewModelBase {
    ssasType: string = 'New';
    server: string = '';
    email: string = '';
    password: string ='';
    sku: string = 'D1';

    Invalidate() {
        super.Invalidate();
    }

    async OnLoaded() {
       let response = await this.MS.HttpService.executeAsync('Microsoft-GetEmail', {});
        this.email = response.Body.value;
    }

    async OnValidate(): Promise<boolean> {
        this.isValidated = true;
        this.showValidation = false;
        return true;
    }

    async NavigatingNext(): Promise<boolean> {
        return true;
    }
}