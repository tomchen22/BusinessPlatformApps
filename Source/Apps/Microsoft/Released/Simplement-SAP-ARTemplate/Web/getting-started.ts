import { GettingStartedViewModel } from '../../common/web/directives/gettingstartedtemplate';

export class GettingStarted extends GettingStartedViewModel {
    constructor() {
        super();
        this.architectureDiagram = 'dist/Template/Simplement-SAP-ARTemplate/Web/Images/sap-simplement-architecture-diagram.png';
        this.features = [
            'Scalable and extensible solution with minimum set up and maintenance considerations',
            'Data pulled daily from SAP & stored in a database optimized for reporting',
            'Import data into powerful Power BI reports'
        ];
        this.isDownload = !this.MS.HttpService.isOnPremise;
        this.requirements = [
            'Read access to the SAP Database',
            'Azure Subscription (to use Azure SQL)',
            'Power BI Pro (to share the template with your organization)',
            'Power BI Desktop (latest version)'
        ];
        this.subTitle = 'Welcome to the public preview of the Power BI solution template for SAP AR.';
        this.templateName = 'SAP AR Connector';
    }
}