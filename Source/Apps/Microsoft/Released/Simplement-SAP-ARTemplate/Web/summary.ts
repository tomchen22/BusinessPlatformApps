import { SummaryViewModel } from '../../common/web/directives/summarytemplate';

export class Summary extends SummaryViewModel {
    constructor() {
        super();

        let payload = {
            'Target Sql Server': this.MS.DataService.GetItemFromDataStore('sql-target.html', 'Server'),
            'Target Sql Database': this.MS.DataService.GetItemFromDataStore('sql-target.html', 'Database'),
            'Target Sql Username': this.MS.DataService.GetItemFromDataStore('sql-target.html', 'Username')
        };

        this.init(payload);
    }
}