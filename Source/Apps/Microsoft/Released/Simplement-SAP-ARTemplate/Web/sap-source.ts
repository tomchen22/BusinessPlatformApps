import { ViewModelBase } from '../../common/web/services/viewmodelbase';

export class SapSource extends ViewModelBase {
    applicationServer: string = '';
    //arPostingsFrom: Date;
    client: number = 800;
    executeAsCurrentUser: boolean = true;
    instanceNumber: string = '00';
    language: string = 'EN';
    languages: string[] = [];
    password: string = '';
    rowBatchSize: number = 250000;
    sapRouterString: string = '';
    showAdvanced: boolean = false;
    systemId: string = 'ZZZ';
    user: string = '';
    windowsUsername: string = '';
    windowsPassword: string = '';

    constructor() {
        super();
        this.languages = [
            'AF', 'AR', 'BG', 'CA', 'CS', 'DA', 'DE', 'EL', 'EN', 'ES', 'ET', 'FI', 'FR', 'HE',
            'HR', 'HU', 'ID', 'IS', 'IT', 'JA', 'KO', 'LT', 'LV', 'MS', 'NL', 'NO', 'PL', 'PT',
            'RO', 'RU', 'SH', 'SK', 'SL', 'SR', 'SV', 'TH', 'TR', 'UK', 'Z1', 'ZF', 'ZH'
        ];
        this.isValidated = false;
    }

    async NavigatingNext(): Promise<boolean> {
        this.storeCredentials();
        return super.NavigatingNext();
    }

    async OnValidate() {
        super.OnValidate();
        this.storeCredentials();

        this.isValidated = await this.MS.UtilityService.ValidateImpersonation(this.windowsUsername, this.windowsPassword, this.executeAsCurrentUser);

        if (this.executeAsCurrentUser) {
            await this.MS.HttpService.Execute('Microsoft-CredentialManagerWrite', {});
        } else {
            await this.MS.HttpService.ExecuteWithImpersonation('Microsoft-CredentialManagerWrite', {});
        }

        await this.MS.HttpService.Execute('Microsoft-WriteSAPJson', {});

        let responseValidate = await this.MS.HttpService.Execute('Microsoft-ValidateSAP', {});
        this.isValidated = responseValidate.isSuccess;

        if (this.isValidated) {
            this.showValidation = true;
        }
    }

    private storeCredentials() {
        this.MS.DataService.AddToDataStore('SAP', 'CredentialTarget', 'Simplement.SolutionTemplate.AR.SAP');
        this.MS.DataService.AddToDataStore('SAP', 'CredentialUsername', this.user);
        this.MS.DataService.AddToDataStore('SAP', 'CredentialPassword', this.password);

        this.MS.DataService.AddToDataStore('SAP', 'RowBatchSize', this.rowBatchSize);
        this.MS.DataService.AddToDataStore('SAP', 'SapClient', this.client);
        this.MS.DataService.AddToDataStore('SAP', 'SapHost', this.applicationServer);
        this.MS.DataService.AddToDataStore('SAP', 'SapLanguage', this.language);
        this.MS.DataService.AddToDataStore('SAP', 'SAPPassword', this.password);
        this.MS.DataService.AddToDataStore('SAP', 'SapRouterString', this.sapRouterString);
        this.MS.DataService.AddToDataStore('SAP', 'SapSystemId', this.systemId);
        this.MS.DataService.AddToDataStore('SAP', 'SapSystemNumber', this.instanceNumber);
        this.MS.DataService.AddToDataStore('SAP', 'SapUser', this.user);
        this.MS.DataService.AddToDataStore('SAP', 'SqlConnectionString', '');
    }
}