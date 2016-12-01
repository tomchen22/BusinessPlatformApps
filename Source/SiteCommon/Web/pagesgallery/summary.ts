import { ViewModelBase } from '../services/viewmodelbase';

export class SummaryViewModel extends ViewModelBase {
    summaryRows:EntryRow[];
    values: any = {};


    constructor() {
        super();
    }

    loadSummaryObjectIntoRows() {
        this.textNext = this.MS.Translate.COMMON_RUN;
        this.summaryRows = new Array<EntryRow>();
        let entryRow: EntryRow = new EntryRow();
        for (let text in this.values) {
            if (this.values.hasOwnProperty(text) && this.values[text]) {
                entryRow.entries.push(new Entry(text, this.values[text]));
                if (entryRow.entries.length > 2) {
                    this.summaryRows.push(entryRow);
                    entryRow = new EntryRow();
                }
            }
        }
        if (entryRow.entries.length > 0) {
            this.summaryRows.push(entryRow);
        }
    }

    async OnLoaded(): Promise<void> {
        this.loadSummaryObjectIntoRows();
    }
}

class Entry {
    text: string;
    value: string;

    constructor(text: string, value: string) {
        this.text = text;
        this.value = value;
    }
}

class EntryRow {
    entries: Entry[] = [];
}