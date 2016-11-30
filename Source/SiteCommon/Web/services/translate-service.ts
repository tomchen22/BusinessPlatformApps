import MainService from './mainservice';

import { Language } from '../localization/language';

import { EN_US } from '../localization/en-us';

export class TranslateService {
    language: any = null;
    MS: MainService;

    constructor(MainService: MainService, language: string) {
        this.MS = MainService;
        switch (language) {
            case Language.EN_US:
                this.language = EN_US;
                break;
            default:
                this.language = EN_US;
        }
    }
}