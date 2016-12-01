import { ViewModelBase } from '../services/viewmodelbase';

export class Gettingstarted extends ViewModelBase {
    architectureDiagram: string = '';
    downloadLink: string = '';
    isDownload: boolean = false;
    list1: string[] = [];
    list2: string[] = [];
    list1Title: string = this.MS.Translate.GETTING_STARTED_LIST_1;
    list2Title: string = this.MS.Translate.GETTING_STARTED_LIST_2;
    registration: string = '';
    registrationAccepted: boolean = false;
    registrationAction: string = '';
    registrationCompany: string = '';
    registrationEmail: string = '';
    registrationEmailConfirmation: string = '';
    registrationEmailsToBlock: string = '';
    registrationError: string = '';
    registrationLink: string = '';
    registrationNameFirst: string = '';
    registrationNameLast: string = '';
    registrationPrivacy: string = '';
    registrationPrivacyTitle: string = '';
    registrationValidation: string = '';
    showPrivacy: boolean = true;
    subtitle: string = '';
    templateName: string = '';

    constructor() {
        super();
    }

    async GetDownloadLink() {
        let response = await this.MS.HttpService.executeAsync('Microsoft-GetMsiDownloadLink');
        this.downloadLink = response.Body.value;
    }

    async OnLoaded() {
        if (this.isDownload && !this.registration) {
            this.GetDownloadLink();
        }
    }

    async Register() {
        this.registrationError = '';

        this.registrationNameFirst = this.registrationNameFirst.trim();
        this.registrationNameLast = this.registrationNameLast.trim();
        this.registrationCompany = this.registrationCompany.trim();
        this.registrationEmail = this.registrationEmail.trim();
        this.registrationEmailConfirmation = this.registrationEmailConfirmation.trim();

        if (this.registrationNameFirst.length === 0 ||
            this.registrationNameLast.length === 0 ||
            this.registrationCompany.length === 0 ||
            this.registrationEmail.length === 0 ||
            this.registrationEmail !== this.registrationEmailConfirmation ||
            this.registrationEmail.indexOf('@') === -1) {
            this.registrationError = this.MS.Translate.GETTING_STARTED_REGISTRATION_ERROR;
        }

        if (!this.registrationError) {
            let emailsToBlock: string[] = this.registrationEmailsToBlock.split(',');
            for (let i = 0; i < emailsToBlock.length && !this.registrationError; i++) {
                let pattern: any = new RegExp(`.*${emailsToBlock[i]}`);
                if (pattern.test(this.registrationEmail)) {
                    this.registrationError = this.MS.Translate.GETTING_STARTED_REGISTRATION_ERROR_EMAIL;
                }
            }
        }

        if (!this.registrationError) {
            await this.MS.HttpService.executeAsync(this.registrationAction, { isInvisible: true });
            this.registration = '';
            this.GetDownloadLink();
        }
    }
}