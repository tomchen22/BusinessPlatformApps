import { ViewModelBase } from '../../common/web/services/viewmodelbase';

export class Customize extends ViewModelBase {
    dailyTrigger: string = '2:00';
    dailyTriggers: string[] = [];

    constructor() {
        super();
        this.dailyTriggers = this.MS.UtilityService.GenerateDailyTriggers();
        this.isValidated = false;
        this.useDefaultValidateButton = true;
    }

    OnValidate() {
        super.OnValidate();

        this.MS.DataService.AddToDataStore('SAP', 'TaskDescription', 'Power BI Solution Template - Simplement SAP AR');
        this.MS.DataService.AddToDataStore('SAP', 'TaskDirectory', 'Simplement, Inc\\Solution Template AR');
        this.MS.DataService.AddToDataStore('SAP', 'TaskFile', 'Simplement.SolutionTemplate.AR.exe');
        this.MS.DataService.AddToDataStore('SAP', 'TaskName', 'Power BI Solution Template - Simplement SAP AR');
        this.MS.DataService.AddToDataStore('SAP', 'TaskParameters', '/u');
        this.MS.DataService.AddToDataStore('SAP', 'TaskProgram', 'cmd');
        this.MS.DataService.AddToDataStore('SAP', 'TaskStartTime', this.dailyTrigger);

        this.isValidated = true;
        this.showValidation = true;
    }
}