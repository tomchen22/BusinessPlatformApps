import { ProgressViewModel } from '../../common/web/directives/progresstemplate';

export class ProgressVM extends ProgressViewModel {
    constructor() {
        super();
        this.showCounts = true;
        this.successMessage = 'Data is now pulling! Meanwhile you can download your Power BI report and start exploring your data.';
        this.targetSchema = 'sap';
    }

    async OnLoaded() {
        let body: any = {};
        body.FileName = 'SAPSolutionTemplate.pbix';
        body.SqlServerIndex = 1; 

        let response = await this.MS.HttpService.Execute('Microsoft-WranglePBI', body);
        if (response.isSuccess) {
            this.pbixDownloadLink = response.response.value;
            this.isPbixReady = true;
        }

        super.OnLoaded();
    }
}