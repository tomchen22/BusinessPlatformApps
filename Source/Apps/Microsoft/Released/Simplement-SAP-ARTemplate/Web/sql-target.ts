import { SqlServerViewModel } from '../../common/web/directives/sqlservertemplate';

export class SqlTarget extends SqlServerViewModel {
    constructor() {
        super();
        this.showAllWriteableDatabases = true;
        this.subtitle = 'Set up a connection to SQL so we can bring in your SAP data.';
        this.title = 'Connect to your SQL Database';
    }

    async NavigatingNext(): Promise<boolean> {
        this.MS.DataService.AddToDataStore('SAP', 'CredentialTarget', 'Simplement.SolutionTemplate.AR.SQL');
        this.MS.DataService.AddToDataStore('SAP', 'CredentialUsername', this.username);
        this.MS.DataService.AddToDataStore('SAP', 'CredentialPassword', this.password);

        this.MS.DataService.AddToDataStore('SAP', 'SqlConnectionString', `Data Source=${this.sqlServer};Initial Catalog=${this.database}`);
        await this.MS.HttpService.Execute('Microsoft-WriteSAPJson', {});

        let impersonation = this.MS.DataService.GetItemFromDataStore('Credentials', 'ImpersonationUsername');
        let response: any;
        if (impersonation && impersonation.length > 0) {
            response = await this.MS.HttpService.ExecuteWithImpersonation('Microsoft-CredentialManagerWrite', {});
        } else {
            response = await this.MS.HttpService.Execute('Microsoft-CredentialManagerWrite', {});
        }

        if (response.isSuccess) {
            return super.NavigatingNext();
        }

        return false;
    }
}